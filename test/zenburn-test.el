;;; zenburn-test.el --- Tests for zenburn-theme -*- lexical-binding: t -*-

;;; Commentary:
;;
;; Buttercup test suite for the Zenburn theme.
;;
;; Face assertions read directly from the `theme-face' property rather
;; than going through `face-attribute' - in batch mode, faces aren't
;; recomputed to reflect theme specs, so `face-attribute' would miss
;; what the theme actually sets.  `theme-face' is the source of truth.
;;

;;; Code:

(require 'buttercup)

;; Make the theme loadable from the project root.
(let ((dir (file-name-directory
            (or load-file-name buffer-file-name default-directory))))
  (add-to-list 'custom-theme-load-path
               (expand-file-name ".." dir)))

(defun zenburn-test--reload ()
  "Disable and (re-)load the Zenburn theme.
Reloading re-evaluates the theme file, which picks up any let-bound
customization the caller wants to exercise (heading scaling, color
overrides, variable pitch, ...)."
  (when (custom-theme-enabled-p 'zenburn)
    (disable-theme 'zenburn))
  (put 'zenburn 'theme-settings nil)
  (put 'zenburn 'theme-face nil)
  (setq custom-known-themes (delq 'zenburn custom-known-themes))
  (load-theme 'zenburn t))

(defun zenburn-test--face-attr (face attr)
  "Return ATTR from FACE's theme-face spec for Zenburn, or nil.
Reads directly from the theme-face property so we don't depend on
frame-side face recomputation (which is unreliable in batch)."
  (let* ((theme-face (get face 'theme-face))
         (entry      (assoc 'zenburn theme-face))
         (specs      (cadr entry))
         (first      (car specs))
         (props      (cadr first)))
    (plist-get props attr)))

;;; Theme loading smoke test

(describe "theme loading"
  (after-each
    (when (custom-theme-enabled-p 'zenburn)
      (disable-theme 'zenburn)))

  (it "loads without error"
    (expect (load-theme 'zenburn t) :to-be-truthy)
    (expect (custom-theme-enabled-p 'zenburn) :to-be-truthy)))

;;; Palette integrity

(describe "color palettes"
  (it "have hex-formatted values in the positional palette"
    (dolist (entry zenburn-default-colors-alist)
      (expect (cdr entry) :to-match "\\`#[0-9a-fA-F]\\{6\\}\\'")))

  (it "resolve every semantic color to a known palette entry or hex"
    (dolist (entry zenburn-default-semantic-colors-alist)
      (let ((value (cdr entry)))
        (if (symbolp value)
            (expect (assoc (symbol-name value) zenburn-default-colors-alist)
                    :not :to-be nil)
          (expect value :to-match "\\`#[0-9a-fA-F]\\{6\\}\\'"))))))

;;; Heading scaling

(describe "zenburn-scale-org-headlines"
  (after-each
    (when (custom-theme-enabled-p 'zenburn)
      (disable-theme 'zenburn)))

  (describe "when enabled"
    (before-each
      (let ((zenburn-scale-org-headlines t))
        (zenburn-test--reload)))

    (it "scales org-level-1..4"
      (expect (zenburn-test--face-attr 'org-level-1 :height) :to-equal zenburn-height-plus-4)
      (expect (zenburn-test--face-attr 'org-level-2 :height) :to-equal zenburn-height-plus-3)
      (expect (zenburn-test--face-attr 'org-level-3 :height) :to-equal zenburn-height-plus-2)
      (expect (zenburn-test--face-attr 'org-level-4 :height) :to-equal zenburn-height-plus-1))

    (it "leaves org-level-5..8 without a :height"
      (dolist (face '(org-level-5 org-level-6 org-level-7 org-level-8))
        (expect (zenburn-test--face-attr face :height) :to-be nil)))

    (it "scales org-document-title"
      (expect (zenburn-test--face-attr 'org-document-title :height) :to-equal zenburn-height-plus-4)))

  (describe "when disabled (default)"
    (before-each
      (let ((zenburn-scale-org-headlines nil))
        (zenburn-test--reload)))

    (it "leaves org-level-1..4 without a :height"
      (dolist (face '(org-level-1 org-level-2 org-level-3 org-level-4))
        (expect (zenburn-test--face-attr face :height) :to-be nil)))

    (it "leaves org-document-title without a :height"
      (expect (zenburn-test--face-attr 'org-document-title :height) :to-be nil))))

(describe "zenburn-scale-outline-headlines"
  (after-each
    (when (custom-theme-enabled-p 'zenburn)
      (disable-theme 'zenburn)))

  (describe "when enabled"
    (before-each
      (let ((zenburn-scale-outline-headlines t))
        (zenburn-test--reload)))

    (it "scales outline-1..4"
      (expect (zenburn-test--face-attr 'outline-1 :height) :to-equal zenburn-height-plus-4)
      (expect (zenburn-test--face-attr 'outline-2 :height) :to-equal zenburn-height-plus-3)
      (expect (zenburn-test--face-attr 'outline-3 :height) :to-equal zenburn-height-plus-2)
      (expect (zenburn-test--face-attr 'outline-4 :height) :to-equal zenburn-height-plus-1))

    (it "leaves outline-5..8 without a :height"
      (dolist (face '(outline-5 outline-6 outline-7 outline-8))
        (expect (zenburn-test--face-attr face :height) :to-be nil))))

  (describe "when disabled (default)"
    (before-each
      (let ((zenburn-scale-outline-headlines nil))
        (zenburn-test--reload)))

    (it "leaves outline-1..4 without a :height"
      (dolist (face '(outline-1 outline-2 outline-3 outline-4))
        (expect (zenburn-test--face-attr face :height) :to-be nil)))))

;;; Variable pitch toggle

(describe "zenburn-use-variable-pitch"
  (after-each
    (when (custom-theme-enabled-p 'zenburn)
      (disable-theme 'zenburn)))

  (it "inherits variable-pitch when enabled"
    (let ((zenburn-use-variable-pitch t))
      (zenburn-test--reload))
    (expect (zenburn-test--face-attr 'zenburn-variable-pitch :inherit)
            :to-equal 'variable-pitch))

  (it "inherits default when disabled (default)"
    (let ((zenburn-use-variable-pitch nil))
      (zenburn-test--reload))
    (expect (zenburn-test--face-attr 'zenburn-variable-pitch :inherit)
            :to-equal 'default)))

;;; Color overrides

(describe "zenburn-override-colors-alist"
  (after-each
    (when (custom-theme-enabled-p 'zenburn)
      (disable-theme 'zenburn)))

  (it "flows a positional override through to faces"
    (let ((zenburn-override-colors-alist '(("zenburn-bg" . "#123456"))))
      (zenburn-test--reload))
    (expect (zenburn-test--face-attr 'default :background) :to-equal "#123456")))

;;; zenburn-test.el ends here
