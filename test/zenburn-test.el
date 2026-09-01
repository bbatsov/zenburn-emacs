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

(defconst zenburn-test--source-file
  (expand-file-name
   "../zenburn-theme.el"
   (file-name-directory (or load-file-name buffer-file-name default-directory)))
  "Path to the theme source, for the checks that read it as text.")

(defun zenburn-test--hex-p (color)
  "Return non-nil if COLOR is a six-digit hex string.
A few faces use named colors such as \"grey70\", which we can't measure
without a display, so they sit outside the contrast checks."
  (and (stringp color) (string-match-p "\\`#[0-9a-fA-F]\\{6\\}\\'" color)))

(defun zenburn-test--luminance (hex)
  "Return the WCAG relative luminance of the color HEX."
  (let ((channels (mapcar
                   (lambda (offset)
                     (let ((v (/ (string-to-number
                                  (substring hex offset (+ offset 2)) 16)
                                 255.0)))
                       (if (<= v 0.04045) (/ v 12.92)
                         (expt (/ (+ v 0.055) 1.055) 2.4))))
                   '(1 3 5))))
    (+ (* 0.2126 (nth 0 channels))
       (* 0.7152 (nth 1 channels))
       (* 0.0722 (nth 2 channels)))))

(defun zenburn-test--contrast (a b)
  "Return the WCAG contrast ratio between the colors A and B."
  (let* ((la (zenburn-test--luminance a))
         (lb (zenburn-test--luminance b))
         (lighter (max la lb)) (darker (min la lb)))
    (/ (+ lighter 0.05) (+ darker 0.05))))

(defun zenburn-test--color (name)
  "Return NAME's value from the default palette."
  (cdr (assoc name zenburn-default-colors-alist)))

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

;;; Package face coverage
;;
;; One entry per package: representative faces that the theme must set.
;; Guards against sections silently disappearing during refactors.

(defconst zenburn-test--package-faces
  '((asciidoc-mode asciidoc-document-title-face asciidoc-title-1-face
                   asciidoc-title-5-face asciidoc-markup-face
                   asciidoc-code-face asciidoc-link-face asciidoc-url-face
                   asciidoc-metadata-key-face asciidoc-highlight-face
                   asciidoc-admonition-note-label-face
                   asciidoc-admonition-note-face
                   asciidoc-admonition-tip-label-face
                   asciidoc-admonition-important-label-face
                   asciidoc-admonition-caution-label-face
                   asciidoc-admonition-warning-label-face
                   asciidoc-admonition-warning-face)
    (cider cider-repl-prompt-face cider-repl-stdout-face
           cider-repl-stderr-face cider-error-highlight-face
           cider-warning-highlight-face cider-stacktrace-error-class-face
           cider-stacktrace-fn-face cider-fringe-bad-face
           cider-reader-conditional-face cider-debug-prompt-face
           nrepl-message-1-face nrepl-message-8-face)
    (inf-ruby inf-ruby-result-overlay-face)
    (vundo vundo-node vundo-stem vundo-branch-stem vundo-highlight
           vundo-saved vundo-last-saved vundo-diff-highlight)
    (easy-kill easy-kill-selection easy-kill-origin)
    (copilot copilot-overlay-face)
    (mistty mistty-fringe-face)
    (keycast keycast-key keycast-command)
    (dictionary dictionary-word-entry-face dictionary-word-definition-face
                dictionary-reference-face dictionary-button-face)
    (clojure-mode clojure-keyword-face clojure-character-face
                  clojure-discard-face)
    (haskell-mode haskell-keyword-face haskell-type-face
                  haskell-constructor-face haskell-definition-face
                  haskell-operator-face haskell-pragma-face
                  haskell-hole-face haskell-error-face haskell-warning-face
                  haskell-interactive-face-prompt
                  haskell-interactive-face-compile-error
                  haskell-interactive-face-result)
    (erlang erlang-font-lock-exported-function-name-face
            erlang-edoc-heading erlang-edoc-tag erlang-edoc-macro
            erlang-edoc-verbatim erlang-edoc-todo)
    (git-timemachine git-timemachine-commit
                     git-timemachine-minibuffer-author-face
                     git-timemachine-minibuffer-detail-face)
    (gptel gptel-context-highlight-face gptel-context-deletion-face
           gptel-rewrite-highlight-face gptel-response-highlight
           gptel-response-fringe-highlight))
  "Alist of (PACKAGE . FACES) the theme is expected to cover.")

(describe "package face coverage"
  (before-all
    (zenburn-test--reload))
  (after-all
    (disable-theme 'zenburn))

  (dolist (entry zenburn-test--package-faces)
    (let ((package (car entry))
          (faces (cdr entry)))
      (it (format "themes %s" package)
        (dolist (face faces)
          (expect (assq 'zenburn (get face 'theme-face))
                  :to-be-truthy))))))
;;; Text has to be readable on its own background

(defconst zenburn-test--legibility-floor 3.0
  "Contrast a face's own text must reach against its own background.")

(defconst zenburn-test--legibility-exceptions
  '(;; the cursor's background is the cursor, not a backdrop for text
    cursor
    ;; fringe and margin indicators, drawn as a glyph or a bar rather than
    ;; text on a background
    diff-hl-change diff-hl-delete diff-hl-insert
    bm-fringe-persistent-face bm-persistent-face ctbl:face-continue-bar
    ;; deliberately receding chrome
    line-number mode-line-inactive hydra-face-amaranth
    ;; diff and merge tints, where the background carries the meaning
    diff-added diff-removed diff-refine-changed smerge-refined-changed
    ediff-fine-diff-A ediff-fine-diff-Ancestor ediff-fine-diff-C
    isearch-group-1 neo-vc-unlocked-changes-face)
  "Faces allowed below `zenburn-test--legibility-floor'.
Each is a deliberate choice rather than an oversight: a cursor, a fringe
glyph, chrome that is supposed to recede, or a tint whose background does
the talking.  Anything arriving here new should be argued for.")

(describe "text on its own background"
  (before-each (zenburn-test--reload))

  (it "stays readable"
    (let ((illegible '()))
      (mapatoms
       (lambda (sym)
         (let ((fg (zenburn-test--face-attr sym :foreground))
               (bg (zenburn-test--face-attr sym :background)))
           (when (and (zenburn-test--hex-p fg) (zenburn-test--hex-p bg)
                      ;; ansi and term color faces set both alike on purpose,
                      ;; and so do the whitespace block markers, which mark a
                      ;; region with a color rather than a glyph
                      (not (string-equal (upcase fg) (upcase bg)))
                      (not (string-match-p "\\`\\(ansi\\|term\\)-color-" (symbol-name sym)))
                      ;; the two foregrounds Zenburn hands to de-emphasized text
                      (not (member (upcase fg)
                                   (list (upcase (zenburn-test--color "zenburn-fg-1"))
                                         (upcase (zenburn-test--color "zenburn-fg-05")))))
                      (not (memq sym zenburn-test--legibility-exceptions))
                      (< (zenburn-test--contrast fg bg) zenburn-test--legibility-floor))
             (push (list sym (zenburn-test--contrast fg bg)) illegible)))))
      (expect illegible :to-equal '()))))

;;; The shape of the source itself

(defun zenburn-test--face-body ()
  "Return the part of the source holding the face definitions."
  (with-temp-buffer
    (insert-file-contents zenburn-test--source-file)
    (goto-char (point-min))
    (search-forward "custom-theme-set-faces")
    (buffer-substring-no-properties (point) (point-max))))

(defun zenburn-test--matches (regexp string &optional group)
  "Return every GROUP match of REGEXP in STRING."
  (let ((start 0) (found '()))
    (while (string-match regexp string start)
      (push (match-string (or group 1) string) found)
      (setq start (match-end 0)))
    (nreverse found)))

(describe "the source"
  (it "defines each face exactly once"
    (let* ((faces (zenburn-test--matches
                   "`(\\([^ ()]+\\) ((t (" (zenburn-test--face-body)))
           (seen (make-hash-table :test 'equal)) (dupes '()))
      (dolist (face faces)
        (when (gethash face seen) (push face dupes))
        (puthash face t seen))
      (expect (delete-dups dupes) :to-equal '())))

  (it "only refers to colors the palette defines"
    (let* ((defined (append (mapcar #'car zenburn-default-colors-alist)
                            (mapcar #'car zenburn-default-semantic-colors-alist)))
           (used (delete-dups (zenburn-test--matches
                               ",\\(zenburn-[a-z0-9+-]+\\)" (zenburn-test--face-body)))))
      (expect (seq-remove (lambda (name)
                            (or (member name defined)
                                ;; the theme also binds a few non-palette locals
                                (string-prefix-p "zenburn-test" name)))
                          used)
              :to-equal '()))))

;;; Package headers

(describe "package headers"
  (it "opens with a summary and a lexical-binding cookie"
    (let ((first-line (with-temp-buffer
                        (insert-file-contents zenburn-test--source-file)
                        (buffer-substring-no-properties
                         (point-min) (line-end-position)))))
      (expect first-line :to-match
              (rx-to-string '(seq ";;; " (1+ nonl) " --- " (1+ nonl)
                                  "-*- lexical-binding: t" (opt ";") " -*-")))))

  (it "declares the headers a package needs"
    (let ((text (with-temp-buffer
                  (insert-file-contents zenburn-test--source-file)
                  (buffer-string))))
      ;; no Package-Requires here: the theme has never declared one, so
      ;; there is no stated minimum Emacs version to check against
      (dolist (header '("Author" "URL" "Version"))
        (expect (string-match-p (concat "^;; " header ": ") text) :not :to-be nil)))))

;;; Emphasis restraint

(describe "emphasis"
  (before-each (zenburn-test--reload))

  (it "never stacks three emphasis attributes on one face"
    (let ((overwrought '()))
      (mapatoms
       (lambda (sym)
         (when (assoc 'zenburn (get sym 'theme-face))
           (when (> (seq-count (lambda (attr) (zenburn-test--face-attr sym attr))
                               '(:weight :slant :underline :box :overline :strike-through))
                    2)
             (unless (memq sym '(cscope-separator-face))
               (push sym overwrought))))))
      (expect overwrought :to-equal '()))))

;;; zenburn-test.el ends here
