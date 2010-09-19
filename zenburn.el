;;; zenburn.el --- just some alien fruit salad to keep you in the zone
;; Copyright (C) 2003, 2004, 2005, 2006  Daniel Brockman
;; Copyright (C) 2009  Adrian C., Bastien Guerry

;; Author: Daniel Brockman <daniel@brockman.se>
;; URL: http://www.brockman.se/software/zenburn/zenburn.el
;; Updated: 2010-07-19 20:10

;; Changes (2010-07), Keffin Barnaby
;; - Added fixme-face using vim zenburn todo colours (highlight-fixmes-mode)
;; - Added all icompletep-* faces (icomplete-mode)
;; - Added semantic-tag-boundary-face as zenburn-bg+2 (CEDET)
;; - Added semantic-decoration-on-unparsed-includes face
;;   as zenburn-highlight-damp (CEDET)

;; Changes (2010-07), Dirk-Jan C. Binnema
;; - fix doc-string-face color
;; - clarify elscreen colors
;; - fix paren colors

;; Changes (2010-06), Stefan Kangas
;; - add diff-refine-change face to make diff-mode readable

;; Changes (2010-06), Dirk-Jan C. Binnema
;; - update region color (brighter)
;; - add twitter colors
;; - add button colors

;; Changes (2010-05), Dirk-Jan C. Binnema
;; - added minimap-active-region-background

;; changes (2010-04), Bozhidar Batsov
;;  - themed properly rpm-spec-mode
;;  - themed properly mew

;; Changes (2010-04), Dirk-Jan C. Binnema
;;  - add Wanderlust faces, based on the work by *
;;    change display of currently view mail (italic + underline),
;;    make it distinctive from the highlighted line (hi-lock)
;;  - don't change foreground in visible regions (selections)
;;  - add elscreen, flyspell, hi-line, magit support
;;  - set font-lock-function-name to blue

;; Adrian C. and Bastien Guerry added org-mode faces.

;; This file is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty
;; of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;; See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with GNU Emacs; if not, write to the Free
;; Software Foundation, 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; Some packages ship with broken implementations of `format-spec';
;; for example, stable versions of TRAMP and ERC do this.  To fix
;; this, you can put the following at the end of your ~/.emacs:

;;   (unless (zenburn-format-spec-works-p)
;;     (zenburn-define-format-spec))

;; Thanks to Jani Nurminen, who created the original zenburn color
;; theme for vim.  I'm just copying him. :-)

;;; Short-Term Wishlist:

;; Theme the ansi-term faces `term-red', etc., and the ERC faces
;; `fg:erc-color-face1', etc.

;; Theme `gnus-server-offline-face', `gnus-server-opened-face', and
;; `gnus-server-denied-face'.  First, find out what they hell they do.

;; Theme `gnus-emphasis-highlight-words' after finding out what it
;; does.

;; Theme `emms-stream-name-face' and `emms-stream-url-face'.

;; Theme `ido-indicator-face'.

;;; Code:

(require 'color-theme)

(defvar zenburn-fg "#dcdccc")

(defvar zenburn-bg-1 "#2b2b2b")
(defvar zenburn-bg "#3f3f3f")
(defvar zenburn-bg+1 "#4f4f4f")
(defvar zenburn-bg+2 "#5f5f5f")
(defvar zenburn-red+1 "#dca3a3")
(defvar zenburn-red "#cc9393")
(defvar zenburn-red-1 "#bc8383")
(defvar zenburn-red-2 "#ac7373")
(defvar zenburn-red-3 "#9c6363")
(defvar zenburn-red-4 "#8c5353")
(defvar zenburn-orange "#dfaf8f")
(defvar zenburn-yellow "#f0dfaf")
(defvar zenburn-yellow-1 "#e0cf9f")
(defvar zenburn-yellow-2 "#d0bf8f")
(defvar zenburn-green-1 "#5f7f5f")
(defvar zenburn-green "#7f9f7f")
(defvar zenburn-green+1 "#8fb28f")
(defvar zenburn-green+2 "#9fc59f")
(defvar zenburn-green+3 "#afd8af")
(defvar zenburn-green+4 "#bfebbf")
(defvar zenburn-cyan "#93e0e3")
(defvar zenburn-blue+1 "#94bff3")
(defvar zenburn-blue "#8cd0d3")
(defvar zenburn-blue-1 "#7cb8bb")
(defvar zenburn-blue-2 "#6ca0a3")
(defvar zenburn-blue-3 "#5c888b")
(defvar zenburn-blue-4 "#4c7073")
(defvar zenburn-blue-5 "#366060")
(defvar zenburn-magenta "#dc8cc3")

(eval-after-load 'term
  '(setq ansi-term-color-vector
     (vector 'unspecified zenburn-bg
       zenburn-red zenburn-green
       zenburn-yellow zenburn-blue+1
       zenburn-magenta zenburn-cyan)))

(defvar font-lock-pseudo-keyword-face 'font-lock-pseudo-keyword-face)
(defvar font-lock-operator-face 'font-lock-operator-face)

(defun zenburn-format-spec-works-p ()
  (and (fboundp 'format-spec)
    (= (next-property-change
	 0 (format-spec #("<%x>" 0 4 (face (:weight bold)))
	     '((?x . "foo"))) 4) 4)))

(defun zenburn-format-spec (format specification)
  "Return a string based on FORMAT and SPECIFICATION.
FORMAT is a string containing `format'-like specs like \"bash %u %k\",
while SPECIFICATION is an alist mapping from format spec characters
to values."
  (with-temp-buffer
    (insert format)
    (goto-char (point-min))
    (while (search-forward "%" nil t)
      (cond
	;; Quoted percent sign.
	((eq (char-after) ?%)
	  (delete-char 1))
	;; Valid format spec.
	((looking-at "\\([-0-9.]*\\)\\([a-zA-Z]\\)")
	  (let* ((num (match-string 1))
		  (spec (string-to-char (match-string 2)))
		  (val (cdr (assq spec specification))))
	    (unless val
	      (error "Invalid format character: %s" spec))
	    (let ((text (format (concat "%" num "s") val)))
	      (insert-and-inherit text)
	      ;; Delete the specifier body.
	      (delete-region (+ (match-beginning 0) (length text))
		(+ (match-end 0) (length text)))
	      ;; Delete the percent sign.
	      (delete-region (1- (match-beginning 0)) (match-beginning 0)))))
	;; Signal an error on bogus format strings.
	(t
	  (error "Invalid format string"))))
    (buffer-string)))

(defun zenburn-define-format-spec ()
  (interactive)
  (fset 'format-spec #'zenburn-format-spec))

(unless (zenburn-format-spec-works-p)
  (zenburn-define-format-spec))

(eval-after-load 'format-spec
  '(unless (zenburn-format-spec-works-p)
     (zenburn-define-format-spec)))

(setq-default mode-line-buffer-identification
  (list (propertize "%12b" 'face
	  (list :weight 'bold
	    :foreground zenburn-yellow))))
(setq-default mode-line-frame-identification "")
(setq-default erc-mode-line-format
  (concat (propertize "%t" 'face
	    (list :weight 'bold
	      :foreground zenburn-yellow))
    " %a"))


(setq gnus-logo-colors `(,zenburn-bg+2 ,zenburn-bg+1)
  gnus-mode-line-image-cache
  '(image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    11        2            1\",
/* colors */
\". c #dcdccc\",
\"# c None s None\",
/* pixels */
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\"};"))

(defun zenburn-make-face-alias-clauses (alias-symbols)
  (let (clauses)
    (dolist (alias-symbol alias-symbols clauses)
      (let ((alias-name (symbol-name alias-symbol)))
        (if (not (string-match "-face" alias-name))
	  (error "Invalid face alias: %s" alias-name)
          (let ((target-name (replace-regexp-in-string
			       ".*\\(-face\\)" ""
			       alias-name nil nil 1)))
            (push `(,(intern alias-name)
		     ((t (:inherit ,(intern target-name)))))
	      clauses)))))))

