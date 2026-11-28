;;; zenburn-face-audit.el --- Find faces the theme leaves unstyled -*- lexical-binding: t -*-

;;; Commentary:
;;
;; A face whose default spec names a color ("red", "#ff0000") shows that
;; color no matter what theme is enabled, unless the theme overrides it.
;; Faces that only inherit from other faces follow the theme on their own.
;; So the faces worth auditing are the ones with a color in their `defface',
;; and that can be read off the source without loading anything.
;;
;; The test suite uses this to check the faces that ship with Emacs.
;; `zenburn-face-audit-report' does the same for third-party packages
;; and is meant to be run by hand, via "eldev audit-faces".
;;

;;; Code:

(require 'jka-compr)
(require 'package)

(defconst zenburn-face-audit-packages
  '(magit company corfu vertico consult flycheck lsp-mode markdown-mode
          helm helm-core ivy swiper counsel)
  "Third-party packages that should be fully themed.")

(defun zenburn-face-audit--colors (form)
  "Return the color names that appear as strings anywhere in FORM."
  (cond ((stringp form) (and (color-defined-p form) (list form)))
        ((consp form) (append (zenburn-face-audit--colors (car form))
                              (zenburn-face-audit--colors (cdr form))))
        ((vectorp form) (zenburn-face-audit--colors (append form nil)))))

(defvar zenburn-face-audit--aliases nil
  "Alist of (FACE . OLD-NAME) for the obsolete face aliases seen so far.
A theme that still uses the old name of a face does style it, since Emacs
resolves the alias, so the audit has to know about these.")

(defun zenburn-face-audit--scan-file (file)
  "Return a (FACE . COLORS) entry for every `defface' form in FILE.
COLORS are the colors the face's default spec hardcodes, if any.  Obsolete
face aliases are recorded in `zenburn-face-audit--aliases' on the way."
  (with-temp-buffer
    (let ((jka-compr-verbose nil))
      (insert-file-contents file))
    (while (re-search-forward
            "(define-obsolete-face-alias[ \t\n]+'\\([^ \t\n]+\\)[ \t\n]+'\\([^ \t\n)]+\\)"
            nil t)
      (push (cons (intern (match-string 2)) (intern (match-string 1)))
            zenburn-face-audit--aliases))
    (goto-char (point-min))
    (let (faces)
      (while (re-search-forward "^[ \t]*(defface[ \t\n]" nil t)
        (let ((resume (point))
              (form (progn (goto-char (match-beginning 0))
                           (skip-chars-forward " \t")
                           (ignore-errors (read (current-buffer))))))
          (if (and (eq (car-safe form) 'defface)
                   (proper-list-p form)
                   (symbolp (nth 1 form)))
              (push (cons (nth 1 form)
                          (delete-dups
                           (zenburn-face-audit--colors (nth 2 form))))
                    faces)
            (goto-char resume))))
      (nreverse faces))))

(defun zenburn-face-audit-scan (directory)
  "Return a (FACE . COLORS) entry for every face defined under DIRECTORY.
Obsolete libraries and generated files are left out."
  (let (faces)
    (dolist (file (directory-files-recursively
                   directory "\\.el\\(?:\\.gz\\)?\\'"))
      (unless (string-match-p
               "/obsolete/\\|loaddefs\\|-autoloads\\.el\\|-pkg\\.el" file)
        (setq faces (nconc faces (zenburn-face-audit--scan-file file)))))
    faces))

(defun zenburn-face-audit-lisp-directory ()
  "Return the directory with the Lisp sources of Emacs, or nil.
Some Emacs installations ship only the compiled files."
  (let ((source (locate-library "simple.el" t)))
    (and source (file-name-directory source))))

(defun zenburn-face-audit--themed-p (theme face)
  "Return non-nil if THEME styles FACE, under its name or an obsolete one."
  (or (assq theme (get face 'theme-face))
      (let (found)
        (dolist (alias zenburn-face-audit--aliases found)
          (when (and (eq (car alias) face)
                     (assq theme (get (cdr alias) 'theme-face)))
            (setq found t))))))

(defun zenburn-face-audit-unthemed (theme faces)
  "Return the faces among FACES that hardcode a color THEME doesn't override.
FACES is a list of (FACE . COLORS) entries, as returned by
`zenburn-face-audit-scan'.  THEME has to be loaded already."
  (let (missing)
    (dolist (entry faces)
      (when (and (cdr entry)
                 (not (zenburn-face-audit--themed-p theme (car entry))))
        (push (car entry) missing)))
    (sort (delete-dups missing) #'string<)))

(defun zenburn-face-audit--install (packages directory)
  "Install PACKAGES into DIRECTORY, leaving the user's packages alone."
  (let ((package-user-dir directory)
        (package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                            ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                            ("melpa" . "https://melpa.org/packages/")))
        (package-check-signature nil)
        (inhibit-message t))
    (package-initialize)
    (package-refresh-contents)
    (dolist (package packages)
      (unless (package-installed-p package)
        (package-install package)))))

(defun zenburn-face-audit-report (theme &optional packages)
  "Report the faces of PACKAGES that hardcode a color THEME doesn't override.
PACKAGES defaults to `zenburn-face-audit-packages'.  They are
installed into a scratch directory under .eldev, so nothing here touches
the packages of whoever runs it."
  (let ((packages (or packages zenburn-face-audit-packages))
        (directory (expand-file-name ".eldev/face-audit")))
    (zenburn-face-audit--install packages directory)
    (load-theme theme t)
    (dolist (package packages)
      (let* ((dir (car (file-expand-wildcards
                        (format "%s/%s-[0-9]*" directory package))))
             (faces (and dir (zenburn-face-audit-scan dir)))
             (missing (zenburn-face-audit-unthemed theme faces)))
        (princ (format "%s: %d faces, %d with a color of their own, %d of those unthemed\n"
                       package (length faces)
                       (length (delq nil (mapcar #'cdr faces)))
                       (length missing)))
        (dolist (face missing)
          (princ (format "  %s  %s\n" face
                         (mapconcat #'identity (cdr (assq face faces)) " "))))))))

(provide 'zenburn-face-audit)

;;; zenburn-face-audit.el ends here
