;;; color-theme-zenburn.el --- A low contrast color theme for Emacs.

;; Copyright (C) 2011 Bozhidar Batsov

;; Author: Bozhidar Batsov <bozhidar.batsov@gmail.com>
;; URL: http://github.com/bbatsov/zenburn-emacs
;; Version: 0.3
;; Package-Requires: ((color-theme "6.6.1"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; A port of the popular Vim theme Zenburn for Emacs, built on top of
;; the color-theme package. There exists one other version of the
;; theme by Daniel Brockman. My version was originally based on it,
;; but it was in such a disarray, that I decided to rewrite it from
;; scratch in a more maintainable manner (hopefully).
;;
;;; Installation:
;;
;;   (require 'color-theme-zenburn)
;;   (color-theme-zenburn)
;;
;; Don't forget that the theme requires the presence of the
;; color-theme package in your Emacs load-path.
;;
;;; Bugs
;;
;; None that I'm aware of.
;;
;;; Credits
;;
;; Jani Nurminen created the original theme for vim on such this port
;; is based.
;;
;;; Code

;; requires
(require 'color-theme)

;; color definitions
;; colors with +x are lighter, colors with -x are darker
(defvar zenburn-fg "#dcdccc")
(defvar zenburn-fg-1 "#656555")
(defvar zenburn-bg-1 "#2b2b2b")
(defvar zenburn-bg "#3f3f3f")
(defvar zenburn-bg+1 "#4f4f4f")
(defvar zenburn-bg+2 "#5f5f5f")
(defvar zenburn-bg+3 "#6f6f6f")
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
                 zenburn-magenta zenburn-cyan
                 ;; dirty fix
                 "white")))

(defun color-theme-zenburn ()
  (interactive)
  (color-theme-install
   `(color-theme-zenburn
     ;;; color-theme mapping
     ((foreground-color . ,zenburn-fg)
      (background-color . ,zenburn-bg)
      (background-mode . dark)
      (cursor-color . ,zenburn-fg))

     ;;; define some reusable zenburn faces that we can inherit from afterwards
     (zenburn-strong-1-face ((t (:foreground ,zenburn-yellow :weight bold))))
     (zenburn-strong-2-face ((t (:foreground ,zenburn-orange :weight bold))))
     (zenburn-warning-face ((t (:foreground ,zenburn-yellow-1 :weight bold :underline t))))
     (zenburn-error-face ((t (:foreground ,zenburn-red-1 :weight bold :underline t))))

     ;;; basic coloring
     (default ((t (:foreground ,zenburn-fg))))
     (cursor
      ((t (:foreground ,zenburn-fg))))
     (escape-glyph-face ((t (:foreground ,zenburn-red))))
     (fringe ((t (:foreground ,zenburn-fg :background ,zenburn-bg))))
     (header-line ((t (:foreground ,zenburn-yellow :background ,zenburn-bg-1))))
     (highlight ((t (:background ,zenburn-bg+1))))

     ;;; compilation
     (compilation-column-face ((t (:foreground ,zenburn-yellow))))
     (compilation-enter-directory-face ((t (:foreground ,zenburn-green))))
     (compilation-error-face ((t (:inherit zenburn-error-face))))
     (compilation-face ((t (:foreground ,zenburn-fg))))
     (compilation-info-face ((t (:foreground ,zenburn-blue))))
     (compilation-info ((t (:foreground ,zenburn-green+4 :underline t))))
     (compilation-leave-directory-face ((t (:foreground ,zenburn-green))))
     (compilation-line-face ((t (:foreground ,zenburn-yellow))))
     (compilation-line-number ((t (:foreground ,zenburn-yellow))))
     (compilation-message-face ((t (:foreground ,zenburn-blue))))
     (compilation-warning-face ((t (:inherit zenburn-warning-face))))

     ;;; grep
     (grep-context-face ((t (:foreground ,zenburn-fg))))
     (grep-error-face ((t (:inherit zenburn-error-face))))
     (grep-hit-face ((t (:foreground ,zenburn-blue))))
     (grep-match-face ((t (:inherit zenburn-strong-2-face))))
     (match ((t (:background ,zenburn-bg-1 :foreground ,zenburn-orange :weight bold))))

     ;; faces used by isearch
     (isearch ((t (:foreground ,zenburn-yellow :background ,zenburn-bg-1))))
     (isearch-fail ((t (:foreground ,zenburn-fg :background ,zenburn-red-4))))
     (lazy-highlight ((t (:foreground ,zenburn-yellow :background ,zenburn-bg+2))))

     (menu ((t (:foreground ,zenburn-fg :background ,zenburn-bg))))
     (minibuffer-prompt ((t (:foreground ,zenburn-yellow))))
     (mode-line
      ((t (:foreground ,zenburn-green+1 :background ,zenburn-bg-1))))
     (mode-line-buffer-id ((t (:inherit zenburn-strong-1-face))))
     (mode-line-inactive
      ((t (:foreground ,zenburn-green-1  :background ,zenburn-bg-1))))
     (region ((t (:background ,zenburn-bg-1))))
     (secondary-selection ((t (:background ,zenburn-bg+2))))
     (trailing-whitespace ((t (:background ,zenburn-red))))
     (vertical-border ((t (:foreground ,zenburn-fg))))

     ;;; font lock
     (font-lock-builtin-face ((t (:foreground ,zenburn-blue))))
     (font-lock-comment-face ((t (:foreground ,zenburn-green))))
     (font-lock-comment-delimiter-face ((t (:foreground ,zenburn-green))))
     (font-lock-constant-face ((t (:foreground ,zenburn-green+4))))
     (font-lock-doc-face ((t (:foreground ,zenburn-green+1))))
     (font-lock-doc-string-face ((t (:foreground ,zenburn-blue+1))))
     (font-lock-function-name-face ((t (:foreground ,zenburn-blue))))
     (font-lock-keyword-face ((t (:inherit zenburn-strong-1-face))))
     (font-lock-negation-char-face ((t (:foreground ,zenburn-fg))))
     (font-lock-preprocessor-face ((t (:foreground ,zenburn-blue))))
     (font-lock-string-face ((t (:foreground ,zenburn-red))))
     (font-lock-type-face ((t (:foreground ,zenburn-blue))))
     (font-lock-variable-name-face ((t (:foreground ,zenburn-orange))))
     (font-lock-warning-face ((t (:inherit zenburn-warning-face))))

     (c-annotation-face ((t (:inherit font-lock-constant-face))))

     ;;; external

     ;; auctex
     (font-latex-bold ((t (:inherit bold))))
     (font-latex-warning ((t (:inherit font-lock-warning-face))))
     (font-latex-sedate ((t (:inherit zenburn-strong-1-face))))
     (font-latex-title-4 ((t (:inherit variable-pitch :weight bold))))

     ;; auto-complete
     (ac-candidate-face ((t (:background ,zenburn-bg+3 :foreground "black"))))
     (ac-selection-face ((t (:background ,zenburn-blue-4 :foreground ,zenburn-fg))))
     (popup-tip-face ((t (:background ,zenburn-yellow-2 :foreground "black"))))
     (popup-scroll-bar-foreground-face ((t (:background ,zenburn-blue-5))))
     (popup-scroll-bar-background-face ((t (:background ,zenburn-bg-1))))
     (popup-isearch-match ((t (:background ,zenburn-bg :foreground ,zenburn-fg))))

     ;; diff
     (diff-added ((t (:foreground ,zenburn-green+4))))
     (diff-changed ((t (:foreground ,zenburn-yellow))))
     (diff-removed ((t (:foreground ,zenburn-red))))
     (diff-header ((t (:background ,zenburn-bg+1))))
     (diff-file-header
      ((t (:background ,zenburn-bg+2 :foreground ,zenburn-fg :bold t))))

     ;; eshell
     (eshell-prompt ((t (:inherit zenburn-strong-1-face))))
     (eshell-ls-archive ((t (:foreground ,zenburn-red-1 :weight bold))))
     (eshell-ls-backup ((t (:inherit font-lock-comment))))
     (eshell-ls-clutter ((t (:inherit font-lock-comment))))
     (eshell-ls-directory ((t (:foreground ,zenburn-blue+1 :weight bold))))
     (eshell-ls-executable ((t (:foreground ,zenburn-red+1 :weight bold))))
     (eshell-ls-unreadable ((t (:foreground ,zenburn-fg))))
     (eshell-ls-missing ((t (:inherit font-lock-warning))))
     (eshell-ls-product ((t (:inherit font-lock-doc))))
     (eshell-ls-special ((t (:inherit zenburn-strong-1-face))))
     (eshell-ls-symlink ((t (:foreground ,zenburn-cyan :weight bold))))

     ;; flymake
     (flymake-errline ((t (:inherit zenburn-error-face))))
     (flymake-warnline ((t (:inherit zenburn-warning-face))))

     ;; flyspell
     (flyspell-duplicate ((t (:inherit zenburn-warning-face))))
     (flyspell-incorrect ((t (:inherit zenburn-error-face))))

     ;; erc
     (erc-action-face ((t (:inherit erc-default-face))))
     (erc-bold-face ((t (:weight bold))))
     (erc-current-nick-face ((t (:inherit zenburn-strong-1-face))))
     (erc-dangerous-host-face ((t (:inherit font-lock-warning))))
     (erc-default-face ((t (:foreground ,zenburn-fg))))
     (erc-direct-msg-face ((t (:inherit erc-default))))
     (erc-error-face ((t (:inherit font-lock-warning))))
     (erc-fool-face ((t (:inherit erc-default))))
     (erc-highlight-face ((t (:inherit hover-highlight))))
     (erc-input-face ((t (:foreground ,zenburn-yellow))))
     (erc-keyword-face ((t (:inherit zenburn-strong-1-face))))
     (erc-nick-default-face ((t (:weight bold))))
     (erc-my-nick-face ((t (:foreground ,zenburn-red :weight bold))))
     (erc-nick-msg-face ((t (:inherit erc-default))))
     (erc-notice-face ((t (:foreground ,zenburn-green))))
     (erc-pal-face ((t (:foreground ,zenburn-orange :weight bold))))
     (erc-prompt-face ((t (:inherit zenburn-strong-2-face))))
     (erc-timestamp-face ((t (:foreground ,zenburn-green+1))))
     (erc-underline-face ((t (:underline t))))

     ;; gnus
     (gnus-group-mail-1-face ((t (:bold t :inherit gnus-group-mail-1-empty))))
     (gnus-group-mail-1-empty-face ((t (:inherit gnus-group-news-1-empty))))
     (gnus-group-mail-2-face ((t (:bold t :inherit gnus-group-mail-2-empty))))
     (gnus-group-mail-2-empty-face ((t (:inherit gnus-group-news-2-empty))))
     (gnus-group-mail-3-face ((t (:bold t :inherit gnus-group-mail-3-empty))))
     (gnus-group-mail-3-empty-face ((t (:inherit gnus-group-news-3-empty))))
     (gnus-group-mail-4-face ((t (:bold t :inherit gnus-group-mail-4-empty))))
     (gnus-group-mail-4-empty-face ((t (:inherit gnus-group-news-4-empty))))
     (gnus-group-mail-5-face ((t (:bold t :inherit gnus-group-mail-5-empty))))
     (gnus-group-mail-5-empty-face ((t (:inherit gnus-group-news-5-empty))))
     (gnus-group-mail-6-face ((t (:bold t :inherit gnus-group-mail-6-empty))))
     (gnus-group-mail-6-empty-face ((t (:inherit gnus-group-news-6-empty))))
     (gnus-group-mail-low-face ((t (:bold t :inherit gnus-group-mail-low-empty))))
     (gnus-group-mail-low-empty-face ((t (:inherit gnus-group-news-low-empty))))
     (gnus-group-news-1-face ((t (:bold t :inherit gnus-group-news-1-empty))))
     (gnus-group-news-2-face ((t (:bold t :inherit gnus-group-news-2-empty))))
     (gnus-group-news-3-face ((t (:bold t :inherit gnus-group-news-3-empty))))
     (gnus-group-news-4-face ((t (:bold t :inherit gnus-group-news-4-empty))))
     (gnus-group-news-5-face ((t (:bold t :inherit gnus-group-news-5-empty))))
     (gnus-group-news-6-face ((t (:bold t :inherit gnus-group-news-6-empty))))
     (gnus-group-news-low-face ((t (:bold t :inherit gnus-group-news-low-empty))))
     (gnus-header-content-face ((t (:inherit message-header-other))))
     (gnus-header-from-face ((t (:inherit message-header-from))))
     (gnus-header-name-face ((t (:inherit message-header-name))))
     (gnus-header-newsgroups-face ((t (:inherit message-header-other))))
     (gnus-header-subject-face ((t (:inherit message-header-subject))))
     (gnus-summary-cancelled-face ((t (:foreground ,zenburn-orange))))
     (gnus-summary-high-ancient-face ((t (:foreground ,zenburn-blue))))
     (gnus-summary-high-read-face ((t (:foreground ,zenburn-green :weight bold))))
     (gnus-summary-high-ticked-face ((t (:inherit zenburn-strong-2-face))))
     (gnus-summary-high-unread-face ((t (:foreground ,zenburn-fg :weight bold))))
     (gnus-summary-low-ancient-face ((t (:foreground ,zenburn-blue))))
     (gnus-summary-low-read-face ((t (:foreground ,zenburn-green))))
     (gnus-summary-low-ticked-face ((t (:inherit zenburn-strong-2-face))))
     (gnus-summary-low-unread-face ((t (:foreground ,zenburn-fg))))
     (gnus-summary-normal-ancient-face ((t (:foreground ,zenburn-blue))))
     (gnus-summary-normal-read-face ((t (:foreground ,zenburn-green))))
     (gnus-summary-normal-ticked-face ((t (:inherit zenburn-strong-2-face))))
     (gnus-summary-normal-unread-face ((t (:foreground ,zenburn-fg))))
     (gnus-summary-selected-face ((t (:inherit zenburn-strong-1-face))))
     (gnus-cite-1-face ((t (:foreground ,zenburn-blue))))
     (gnus-cite-10-face ((t (:foreground ,zenburn-yellow-1))))
     (gnus-cite-11-face ((t (:foreground ,zenburn-yellow))))
     (gnus-cite-2-face ((t (:foreground ,zenburn-blue-1))))
     (gnus-cite-3-face ((t (:foreground ,zenburn-blue-2))))
     (gnus-cite-4-face ((t (:foreground ,zenburn-green+2))))
     (gnus-cite-5-face ((t (:foreground ,zenburn-green+1))))
     (gnus-cite-6-face ((t (:foreground ,zenburn-green))))
     (gnus-cite-7-face ((t (:foreground ,zenburn-red))))
     (gnus-cite-8-face ((t (:foreground ,zenburn-red-1))))
     (gnus-cite-9-face ((t (:foreground ,zenburn-red-2))))
     (gnus-group-news-1-empty-face ((t (:foreground ,zenburn-yellow))))
     (gnus-group-news-2-empty-face ((t (:foreground ,zenburn-green+3))))
     (gnus-group-news-3-empty-face ((t (:foreground ,zenburn-green+1))))
     (gnus-group-news-4-empty-face ((t (:foreground ,zenburn-blue-2))))
     (gnus-group-news-5-empty-face ((t (:foreground ,zenburn-blue-3))))
     (gnus-group-news-6-empty-face ((t (:foreground ,zenburn-bg+2))))
     (gnus-group-news-low-empty-face ((t (:foreground ,zenburn-bg+2))))
     (gnus-signature-face ((t (:foreground ,zenburn-yellow))))
     (gnus-x-face ((t (:background ,zenburn-fg :foreground ,zenburn-bg))))

     ;; hl-line-mode
     (hl-line-face ((t (:background ,zenburn-bg-1))))

     ;; ido-mode
     (ido-first-match ((t (:inherit zenburn-strong-1-face))))
     (ido-only-match ((t (:inherit zenburn-strong-2-face))))
     (ido-subdir ((t (:foreground ,zenburn-yellow))))

     (js2-warning-face ((t (:underline ,zenburn-orange))))
     (js2-error-face ((t (:inherit zenburn-error-face))))
     (js2-jsdoc-tag-face ((t (:foreground ,zenburn-green-1))))
     (js2-jsdoc-type-face ((t (:foreground ,zenburn-green+2))))
     (js2-jsdoc-value-face ((t (:foreground ,zenburn-green+3))))
     (js2-function-param-face ((t (:foreground, zenburn-green+3))))
     ;(js2-instance-member-face)
     ;(js2-private-member-face)
     ;(js2-private-function-call-face)
     ;(js2-jsdoc-html-tag-name-face)
     ;(js2-jsdoc-html-tag-delimiter-face)
     ;(js2-magic-paren-face)
     (js2-external-variable-face ((t (:foreground ,zenburn-orange))))

     ;; jabber-mode
     (jabber-roster-user-away ((t (:foreground ,zenburn-green+2))))
     (jabber-roster-user-online ((t (:foreground ,zenburn-blue-1))))
     (jabber-roster-user-dnd ((t (:foreground ,zenburn-red+1))))
     (jabber-rare-time-face ((t (:foreground ,zenburn-green+1))))
     (jabber-chat-prompt-local ((t (:foreground ,zenburn-blue-1))))
     (jabber-chat-prompt-foreign ((t (:foreground ,zenburn-red+1))))
     (jabber-activity-face((t (:foreground ,zenburn-red+1))))
     (jabber-activity-personal-face ((t (:foreground ,zenburn-blue+1))))


     ;; linum-mode
     (linum ((t (:foreground ,zenburn-fg-1 :background ,zenburn-bg-1))))

     ;; magit
     (magit-section-title ((t (:inherit zenburn-strong-1-face))))
     (magit-branch ((t (:inherit zenburn-strong-2-face))))

     ;; message-mode
     (message-cited-text-face ((t (:inherit font-lock-comment))))
     (message-header-name-face ((t (:foreground ,zenburn-green+1))))
     (message-header-other-face ((t (:foreground ,zenburn-green))))
     (message-header-to-face ((t (:inherit zenburn-strong-1-face))))
     (message-header-from-face ((t (:inherit zenburn-strong-1-face))))
     (message-header-cc-face ((t (:inherit zenburn-strong-1-face))))
     (message-header-newsgroups-face ((t (:inherit zenburn-strong-1-face))))
     (message-header-subject-face ((t (:inherit zenburn-strong-2-face))))
     (message-header-xheader-face ((t (:foreground ,zenburn-green))))
     (message-mml-face ((t (:inherit zenburn-strong-1-face))))
     (message-separator-face ((t (:inherit font-lock-comment))))

     ;; mew
     (mew-face-header-subject ((t (:foreground ,zenburn-orange))))
     (mew-face-header-from ((t (:foreground ,zenburn-yellow))))
     (mew-face-header-date ((t (:foreground ,zenburn-green))))
     (mew-face-header-to ((t (:foreground ,zenburn-red))))
     (mew-face-header-key ((t (:foreground ,zenburn-green))))
     (mew-face-header-private ((t (:foreground ,zenburn-green))))
     (mew-face-header-important ((t (:foreground ,zenburn-blue))))
     (mew-face-header-marginal ((t (:foreground ,zenburn-fg :weight bold))))
     (mew-face-header-warning ((t (:foreground ,zenburn-red))))
     (mew-face-header-xmew ((t (:foreground ,zenburn-green))))
     (mew-face-header-xmew-bad ((t (:foreground ,zenburn-red))))
     (mew-face-body-url ((t (:foreground ,zenburn-orange))))
     (mew-face-body-comment ((t (:foreground ,zenburn-fg :slant italic))))
     (mew-face-body-cite1 ((t (:foreground ,zenburn-green))))
     (mew-face-body-cite2 ((t (:foreground ,zenburn-blue))))
     (mew-face-body-cite3 ((t (:foreground ,zenburn-orange))))
     (mew-face-body-cite4 ((t (:foreground ,zenburn-yellow))))
     (mew-face-body-cite5 ((t (:foreground ,zenburn-red))))
     (mew-face-mark-review ((t (:foreground ,zenburn-blue))))
     (mew-face-mark-escape ((t (:foreground ,zenburn-green))))
     (mew-face-mark-delete ((t (:foreground ,zenburn-red))))
     (mew-face-mark-unlink ((t (:foreground ,zenburn-yellow))))
     (mew-face-mark-refile ((t (:foreground ,zenburn-green))))
     (mew-face-mark-unread ((t (:foreground ,zenburn-red-2))))
     (mew-face-eof-message ((t (:foreground ,zenburn-green))))
     (mew-face-eof-part ((t (:foreground ,zenburn-yellow))))

     ;; nav
     (nav-face-heading ((t (:foreground ,zenburn-yellow))))
     (nav-face-button-num ((t (:foreground ,zenburn-cyan))))
     (nav-face-dir ((t (:foreground ,zenburn-green))))
     (nav-face-hdir ((t (:foreground ,zenburn-red))))
     (nav-face-file ((t (:foreground ,zenburn-fg))))
     (nav-face-hfile ((t (:foreground ,zenburn-red-4))))

     ;; org-mode
     (org-agenda-date-today
      ((t (:foreground "white" :slant italic :weight bold))) t)
     (org-agenda-structure
      ((t (:inherit font-lock-comment-face))))
     (org-archived ((t (:foreground ,zenburn-fg :weight bold))))
     (org-checkbox ((t (:background ,zenburn-bg+2 :foreground "white"
                                    :box (:line-width 1 :style released-button)))))
     (org-date ((t (:foreground ,zenburn-blue :underline t))))
     (org-deadline-announce ((t (:foreground ,zenburn-red-1))))
     (org-done ((t (:bold t :weight bold :foreground ,zenburn-green+3))))
     (org-formula ((t (:foreground ,zenburn-yellow-2))))
     (org-headline-done ((t (:foreground ,zenburn-green+3))))
     (org-hide ((t (:foreground ,zenburn-bg-1))))
     (org-level-1 ((t (:foreground ,zenburn-orange))))
     (org-level-2 ((t (:foreground ,zenburn-green+1))))
     (org-level-3 ((t (:foreground ,zenburn-blue-1))))
     (org-level-4 ((t (:foreground ,zenburn-yellow-2))))
     (org-level-5 ((t (:foreground ,zenburn-cyan))))
     (org-level-6 ((t (:foreground ,zenburn-green-1))))
     (org-level-7 ((t (:foreground ,zenburn-red-4))))
     (org-level-8 ((t (:foreground ,zenburn-blue-4))))
     (org-link ((t (:foreground ,zenburn-yellow-2 :underline t))))
     (org-scheduled ((t (:foreground ,zenburn-green+4))))
     (org-scheduled-previously ((t (:foreground ,zenburn-red-4))))
     (org-scheduled-today ((t (:foreground ,zenburn-blue+1))))
     (org-special-keyword ((t (:foreground ,zenburn-yellow-1))))
     (org-table ((t (:foreground ,zenburn-green+2))))
     (org-tag ((t (:bold t :weight bold))))
     (org-time-grid ((t (:foreground ,zenburn-orange))))
     (org-todo ((t (:bold t :foreground ,zenburn-red :weight bold))))
     (org-upcoming-deadline ((t (:inherit font-lock-keyword-face))))
     (org-warning ((t (:bold t :foreground ,zenburn-red :weight bold))))

     ;; outline
     (outline-8 ((t (:inherit default))))
     (outline-7 ((t (:inherit outline-8 :height 1.0))))
     (outline-6 ((t (:inherit outline-7 :height 1.0))))
     (outline-5 ((t (:inherit outline-6 :height 1.0))))
     (outline-4 ((t (:inherit outline-5 :height 1.0))))
     (outline-3 ((t (:inherit outline-4 :height 1.0))))
     (outline-2 ((t (:inherit outline-3 :height 1.0))))
     (outline-1 ((t (:inherit outline-2 :height 1.0))))

     ;; rainbow-delimiters
     (rainbow-delimiters-depth-1-face ((t (:foreground ,zenburn-cyan))))
     (rainbow-delimiters-depth-2-face ((t (:foreground ,zenburn-yellow))))
     (rainbow-delimiters-depth-3-face ((t (:foreground ,zenburn-blue+1))))
     (rainbow-delimiters-depth-4-face ((t (:foreground ,zenburn-red+1))))
     (rainbow-delimiters-depth-5-face ((t (:foreground ,zenburn-orange))))
     (rainbow-delimiters-depth-6-face ((t (:foreground ,zenburn-blue-1))))
     (rainbow-delimiters-depth-7-face ((t (:foreground ,zenburn-green+4))))
     (rainbow-delimiters-depth-8-face ((t (:foreground ,zenburn-red-3))))
     (rainbow-delimiters-depth-9-face ((t (:foreground ,zenburn-yellow-2))))
     (rainbow-delimiters-depth-10-face ((t (:foreground ,zenburn-green+2))))
     (rainbow-delimiters-depth-11-face ((t (:foreground ,zenburn-blue+1))))
     (rainbow-delimiters-depth-12-face ((t (:foreground ,zenburn-red-4))))

     ;; rpm-mode
     (rpm-spec-dir-face ((t (:foreground ,zenburn-green))))
     (rpm-spec-doc-face ((t (:foreground ,zenburn-green))))
     (rpm-spec-ghost-face ((t (:foreground ,zenburn-red))))
     (rpm-spec-macro-face ((t (:foreground ,zenburn-yellow))))
     (rpm-spec-obsolete-tag-face ((t (:foreground ,zenburn-red))))
     (rpm-spec-package-face ((t (:foreground ,zenburn-red))))
     (rpm-spec-section-face ((t (:foreground ,zenburn-yellow))))
     (rpm-spec-tag-face ((t (:foreground ,zenburn-blue))))
     (rpm-spec-var-face ((t (:foreground ,zenburn-red))))

     ;; rst-mode
     (rst-level-1-face ((t (:foreground ,zenburn-orange))))
     (rst-level-2-face ((t (:foreground ,zenburn-green+1))))
     (rst-level-3-face ((t (:foreground ,zenburn-blue-1))))
     (rst-level-4-face ((t (:foreground ,zenburn-yellow-2))))
     (rst-level-5-face ((t (:foreground ,zenburn-cyan))))
     (rst-level-6-face ((t (:foreground ,zenburn-green-1))))

     ;; show-paren
     (show-paren-mismatch ((t (:foreground ,zenburn-red-3 :weight bold))))
     (show-paren-match ((t (:foreground ,zenburn-blue-1 :weight bold))))

     ;; wanderlust
     (wl-highlight-folder-few-face ((t (:foreground ,zenburn-red-2))))
     (wl-highlight-folder-many-face ((t (:foreground ,zenburn-red-1))))
     (wl-highlight-folder-path-face ((t (:foreground ,zenburn-orange))))
     (wl-highlight-folder-unread-face ((t (:foreground ,zenburn-blue))))
     (wl-highlight-folder-zero-face ((t (:foreground ,zenburn-fg))))
     (wl-highlight-folder-unknown-face ((t (:foreground ,zenburn-blue))))
     (wl-highlight-message-citation-header ((t (:foreground ,zenburn-red-1))))
     (wl-highlight-message-cited-text-1 ((t (:foreground ,zenburn-red))))
     (wl-highlight-message-cited-text-2 ((t (:foreground ,zenburn-green+2))))
     (wl-highlight-message-cited-text-3 ((t (:foreground ,zenburn-blue))))
     (wl-highlight-message-cited-text-4 ((t (:foreground ,zenburn-blue+1))))
     (wl-highlight-message-header-contents-face ((t (:foreground ,zenburn-green))))
     (wl-highlight-message-headers-face ((t (:foreground ,zenburn-red+1))))
     (wl-highlight-message-important-header-contents ((t (:foreground ,zenburn-green+2))))
     (wl-highlight-message-header-contents ((t (:foreground ,zenburn-green+1))))
     (wl-highlight-message-important-header-contents2 ((t (:foreground ,zenburn-green+2))))
     (wl-highlight-message-signature ((t (:foreground ,zenburn-green))))
     (wl-highlight-message-unimportant-header-contents ((t (:foreground ,zenburn-fg))))
     (wl-highlight-summary-answered-face ((t (:foreground ,zenburn-blue))))
     (wl-highlight-summary-disposed-face ((t (:foreground ,zenburn-fg
                                                          :slant italic))))
     (wl-highlight-summary-new-face ((t (:foreground ,zenburn-blue))))
     (wl-highlight-summary-normal-face ((t (:foreground ,zenburn-fg))))
     (wl-highlight-summary-thread-top-face ((t (:foreground ,zenburn-yellow))))
     (wl-highlight-thread-indent-face ((t (:foreground ,zenburn-magenta))))
     (wl-highlight-summary-refiled-face ((t (:foreground ,zenburn-fg))))
     (wl-highlight-summary-displaying-face ((t (:underline t :weight bold)))))))

(add-to-list 'color-themes '(color-theme-zenburn
                             "Zenburn"
                             "Bozhidar Batsov <bozhidar.batsov@gmail.com"))

(provide 'color-theme-zenburn)

;;; color-theme-zenburn.el ends here.