;;;###autoload
(defun color-theme-zenburn ()
  "Just some alien fruit salad to keep you in the zone."
  (interactive)
  (color-theme-install
    (append
      (list 'color-theme-zenburn
	`((background-color . ,zenburn-bg)
	   (background-mode . dark)
	   (border-color . ,zenburn-bg)
	   (foreground-color . ,zenburn-fg)
	   (mouse-color . ,zenburn-fg))
	`((emms-mode-line-icon-color . ,zenburn-fg)
	   (goto-address-mail-face . italic)
	   (goto-address-mail-mouse-face . secondary-selection)
	   (goto-address-url-face . bold)
	   (goto-address-url-mouse-face . hover-highlight)
	   (help-highlight-face . hover-highlight)
	   (imaxima-label-color . ,zenburn-yellow)
	   (imaxima-equation-color . ,zenburn-fg)
	   (list-matching-lines-face . bold)
	   (view-highlight-face . hover-highlight)
	   (widget-mouse-face . hover-highlight))

	'(bold ((t (:weight bold))))
	'(bold-italic ((t (:italic t :weight bold))))
	`(default ((t (:background ,zenburn-bg :foreground ,zenburn-fg))))
	'(fixed-pitch ((t (:weight bold))))
	'(italic ((t (:slant italic))))
	'(underline ((t (:underline t))))
	;; '(variable-pitch ((t (:font "-*-utopia-regular-r-*-*-12-*-*-*-*-*-*-*"))))


	`(zenburn-background-1 ((t (:background ,zenburn-bg+1))))
	`(zenburn-background-2 ((t (:background ,zenburn-bg+2))))

	`(zenburn-primary-1 ((t (:foreground ,zenburn-yellow :weight bold))))
	`(zenburn-primary-2 ((t (:foreground ,zenburn-orange :weight bold))))
	'(zenburn-primary-3 ((t (:foreground "#dfdfbf" :weight bold))))
	'(zenburn-primary-4 ((t (:foreground "#dca3a3" :weight bold))))
	'(zenburn-primary-5 ((t (:foreground "#94bff3" :weight bold))))

	'(zenburn-highlight-damp
	   ((t (:foreground "#88b090" :background "#2e3330"))))
	'(zenburn-highlight-alerting
	   ((t (:foreground "#e37170" :background "#332323"))))
	'(zenburn-highlight-subtle
	   ((t (:background "#464646"))))

	'(zenburn-lowlight-1 ((t (:foreground "#606060"))))
	'(zenburn-lowlight-2 ((t (:foreground "#708070"))))

	`(zenburn-yellow ((t (:foreground ,zenburn-yellow))))
	`(zenburn-orange ((t (:foreground ,zenburn-orange))))
	`(zenburn-red ((t (:foreground ,zenburn-red))))
	`(zenburn-green-1 ((t (:foreground ,zenburn-green-1))))
	`(zenburn-green ((t (:foreground ,zenburn-green))))
	`(zenburn-green+1 ((t (:foreground ,zenburn-green+1))))
	`(zenburn-green+2 ((t (:foreground ,zenburn-green+2))))
	`(zenburn-green+3 ((t (:foreground ,zenburn-green+3))))
	`(zenburn-green+4 ((t (:foreground ,zenburn-green+4))))
	`(zenburn-blue ((t (:foreground ,zenburn-blue))))
	`(zenburn-blue-1 ((t (:foreground ,zenburn-blue-1))))
	`(zenburn-blue-2 ((t (:foreground ,zenburn-blue-2))))
	`(zenburn-blue-3 ((t (:foreground ,zenburn-blue-3))))
	`(zenburn-blue-4 ((t (:foreground ,zenburn-blue-4))))

	'(zenburn-title ((t (:inherit variable-pitch :weight bold))))

	'(font-lock-builtin
	   ((t (:inherit zenburn-blue))))
	'(font-lock-comment
	   ((t (:inherit zenburn-green))))
	'(font-lock-comment-delimiter
	   ((t (:inherit zenburn-lowlight-2))))
	'(font-lock-constant
	   ((t (:inherit zenburn-primary-4))))
	'(font-lock-doc
	   ((t (:inherit zenburn-green+1))))
	`(font-lock-doc-string
	   ((t (:foreground ,zenburn-blue+1))))
	`(font-lock-function-name
	   ((t (:foreground ,zenburn-blue))))
	'(font-lock-keyword
	   ((t (:inherit zenburn-primary-1))))
	'(font-lock-negation-char
	   ((t (:inherit zenburn-primary-1))))
	'(font-lock-preprocessor
	   ((t (:inherit zenburn-blue))))
	'(font-lock-string
	   ((t (:inherit zenburn-red))))
	'(font-lock-type
	   ((t (:inherit zenburn-primary-3))))
	`(font-lock-variable-name
	   ((t (:foreground ,zenburn-yellow))))
	'(font-lock-warning
	   ((t (:inherit zenburn-highlight-alerting))))

	'(fixme-face ((t (:foreground "#dcdccc" :background "#3f3f3f"
									 :weight bold :box nil)))) ; Colours taken from vim ":hl Todo"

	'(semantic-tag-boundary-face ((t (:overline "#5f5f5f")))) ; zenburn-bg+2
	'(semantic-decoration-on-unparsed-includes
	  ((t (:foreground "#88b090" :background "#2e3330")))) ; zenburn-highlight-damp

	'(font-lock-pseudo-keyword
	   ((t (:inherit zenburn-primary-2))))
	'(font-lock-operator
	   ((t (:inherit zenburn-primary-3))))

	'(term-default-bg ((t (nil))))
	'(term-default-bg-inv ((t (nil))))
	'(term-default-fg ((t (nil))))
	'(term-default-fg-inv ((t (nil))))
	'(term-invisible ((t (nil)))) ;; FIXME: Security risk?
	'(term-invisible-inv  ((t (nil))))
	'(term-bold ((t (:weight bold))))
	'(term-underline ((t (:underline t))))

	;; FIXME: Map these to ansi-term's faces (`term-red', etc.).
	'(zenburn-term-dark-gray      ((t (:foreground "#709080"))))
	'(zenburn-term-light-blue     ((t (:foreground "#94bff3"))))
	'(zenburn-term-light-cyan     ((t (:foreground "#93e0e3"))))
	'(zenburn-term-light-green    ((t (:foreground "#c3bf9f"))))
	'(zenburn-term-light-magenta  ((t (:foreground "#ec93d3"))))
	'(zenburn-term-light-red      ((t (:foreground "#dca3a3"))))
	'(zenburn-term-light-yellow   ((t (:foreground "#f0dfaf"))))
	'(zenburn-term-white          ((t (:foreground "#ffffff"))))

	'(zenburn-term-black          ((t (:foreground "#000000"))))
	'(zenburn-term-dark-blue      ((t (:foreground "#506070"))))
	'(zenburn-term-dark-cyan      ((t (:foreground "#8cd0d3"))))
	'(zenburn-term-dark-green     ((t (:foreground "#60b48a"))))
	'(zenburn-term-dark-magenta   ((t (:foreground "#dc8cc3"))))
	'(zenburn-term-dark-red       ((t (:foreground "#705050"))))
	'(zenburn-term-dark-yellow    ((t (:foreground "#dfaf8f"))))
	`(zenburn-term-light-gray     ((t (:foreground ,zenburn-fg))))

	'(plain-widget-button
	   ((t (:weight bold))))
	'(plain-widget-button-pressed
	   ((t (:inverse-video t))))
	'(plain-widget-documentation
	   ((t (:inherit font-lock-doc))))
	`(plain-widget-field
	   ((t (:background ,zenburn-bg+2))))
	'(plain-widget-inactive
	   ((t (:strike-through t))))
	`(plain-widget-single-line-field
	   ((t (:background ,zenburn-bg+2))))

	`(fancy-widget-button
	   ((t (:background ,zenburn-bg+1
		 :box (:line-width 2 :style released-button)))))
	`(fancy-widget-button-pressed
	   ((t (:background ,zenburn-bg+1
		 :box (:line-width 2 :style pressed-button)))))
	`(fancy-widget-button-highlight
	   ((t (:background ,zenburn-bg+1
		 :box (:line-width 2 :style released-button)))))
	`(fancy-widget-button-pressed-highlight
	   ((t (:background ,zenburn-bg+1
		 :box (:line-width 2 :style pressed-button)))))
	'(fancy-widget-documentation
	   ((t (:inherit font-lock-doc))))
	`(fancy-widget-field
	   ((t (:background ,zenburn-bg+2))))
	'(fancy-widget-inactive
	   ((t (:strike-through t))))
	`(fancy-widget-single-line-field
	   ((t (:background ,zenburn-bg+2))))

	'(widget-button
	   ((t (:inherit plain-widget-button))))
	'(widget-button-pressed
	   ((t (:inherit fancy-widget-button-pressed))))
	'(widget-button-highlight
	   ((t (:inherit fancy-widget-button-highlight))))
	'(widget-button-pressed-highlight
	   ((t (:inherit fancy-widget-button-pressed-highlight))))
	'(widget-documentation
	   ((t (:inherit fancy-widget-documentation))))
	'(widget-field
	   ((t (:inherit fancy-widget-field))))
	'(widget-inactive
	   ((t (:inherit fancy-widget-inactive))))
	'(widget-single-line-field
	   ((t (:inherit fancy-widget-single-line-field))))

	`(border ((t (:background ,zenburn-bg))))
	'(fringe ((t (:inherit zenburn-highlight-subtle))))
	'(header-line ((t (:inherit zenburn-highlight-damp
			    :box (:color "#2e3330" :line-width 2)))))
	'(mode-line ((t (:foreground "#acbc90" :background "#1e2320"
			  :box (:color "#1e2320" :line-width 2)))))
	'(mode-line-inactive ((t (:background "#2e3330" :foreground "#88b090"
				   :box (:color "#2e3330" :line-width 2)))))
	`(minibuffer-prompt ((t (:foreground ,zenburn-yellow))))
	`(Buffer-menu-buffer ((t (:inherit zenburn-primary-1))))

	`(region ((t (:foreground nil :background ,zenburn-bg+2))))
	`(secondary-selection ((t (:foreground nil :background "#506070"))))

	'(trailing-whitespace ((t (:inherit font-lock-warning))))
	'(highlight ((t (:underline t))))
	'(paren ((t (:inherit zenburn-lowlight-1))))
	'(show-paren-mismatch ((t (:inherit font-lock-warning))))
	`(show-paren-match ((t (:foreground ,zenburn-blue-1 :underline t))))
	'(match ((t (:weight bold))))

	`(button ((t (:foreground ,zenburn-yellow :background "#506070"
		       :weight bold :underline t))))

	`(cursor ((t (:background "#aaaaaa" :foreground nil))))
	'(hover-highlight ((t (:underline t :foreground "#f8f893"))))
	'(menu ((t nil)))
	'(mouse ((t (:inherit zenburn-foreground))))
	`(scroll-bar ((t (:background ,zenburn-bg+2))))
	`(tool-bar ((t (:background ,zenburn-bg+2))))

	'(ido-first-match ((t (:inherit zenburn-primary-1))))
	'(ido-only-match ((t (:inherit zenburn-primary-2))))
	`(ido-subdir ((t (:foreground ,zenburn-yellow))))

	'(icompletep-choices ((t (:foreground "#dcdccc")))) ; zenburn-fg
	'(icompletep-determined ((t (:foreground "#8FB28F")))) ; zenburn-green+1
	'(icompletep-nb-candidates ((t (:foreground "#AFD8AF")))) ; zenburn-green+3
	'(icompletep-keys ((t (:foreground "#CC9393")))) ; zenburn-red

	`(isearch ((t (:foreground ,zenburn-fg :background "#506070"))))
	`(isearch-lazy-highlight
	   ((t (:foreground ,zenburn-fg :background "#1e2320" :weight normal))))

	'(mtorus-highlight ((t (:inherit zenburn-highlight-bluish))))
	'(mtorus-notify-highlight ((t (:inherit zenburn-primary-1))))

	'(minimap-active-region-background ((t (:foreground nil
						 :background "#233323"))))
	'(which-func ((t (:inherit mode-line))))

	'(apt-utils-normal-package
	   ((t (:inherit zenburn-primary-1))))
	'(apt-utils-virtual-package
	   ((t (:inherit zenburn-primary-2))))
	'(apt-utils-field-keyword
	   ((t (:inherit font-lock-doc))))
	'(apt-utils-field-contents
	   ((t (:inherit font-lock-comment))))
	'(apt-utils-summary
	   ((t (:inherit bold))))
	'(apt-utils-description
	   ((t (:inherit default))))
	'(apt-utils-version
	   ((t (:inherit zenburn-blue))))
	'(apt-utils-broken
	   ((t (:inherit font-lock-warning))))

	'(breakpoint-enabled-bitmap ((t (:inherit zenburn-primary-1))))
	'(breakpoint-disabled-bitmap ((t (:inherit font-lock-comment))))

	'(calendar-today ((t (:underline nil :inherit zenburn-primary-2))))
	'(diary ((t (:underline nil :inherit zenburn-primary-1))))
	'(holiday ((t (:underline t :inherit zenburn-primary-4))))

	'(bongo-unfilled-seek-bar ((t (:background "#606060"))))

	'(change-log-date ((t (:inherit zenburn-blue))))

	'(comint-highlight-input ((t (:inherit zenburn-primary-1))))
	'(comint-highlight-prompt ((t (:inherit zenburn-primary-2))))

	'(compilation-info ((t (:inherit zenburn-primary-1))))
	'(compilation-warning ((t (:inherit font-lock-warning))))

	;; TODO
	'(cua-rectangle ((t (:inherit region))))

	'(custom-button
	   ((t (:inherit fancy-widget-button))))
	'(custom-button-pressed
	   ((t (:inherit fancy-widget-button-pressed))))
	'(custom-changed
	   ((t (:inherit zenburn-blue))))
	'(custom-comment
	   ((t (:inherit font-lock-doc))))
	'(custom-comment-tag
	   ((t (:inherit font-lock-doc))))
	'(custom-documentation
	   ((t (:inherit font-lock-doc))))
	'(custom-link
	   ((t (:inherit zenburn-yellow :underline t))))
	'(custom-tag
	   ((t (:inherit zenburn-primary-2))))
	'(custom-group-tag
	   ((t (:inherit zenburn-primary-1))))
	'(custom-group-tag-1
	   ((t (:inherit zenburn-primary-4))))
	'(custom-invalid
	   ((t (:inherit font-lock-warning))))
	'(custom-modified
	   ((t (:inherit zenburn-primary-3))))
	'(custom-rogue
	   ((t (:inhrit font-lock-warning))))
	'(custom-saved
	   ((t (:underline t))))
	'(custom-set
	   ((t (:inverse-video t :inherit zenburn-blue))))
	'(custom-state
	   ((t (:inherit font-lock-comment))))
	'(custom-variable-button
	   ((t (:weight bold :underline t))))
	'(custom-variable-tag
	   ((t (:inherit zenburn-primary-2))))

	'(dictionary-button ((t (:inherit fancy-widget-button))))
	'(dictionary-reference ((t (:inherit zenburn-primary-1))))
	'(dictionary-word-entry ((t (:inherit font-lock-keyword))))

	'(diff-header ((t (:inherit zenburn-highlight-subtle))))
	'(diff-index ((t (:inherit bold))))
	'(diff-file-header ((t (:inherit bold))))
	'(diff-hunk-header ((t (:inherit zenburn-highlight-subtle))))

	'(diff-added ((t (:inherit zenburn-primary-3))))
	'(diff-removed ((t (:inherit zenburn-blue))))
	'(diff-context ((t (:inherit font-lock-comment))))
	'(diff-refine-change ((t (:inherit zenburn-background-2))))

	`(emms-pbi-song ((t (:foreground ,zenburn-yellow))))
	'(emms-pbi-current ((t (:inherit zenburn-primary-1))))
	'(emms-pbi-mark-marked ((t (:inherit zenburn-primary-2))))

	'(erc-action ((t (:inherit erc-default))))
	'(erc-bold ((t (:weight bold))))
	'(erc-current-nick ((t (:inherit zenburn-primary-1))))
	'(erc-dangerous-host ((t (:inherit font-lock-warning))))
	`(erc-default ((t (:foreground ,zenburn-fg))))
	'(erc-direct-msg ((t (:inherit erc-default))))
	'(erc-error ((t (:inherit font-lock-warning))))
	'(erc-fool ((t (:inherit zenburn-lowlight-1))))
	'(erc-highlight ((t (:inherit hover-highlight))))
	`(erc-input ((t (:foreground ,zenburn-yellow))))
	'(erc-keyword ((t (:inherit zenburn-primary-1))))
	'(erc-nick-default ((t (:inherit bold))))
	'(erc-nick-msg ((t (:inherit erc-default))))
	'(erc-notice ((t (:inherit zenburn-green))))
	'(erc-pal ((t (:inherit zenburn-primary-3))))
	'(erc-prompt ((t (:inherit zenburn-primary-2))))
	'(erc-timestamp ((t (:inherit zenburn-green+1))))
	'(erc-underline ((t (:inherit underline))))

	'(circe-highlight-nick-face ((t (:inherit zenburn-primary-1))))
	'(circe-my-message-face ((t (:inherit zenburn-yellow))))
	'(circe-originator-face ((t (:inherit bold))))
	'(circe-prompt-face ((t (:inherit zenburn-primary-1))))
	'(circe-server-face ((t (:inherit font-lock-comment-face))))

	'(rcirc-my-nick ((t (:inherit zenburn-primary-1))))
	'(rcirc-other-nick ((t (:inherit bold))))
	'(rcirc-bright-nick ((t (:foreground "white" :inherit rcirc-other-nick))))
	'(rcirc-dim-nick ((t (:inherit font-lock-comment))))
	'(rcirc-nick-in-message ((t (:inherit bold))))
	'(rcirc-server ((t (:inherit font-lock-comment))))
	'(rcirc-server-prefix ((t (:inherit font-lock-comment-delimiter))))
	'(rcirc-timestamp ((t (:inherit font-lock-comment))))
	'(rcirc-prompt ((t (:inherit zenburn-primary-1))))
	'(rcirc-mode-line-nick ((t (:inherit zenburn-primary-1))))

	'(eshell-prompt ((t (:inherit zenburn-primary-1))))
	'(eshell-ls-archive ((t (:foreground "#c3bf9f" :weight bold))))
	'(eshell-ls-backup ((t (:inherit font-lock-comment))))
	'(eshell-ls-clutter ((t (:inherit font-lock-comment))))
	`(eshell-ls-directory ((t (:foreground ,zenburn-blue+1 :weight bold))))
	`(eshell-ls-executable ((t (:foreground ,zenburn-red+1 :weight bold))))
	'(eshell-ls-unreadable ((t (:inherit zenburn-lowlight-1))))
	'(eshell-ls-missing ((t (:inherit font-lock-warning))))
	'(eshell-ls-product ((t (:inherit font-lock-doc))))
	'(eshell-ls-special ((t (:inherit zenburn-primary-1))))
	`(eshell-ls-symlink ((t (:foreground ,zenburn-cyan :weight bold))))

	'(highlight-current-line ((t (:inherit zenburn-highlight-subtle))))

	'(ibuffer-deletion ((t (:inherit zenburn-primary-2))))
	'(ibuffer-marked ((t (:inherit zenburn-primary-1))))
	'(ibuffer-special-buffer ((t (:inherit font-lock-doc))))
	'(ibuffer-help-buffer ((t (:inherit font-lock-comment))))

	'(message-cited-text ((t (:inherit font-lock-comment))))
	;;`(message-cited-text ((t (:foreground ,zenburn-blue))))
	'(message-header-name ((t (:inherit zenburn-green+1))))
	'(message-header-other ((t (:inherit zenburn-green))))
	'(message-header-to ((t (:inherit zenburn-primary-1))))
	'(message-header-from ((t (:inherit zenburn-primary-1))))
	'(message-header-cc ((t (:inherit zenburn-primary-1))))
	'(message-header-newsgroups ((t (:inherit zenburn-primary-1))))
	'(message-header-subject ((t (:inherit zenburn-primary-2))))
	'(message-header-xheader ((t (:inherit zenburn-green))))
	'(message-mml ((t (:inherit zenburn-primary-1))))
	'(message-separator ((t (:inherit font-lock-comment))))

	'(gnus-header-name ((t (:inherit message-header-name))))
	'(gnus-header-content ((t (:inherit message-header-other))))
	'(gnus-header-from ((t (:inherit message-header-from))))
	'(gnus-header-subject ((t (:inherit message-header-subject))))
	'(gnus-header-newsgroups ((t (:inherit message-header-other))))

	`(gnus-x-face ((t (:background ,zenburn-fg :foreground ,zenburn-bg))))

	;; (gnus-cite-1 ((t (:inherit message-cited-text))))
	`(gnus-cite-1 ((t (:foreground ,zenburn-blue))))
	`(gnus-cite-2 ((t (:foreground ,zenburn-blue-1))))
	`(gnus-cite-3 ((t (:foreground ,zenburn-blue-2))))
	;;      (gnus-cite-4 ((t (:foreground ,zenburn-blue-3))))
	;;      (gnus-cite-5 ((t (:foreground ,zenburn-blue-4))))
	;;      (gnus-cite-6 ((t (:foreground ,zenburn-red-4))))
	;;      (gnus-cite-5 ((t (:foreground ,zenburn-red-3))))
	`(gnus-cite-4 ((t (:foreground ,zenburn-green+2))))
	`(gnus-cite-5 ((t (:foreground ,zenburn-green+1))))
	`(gnus-cite-6 ((t (:foreground ,zenburn-green))))
	`(gnus-cite-7 ((t (:foreground ,zenburn-red))))
	`(gnus-cite-8 ((t (:foreground ,zenburn-red-1))))
	`(gnus-cite-9 ((t (:foreground ,zenburn-red-2))))
	`(gnus-cite-10 ((t (:foreground ,zenburn-yellow-1))))
	`(gnus-cite-11 ((t (:foreground ,zenburn-yellow))))

	`(gnus-group-news-1-empty ((t (:foreground ,zenburn-yellow))))
	`(gnus-group-news-2-empty ((t (:foreground ,zenburn-green+3))))
	`(gnus-group-news-3-empty ((t (:foreground ,zenburn-green+1))))
	`(gnus-group-news-4-empty ((t (:foreground ,zenburn-blue-2))))
	`(gnus-group-news-5-empty ((t (:foreground ,zenburn-blue-3))))
	`(gnus-group-news-6-empty ((t (:inherit zenburn-lowlight-1))))
	`(gnus-group-news-low-empty ((t (:inherit zenburn-lowlight-1))))

	'(gnus-group-mail-1-empty ((t (:inherit gnus-group-news-1-empty))))
	'(gnus-group-mail-2-empty ((t (:inherit gnus-group-news-2-empty))))
	'(gnus-group-mail-3-empty ((t (:inherit gnus-group-news-3-empty))))
	'(gnus-group-mail-4-empty ((t (:inherit gnus-group-news-4-empty))))
	'(gnus-group-mail-5-empty ((t (:inherit gnus-group-news-5-empty))))
	'(gnus-group-mail-6-empty ((t (:inherit gnus-group-news-6-empty))))
	'(gnus-group-mail-low-empty ((t (:inherit gnus-group-news-low-empty))))

	'(gnus-group-news-1 ((t (:bold t :inherit gnus-group-news-1-empty))))
	'(gnus-group-news-2 ((t (:bold t :inherit gnus-group-news-2-empty))))
	'(gnus-group-news-3 ((t (:bold t :inherit gnus-group-news-3-empty))))
	'(gnus-group-news-4 ((t (:bold t :inherit gnus-group-news-4-empty))))
	'(gnus-group-news-5 ((t (:bold t :inherit gnus-group-news-5-empty))))
	'(gnus-group-news-6 ((t (:bold t :inherit gnus-group-news-6-empty))))
	'(gnus-group-news-low ((t (:bold t :inherit gnus-group-news-low-empty))))

	'(gnus-group-mail-1 ((t (:bold t :inherit gnus-group-mail-1-empty))))
	'(gnus-group-mail-2 ((t (:bold t :inherit gnus-group-mail-2-empty))))
	'(gnus-group-mail-3 ((t (:bold t :inherit gnus-group-mail-3-empty))))
	'(gnus-group-mail-4 ((t (:bold t :inherit gnus-group-mail-4-empty))))
	'(gnus-group-mail-5 ((t (:bold t :inherit gnus-group-mail-5-empty))))
	'(gnus-group-mail-6 ((t (:bold t :inherit gnus-group-mail-6-empty))))
	'(gnus-group-mail-low ((t (:bold t :inherit gnus-group-mail-low-empty))))

	`(gnus-signature ((t (:foreground ,zenburn-yellow))))

	'(gnus-summary-selected
	   ((t (:inherit zenburn-primary-1))))
	'(gnus-summary-cancelled
	   ((t (:inherit zenburn-highlight-alerting))))

	'(gnus-summary-low-ticked
	   ((t (:inherit zenburn-primary-2))))
	'(gnus-summary-normal-ticked
	   ((t (:inherit zenburn-primary-2))))
	'(gnus-summary-high-ticked
	   ((t (:inherit zenburn-primary-2))))

	'(gnus-summary-low-unread
	   ((t (:inherit zenburn-foreground :weight normal))))
	'(gnus-summary-normal-unread
	   ((t (:inherit zenburn-foreground :weight normal))))
	'(gnus-summary-high-unread
	   ((t (:inherit zenburn-foreground :weight bold))))

	'(gnus-summary-low-read
	   ((t (:inherit zenburn-green :weight normal))))
	'(gnus-summary-normal-read
	   ((t (:inherit zenburn-green :weight normal))))
	'(gnus-summary-high-read
	   ((t (:inherit zenburn-green :weight bold))))

	'(gnus-summary-low-ancient
	   ((t (:inherit zenburn-blue :weight normal))))
	'(gnus-summary-normal-ancient
	   ((t (:inherit zenburn-blue :weight normal))))
	'(gnus-summary-high-ancient
	   ((t (:inherit zenburn-blue))))

	'(help-argument-name ((t (:weight bold))))

	;; See also the variable definitions at the top of this file
	'(imaxima-latex-error ((t (:inherit font-lock-warning))))

	`(info-xref ((t (:foreground ,zenburn-yellow :weight bold))))
	'(info-xref-visited ((t (:inherit info-xref :weight normal))))
	'(info-header-xref ((t (:inherit info-xref))))
	`(info-menu-star ((t (:foreground ,zenburn-orange :weight bold))))
	`(info-menu-5 ((t (:inherit info-menu-star))))
	'(info-node ((t (:weight bold))))
	'(info-header-node ((t (:weight normal))))

	'(jabber-roster-user-chatty
	   ((t (:inherit zenburn-primary-1))))
	'(jabber-roster-user-online
	   ((t (:inherit zenburn-primary-2))))
	'(jabber-roster-user-away
	   ((t (:inherit font-lock-doc))))
	'(jabber-roster-user-xa
	   ((t (:inherit font-lock-comment))))
	'(jabber-roster-user-offline
	   ((t (:inherit zenburn-lowlight-1))))
	'(jabber-roster-user-dnd
	   ((t (:inherit zenburn-primary-5))))
	'(jabber-roster-user-error
	   ((t (:inherit font-lock-warning))))

	'(jabber-title-small
	   ((t (:inherit zenburn-title :height 1.2))))
	'(jabber-title-medium
	   ((t (:inherit jabber-title-small :height 1.2))))
	'(jabber-title-large
	   ((t (:inherit jabber-title-medium :height 1.2))))

	'(jabber-chat-prompt-local
	   ((t (:inherit zenburn-primary-1))))
	'(jabber-chat-prompt-foreign
	   ((t (:inherit zenburn-primary-2))))

	'(jabber-rare-time-face
	   ((t (:inherit zenburn-green+1))))

	'(jde-java-font-lock-modifier
	   ((t (:inherit zenburn-primary-2))))
	'(jde-java-font-lock-doc-tag
	   ((t (:inherit zenburn-primary-1))))
	'(jde-java-font-lock-constant
	   ((t (:inherit font-lock-constant))))
	'(jde-java-font-lock-package
	   ((t (:inherit zenburn-primary-3))))
	'(jde-java-font-lock-number
	   ((t (:inherit font-lock-constant))))
	'(jde-java-font-lock-operator
	   ((t (:inherit font-lock-keyword))))
	'(jde-java-font-lock-link
	   ((t (:inherit zenburn-primary-5 :underline t))))

	'(keywiz-right ((t (:inherit zenburn-primary-1))))
	'(keywiz-wrong ((t (:inherit font-lock-warning))))
	'(keywiz-command ((t (:inherit zenburn-primary-2))))

	'(font-latex-bold ((t (:inherit bold))))
	'(font-latex-warning ((t (:inherit font-lock-warning))))
	'(font-latex-sedate ((t (:inherit zenburn-primary-1))))
	'(font-latex-title-4 ((t (:inherit zenburn-title))))

	'(makefile-space ((t (:inherit font-lock-warning))))
	'(makefile-shell ((t (nil))))
	;; This does not work very well because everything that's highlighted
	;; inside the shell region will get its own box.
	;; (makefile-shell ((t (:background "#4f4f4f"
	;;                           :box (:line-width 2 :color "#4f4f4f")))))

	'(nxml-delimited-data ((t (:inherit font-lock-string))))
	'(nxml-name ((t (:inherit zenburn-primary-1))))
	'(nxml-ref ((t (:inherit zenburn-primary-5))))
	'(nxml-delimiter ((t (:inherit default))))
	'(nxml-text ((t (:inherit default))))

	'(nxml-comment-content
	   ((t (:inherit font-lock-comment))))
	'(nxml-comment-delimiter
	   ((t (:inherit nxml-comment-content))))
	'(nxml-processing-instruction-target
	   ((t (:inherit zenburn-primary-2))))
	'(nxml-processing-instruction-delimiter
	   ((t (:inherit nxml-processing-instruction-target))))
	'(nxml-processing-instruction-content
	   ((t (:inherit nxml-processing-instruction-target))))
	'(nxml-cdata-section-CDATA
	   ((t (:inherit zenburn-primary-4))))
	'(nxml-cdata-section-delimiter
	   ((t (:inherit nxml-cdata-section-CDATA))))
	'(nxml-cdata-section-content
	   ((t (:inherit nxml-text))))
	'(nxml-entity-ref-name
	   ((t (:inherit zenburn-primary-5))))
	'(nxml-entity-ref-delimiter
	   ((t (:inherit nxml-entity-ref-name))))
	'(nxml-char-ref-number
	   ((t (:inherit nxml-entity-ref-name))))
	'(nxml-char-ref-delimiter
	   ((t (:inherit nxml-entity-ref-delimiter))))

	'(nxml-tag-delimiter ((t (:inherit default))))
	'(nxml-tag-slash ((t (:inherit default))))
	'(nxml-element-local-name ((t (:inherit zenburn-primary-1))))
	'(nxml-element-prefix ((t (:inherit default))))
	'(nxml-element-colon ((t (:inherit default))))

	'(nxml-attribute-local-name
	   ((t (:inherit zenburn-primary-3))))
	'(nxml-namespace-attribute-prefix
	   ((t (:inherit nxml-attribute-local-name))))
	'(nxml-attribute-value
	   ((t (:inherit font-lock-string))))
	'(nxml-attribute-value-delimiter
	   ((t (:inherit nxml-attribute-value))))
	'(nxml-attribute-prefix
	   ((t (:inherit default))))
	'(nxml-namespace-attribute-xmlns
	   ((t (:inherit nxml-attribute-prefix))))
	'(nxml-attribute-colon
	   ((t (:inherit default))))
	'(nxml-namespace-attribute-colon
	   ((t (:inherit nxml-attribute-colon))))

	'(org-agenda-date-today ((t (:foreground "white"
				      :slant italic :weight bold))) t)       ;; white
	'(org-agenda-structure ((t (:inherit font-lock-comment-face))))  ;; zenburn-green
	'(org-archived ((t (:foreground "#8f8f8f"))))                    ;; zenburn-bg slight lighter
	'(org-column ((t (:height 98 :family "DejaVu Sans Mono"))))      ;; n/a
	'(org-checkbox ((t (:background "#5f5f5f" :foreground "white"    ;; zenburn-fg on zenburn-bg+2
			     :box (:line-width 1 :style released-button))))) ;;   - turn checkboxes into buttons
	'(org-date ((t (:foreground "#8cd0d3" :underline t))))           ;; zenburn-blue
	'(org-deadline-announce ((t (:foreground "#bc8383"))))           ;; zenburn-red-1
	'(org-done ((t (:bold t :weight bold :foreground "#afd8af"))))   ;; zenburn-green+3
	'(org-formula ((t (:foreground "#d0bf8f"))))                     ;; zenburn-yellow-2
	'(org-headline-done ((t (:foreground "#afd8af"))))               ;; zenburn-green+3
	'(org-hide ((t (:foreground "#282828"))))                        ;; zenburn-bg slight darker
	'(org-level-1 ((t (:foreground "#dfaf8f"))))                     ;; zenburn-orange
	'(org-level-2 ((t (:foreground "#f0dfaf"))))                     ;; zenburn-yellow
	'(org-level-3 ((t (:foreground "#8cd0d3"))))                     ;; zenburn-blue
	'(org-level-4 ((t (:foreground "#93e0e3"))))                     ;; zenburn-cyan
	'(org-level-5 ((t (:foreground "#7cb8bb"))))                     ;; zenburn-blue-1
	'(org-level-6 ((t (:foreground "#6ca0a3"))))                     ;; zenburn-blue-2
	'(org-level-7 ((t (:foreground "#5c888b"))))                     ;; zenburn-blue-3
	'(org-level-8 ((t (:foreground "#4c7073"))))                     ;; zenburn-blue-4
	'(org-link ((t (:foreground "#d0bf8f" :underline t))))           ;; zenburn-yellow-2
					;'(org-priority faces                                            TODO
	'(org-scheduled ((t (:foreground "#bfebbf"))))                   ;; zenburn-green+4
	'(org-scheduled-previously ((t (:foreground "#8c5353"))))        ;; zenburn-red-4
	'(org-scheduled-today ((t (:foreground "#94bff3"))))             ;; zenburn-blue+1
	'(org-special-keyword ((t (:foreground "#e0cf9f"))))             ;; zenburn-yellow-1
	'(org-table ((t (:foreground "#9fc59f"))))                       ;; zenburn-green+2
	'(org-tag ((t (:bold t :weight bold))))                          ;; n/a
	'(org-time-grid ((t (:foreground "#ffc9a4"))))                   ;; zenburn-orange slight lighter
	'(org-todo ((t (:bold t :foreground "#cc9393" :weight bold))))   ;; zenburn-red
	'(org-upcoming-deadline ((t (:inherit font-lock-keyword-face)))) ;; zenburn-fg
	'(org-warning ((t (:bold t :foreground "#cc9393" :weight bold))));; zenburn-red

	;; TODO
	'(outline-8 ((t (:inherit default))))
	'(outline-7 ((t (:inherit outline-8 :height 1.0))))
	'(outline-6 ((t (:inherit outline-7 :height 1.0))))
	'(outline-5 ((t (:inherit outline-6 :height 1.0))))
	'(outline-4 ((t (:inherit outline-5 :height 1.0))))
	'(outline-3 ((t (:inherit outline-4 :height 1.0))))
	'(outline-2 ((t (:inherit outline-3 :height 1.0))))
	'(outline-1 ((t (:inherit outline-2 :height 1.0))))

	'(setnu-line-number ((t (:inherit zenburn-lowlight-2))))

	'(speedbar-button ((t (:inherit zenburn-primary-1))))
	'(speedbar-file ((t (:inherit zenburn-primary-2))))
	'(speedbar-directory ((t (:inherit zenburn-primary-5))))
	'(speedbar-tag ((t (:inherit font-lock-function-name))))
	'(speedbar-highlight ((t (:underline t))))

	'(strokes-char ((t (:inherit font-lock-keyword))))

	'(todoo-item-header
	   ((t (:inherit zenburn-primary-1))))
	'(todoo-item-assigned-header
	   ((t (:inherit zenburn-primary-2))))
	`(todoo-sub-item-header
	   ((t (:foreground ,zenburn-yellow))))

	'(tuareg-font-lock-governing
	   ((t (:inherit zenburn-primary-2))))
	'(tuareg-font-lock-interactive-error
	   ((t (:inherit font-lock-warning))))
	'(tuareg-font-lock-interactive-output
	   ((t (:inherit zenburn-primary-3))))
	'(tuareg-font-lock-operator
	   ((t (:inherit font-lock-operator))))

	'(w3m-form-button
	   ((t (:inherit widget-button))))
	'(w3m-form-button-pressed
	   ((t (:inherit widget-button-pressed))))
	'(w3m-form-button-mouse
	   ((t (:inherit widget-button-pressed))))
	'(w3m-tab-unselected
	   ((t (:box (:line-width 1 :style released-button)))))
	'(w3m-tab-selected
	   ((t (:box (:line-width 1 :style pressed-button)))))
	'(w3m-tab-unselected-retrieving
	   ((t (:inherit (w3m-tab-unselected widget-inactive)))))
	'(w3m-tab-selected-retrieving
	   ((t (:inherit (w3m-tab-selected widget-inactive)))))
	'(w3m-tab-background
	   ((t (:inherit zenburn-highlight-subtle))))
	'(w3m-anchor
	   ((t (:inherit zenburn-primary-1))))
	'(w3m-arrived-anchor
	   ((t (:inherit zenburn-primary-2))))
	'(w3m-image
	   ((t (:inherit zenburn-primary-3))))
	'(w3m-form
	   ((t (:inherit widget-field))))

	`(hl-line ((t (:background ,zenburn-bg-1))))

	'(magit-section-title ((t (:inherit zenburn-primary-1))))
	'(magit-branch ((t (:inherit zenburn-primary-2))))

	'(flyspell-duplicate ((t (:inherit zenburn-primary-1))))
	'(flyspell-incorrect ((t (:inherit font-lock-warning))))

	`(elscreen-tab-other-screen ((t ((:foreground ,zenburn-fg
					   :background ,zenburn-green-1)))))
	`(elscreen-tab-current-screen ((t (:foreground ,zenburn-blue+1
					    :background "#1e2320"))))

	'(wl-highlight-message-headers ((t (:inherit zenburn-red+1))))
	'(wl-highlight-message-header-contents ((t (:inherit zenburn-green))))
	'(wl-highlight-message-important-header-contents
	   ((t (:inherit zenburn-yellow))))
	'(wl-highlight-message-important-header-contents2
	   ((t (:inherit zenburn-blue))))
	'(wl-highlight-message-unimportant-header-contents
	   ((t (:inherit zenburn-term-dark-gray))))   ;; reuse term
	'(wl-highlight-message-citation-header ((t (:inherit zenburn-red))))

	'(wl-highlight-message-cited-text-1 ((t (:inherit zenburn-green))))
	'(wl-highlight-message-cited-text-2 ((t (:inherit zenburn-blue))))
	'(wl-highlight-message-cited-text-3 ((t (:foreground "#8f8f8f"))))
	'(wl-highlight-message-cited-text-4 ((t (:inherit zenburn-green))))

	'(wl-highlight-message-signature ((t (:inherit zenburn-yellow))))

	'(wl-highlight-summary-answered ((t (:inherit zenburn-fg))))
	'(wl-highlight-summary-new ((t (:foreground "#e89393"))))

	`(wl-highlight-summary-displaying ((t (:underline t
						:foreground ,zenburn-yellow-2))))

	'(wl-highlight-thread-indent ((t (:foreground "#ecbcec"))))
	'(wl-highlight-summary-thread-top ((t (:foreground "#efdcbc"))))

	'(wl-highlight-summary-normal ((t (:inherit zenburn-fg))))

	'(wl-highlight-folder-zero ((t (:inherit zenburn-fg))))
	'(wl-highlight-folder-few ((t (:inherit zenburn-red+1))))
	'(wl-highlight-folder-many ((t (:inherit zenburn-red+1))))
	'(wl-highlight-folder-unread ((t (:foreground "#e89393"))))

	'(wl-highlight-folder-path ((t (:inherit zenburn-orange))))

	`(twitter-time-stamp ((t (:foreground ,zenburn-orange :background "#1e2320"))))
	`(twitter-user-name ((t (:foreground "#acbc90" :background "#1e2320"))))
	`(twitter-header ((t (:foreground ,zenburn-orange :background "#1e2320"))))

	'(rpm-spec-dir ((t (:inherit zenburn-green))))
	'(rpm-spec-doc ((t (:inherit zenburn-green))))
	'(rpm-spec-ghost ((t (:inherit zenburn-red))))
	'(rpm-spec-macro ((t (:inherit zenburn-yellow))))
	'(rpm-spec-obsolete-tag ((t (:inherit zenburn-red))))
	'(rpm-spec-package ((t (:inherit zenburn-red))))
	'(rpm-spec-section ((t (:inherit zenburn-yellow))))
	'(rpm-spec-tag ((t (:inherit zenburn-blue))))
	'(rpm-spec-var ((t (:inherit zenburn-red))))

	'(mew-face-header-subject ((t (:inherit zenburn-orange))))
	'(mew-face-header-from ((t (:inherit zenburn-yellow))))
	'(mew-face-header-date ((t (:inherit zenburn-green))))
	'(mew-face-header-to ((t (:inherit zenburn-red))))
	'(mew-face-header-key ((t (:inherit zenburn-green))))
	'(mew-face-header-private ((t (:inherit zenburn-green))))
	'(mew-face-header-important ((t (:inherit zenburn-blue))))
	'(mew-face-header-marginal ((t (:inherit zenburn-term-dark-gray))))
	'(mew-face-header-warning ((t (:inherit zenburn-red))))
	'(mew-face-header-xmew ((t (:inherit zenburn-green))))
	'(mew-face-header-xmew-bad ((t (:inherit zenburn-red))))
	'(mew-face-body-url ((t (:inherit zenburn-orange))))
	'(mew-face-body-comment ((t (:inherit zenburn-term-dark-gray))))
	'(mew-face-body-cite1 ((t (:inherit zenburn-green))))
	'(mew-face-body-cite2 ((t (:inherit zenburn-blue))))
	'(mew-face-body-cite3 ((t (:inherit zenburn-orange))))
	'(mew-face-body-cite4 ((t (:inherit zenburn-yellow))))
	'(mew-face-body-cite5 ((t (:inherit zenburn-red))))
	'(mew-face-mark-review ((t (:inherit zenburn-blue))))
	'(mew-face-mark-escape ((t (:inherit zenburn-green))))
	'(mew-face-mark-delete ((t (:inherit zenburn-red))))
	'(mew-face-mark-unlink ((t (:inherit zenburn-yellow))))
	'(mew-face-mark-refile ((t (:inherit zenburn-green))))
	'(mew-face-mark-unread ((t (:inherit zenburn-red-2))))
	'(mew-face-eof-message ((t (:inherit zenburn-green))))
	'(mew-face-eof-part ((t (:inherit zenburn-yellow))))
	)

      (zenburn-make-face-alias-clauses
	'(Buffer-menu-buffer-face
	   apt-utils-broken-face
	   apt-utils-description-face
	   apt-utils-field-contents-face
	   apt-utils-field-keyword-face
	   apt-utils-normal-package-face
	   apt-utils-summary-face
	   apt-utils-version-face
	   apt-utils-virtual-package-face
	   breakpoint-disabled-bitmap-face
	   breakpoint-enabled-bitmap-face
	   calendar-today-face
	   change-log-date-face
	   compilation-info-face
	   compilation-warning-face
	   cua-rectangle-face
	   custom-button-face
	   custom-button-pressed-face
	   custom-changed-face
	   custom-comment-face
	   custom-comment-tag-face
	   custom-documentation-face
	   custom-face-tag-face
	   custom-group-tag-face
	   custom-group-tag-face-1
	   custom-invalid-face
	   custom-modified-face
	   custom-rogue-face
	   custom-saved-face
	   custom-set-face
	   custom-state-face
	   custom-variable-button-face
	   custom-variable-tag-face
	   diary-face
	   dictionary-button-face
	   dictionary-reference-face
	   dictionary-word-entry-face
	   diff-added-face
	   diff-context-face
	   diff-file-header-face
	   diff-header-face
	   diff-hunk-header-face
	   diff-index-face
	   diff-removed-face
	   diff-refine-change-face
	   emms-pbi-current-face
	   emms-pbi-mark-marked-face
	   emms-pbi-song-face
	   erc-action-face
	   erc-bold-face
	   erc-current-nick-face
	   erc-dangerous-host-face
	   erc-default-face
	   erc-direct-msg-face
	   erc-error-face
	   erc-fool-face
	   erc-highlight-face
	   erc-input-face
	   erc-keyword-face
	   erc-nick-default-face
	   erc-nick-msg-face
	   erc-notice-face
	   erc-pal-face
	   erc-prompt-face
	   erc-timestamp-face
	   erc-underline-face
	   eshell-ls-archive-face
	   eshell-ls-backup-face
	   eshell-ls-clutter-face
	   eshell-ls-directory-face
	   eshell-ls-executable-face
	   eshell-ls-missing-face
	   eshell-ls-product-face
	   eshell-ls-special-face
	   eshell-ls-symlink-face
	   eshell-ls-unreadable-face
	   eshell-prompt-face
	   fancy-widget-button-face
	   fancy-widget-button-highlight-face
	   fancy-widget-button-pressed-face
	   fancy-widget-button-pressed-highlight-face
	   fancy-widget-documentation-face
	   fancy-widget-field-face
	   fancy-widget-inactive-face
	   fancy-widget-single-line-field-face
	   font-latex-bold-face
	   font-latex-sedate-face
	   font-latex-title-4-face
	   font-latex-warning-face
	   font-lock-builtin-face
	   font-lock-comment-delimiter-face
	   font-lock-comment-face
	   font-lock-constant-face
	   font-lock-doc-face
	   font-lock-doc-string-face
	   font-lock-function-name-face
	   font-lock-keyword-face
	   font-lock-negation-char-face
	   font-lock-operator-face
	   font-lock-preprocessor-face
	   font-lock-pseudo-keyword-face
	   font-lock-string-face
	   font-lock-type-face
	   font-lock-variable-name-face
	   font-lock-warning-face
	   gnus-cite-face-1
	   gnus-cite-face-10
	   gnus-cite-face-11
	   gnus-cite-face-2
	   gnus-cite-face-3
	   gnus-cite-face-4
	   gnus-cite-face-5
	   gnus-cite-face-6
	   gnus-cite-face-7
	   gnus-cite-face-8
	   gnus-cite-face-9
	   gnus-group-mail-1-empty-face
	   gnus-group-mail-2-empty-face
	   gnus-group-mail-3-empty-face
	   gnus-group-mail-3-face
	   gnus-group-news-1-empty-face
	   gnus-group-news-2-empty-face
	   gnus-group-news-3-empty-face
	   gnus-header-content-face
	   gnus-header-from-face
	   gnus-header-name-face
	   gnus-header-newsgroups-face
	   gnus-header-subject-face
	   gnus-signature-face
	   gnus-summary-cancelled-face
	   gnus-summary-high-ancient-face
	   gnus-summary-high-read-face
	   gnus-summary-high-ticked-face
	   gnus-summary-high-unread-face
	   gnus-summary-low-ancient-face
	   gnus-summary-low-read-face
	   gnus-summary-low-ticked-face
	   gnus-summary-low-unread-face
	   gnus-summary-normal-ancient-face
	   gnus-summary-normal-read-face
	   gnus-summary-normal-ticked-face
	   gnus-summary-normal-unread-face
	   gnus-summary-selected-face
	   highlight-current-line-face
	   holiday-face
	   ibuffer-deletion-face
	   ibuffer-help-buffer-face
	   ibuffer-marked-face
	   ibuffer-special-buffer-face
	   ido-first-match-face
	   ido-only-match-face
	   ido-subdir-face
	   imaxima-latex-error-face
	   isearch-lazy-highlight-face
	   jde-java-font-lock-constant-face
	   jde-java-font-lock-doc-tag-face
	   jde-java-font-lock-link-face
	   jde-java-font-lock-modifier-face
	   jde-java-font-lock-number-face
	   jde-java-font-lock-operator-face
	   jde-java-font-lock-package-face
	   keywiz-command-face
	   keywiz-right-face
	   keywiz-wrong-face
	   makefile-shell-face
	   makefile-space-face
	   message-cited-text-face
	   message-header-cc-face
	   message-header-from-face
	   message-header-name-face
	   message-header-newsgroups-face
	   message-header-other-face
	   message-header-subject-face
	   message-header-to-face
	   message-header-xheader-face
	   message-mml-face
	   message-separator-face
	   mtorus-highlight-face
	   mtorus-notify-highlight-face
	   nxml-attribute-colon-face
	   nxml-attribute-local-name-face
	   nxml-attribute-prefix-face
	   nxml-attribute-value-delimiter-face
	   nxml-attribute-value-face
	   nxml-cdata-section-CDATA-face
	   nxml-cdata-section-content-face
	   nxml-cdata-section-delimiter-face
	   nxml-char-ref-delimiter-face
	   nxml-char-ref-number-face
	   nxml-comment-content-face
	   nxml-comment-delimiter-face
	   nxml-delimited-data-face
	   nxml-delimiter-face
	   nxml-element-colon-face
	   nxml-element-local-name-face
	   nxml-element-prefix-face
	   nxml-entity-ref-delimiter-face
	   nxml-entity-ref-name-face
	   nxml-name-face
	   nxml-namespace-attribute-colon-face
	   nxml-namespace-attribute-prefix-face
	   nxml-namespace-attribute-xmlns-face
	   nxml-processing-instruction-content-face
	   nxml-processing-instruction-delimiter-face
	   nxml-processing-instruction-target-face
	   nxml-ref-face
	   nxml-tag-delimiter-face
	   nxml-tag-slash-face
	   nxml-text-face
	   org-agenda-date-today-face
	   org-agenda-structure-face
	   org-archived-face
	   org-column-face
					;org-checkbox-face
	   org-date-face
	   org-deadline-announce-face
	   org-done-face
	   org-formula-face
	   org-headline-done-face
	   org-hide-face
	   org-level-1-face
	   org-level-2-face
	   org-level-3-face
	   org-level-4-face
	   org-level-5-face
	   org-level-6-face
	   org-level-7-face
	   org-level-8-face
	   org-link-face
					;org-priority-face
	   org-scheduled-face
	   org-scheduled-previously-face
	   org-scheduled-today-face
	   org-special-keyword-face
	   org-table-face
	   org-tag-face
	   org-time-grid-face
	   org-todo-face
	   org-upcoming-deadline-face
	   org-warning-face
	   paren-face
	   plain-widget-button-face
	   plain-widget-button-pressed-face
	   plain-widget-documentation-face
	   plain-widget-field-face
	   plain-widget-inactive-face
	   plain-widget-single-line-field-face
	   rpm-spec-dir-face
	   rpm-spec-doc-face
	   rpm-spec-ghost-face
	   rpm-spec-macro-face
	   rpm-spec-obsolete-tag-face
	   rpm-spec-package-face
	   rpm-spec-section-face
	   rpm-spec-tag-face
	   rpm-spec-var-face
	   setnu-line-number-face
	   show-paren-match-face
	   show-paren-mismatch-face
	   speedbar-button-face
	   speedbar-directory-face
	   speedbar-file-face
	   speedbar-highlight-face
	   speedbar-tag-face
	   strokes-char-face
	   todoo-item-assigned-header-face
	   todoo-item-header-face
	   todoo-sub-item-header-face
	   tuareg-font-lock-governing-face
	   tuareg-font-lock-interactive-error-face
	   tuareg-font-lock-interactive-output-face
	   tuareg-font-lock-operator-face
	   w3m-anchor-face
	   w3m-arrived-anchor-face
	   w3m-form-button-face
	   w3m-form-button-mouse-face
	   w3m-form-button-pressed-face
	   w3m-form-face
	   w3m-image-face
	   w3m-tab-background-face
	   w3m-tab-selected-face
	   w3m-tab-selected-retrieving-face
	   w3m-tab-unselected-face
	   w3m-tab-unselected-retrieving-face
	   widget-button-face
	   widget-button-highlight-face
	   widget-button-pressed-face
	   widget-button-pressed-highlight-face
	   widget-documentation-face
	   widget-field-face
	   widget-inactive-face
	   widget-single-line-field-face
	   flyspell-duplicate-face
	   flyspell-incorrect-face
	   wl-highlight-message-headers-face
	   wl-highlight-message-header-contents-face
	   wl-highlight-message-important-header-contents-face
	   wl-highlight-message-important-header-contents2-face
	   wl-highlight-message-unimportant-header-contents-face
	   wl-highlight-message-citation-header-face
	   wl-highlight-message-cited-text-1-face
	   wl-highlight-message-cited-text-2-face
	   wl-highlight-message-cited-text-3-face
	   wl-highlight-message-cited-text-4-face
	   wl-highlight-message-signature-face
	   wl-highlight-summary-answered-face
	   wl-highlight-summary-new-face
	   wl-highlight-summary-displaying-face
	   wl-highlight-thread-indent-face
	   wl-highlight-summary-thread-top-face
	   wl-highlight-summary-normal-face
	   wl-highlight-folder-zero-face
	   wl-highlight-folder-few-face
	   wl-highlight-folder-many-face
	   wl-highlight-folder-unread-face
	   wl-highlight-folder-path-face
	   elscreen-tab-background-face
	   elscreen-tab-control-face
	   elscreen-tab-current-screen-face
	   elscreen-tab-other-screen-face
	   identica-uri-face
	   twitter-time-stamp-face
	   twitter-user-name-face
	   twitter-header-face
	   ))
      )))

(defalias 'zenburn #'color-theme-zenburn)

(provide 'zenburn)

;; Local Variables:
;; time-stamp-format: "%:y-%02m-%02d %02H:%02M"
;; time-stamp-start: "Updated: "
;; time-stamp-end: "$"
;; End:

;;; zenburn.el ends here.
