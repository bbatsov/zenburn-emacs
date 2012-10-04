;;; zenburn-theme.el --- A low contrast color theme for Emacs.

;; Copyright (C) 2011 Bozhidar Batsov

;; Author: Bozhidar Batsov <bozhidar.batsov@gmail.com>
;; URL: http://github.com/bbatsov/zenburn-emacs
;; Version: 1.7

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
;; A port of the popular Vim theme Zenburn for Emacs 24, built on top of
;; the new built-in theme support in Emacs 24. There exists one other version of the
;; theme by Daniel Brockman. My version was originally based on it,
;; but it was in such a disarray, that I decided to rewrite it from
;; scratch in a more maintainable manner (hopefully).
;;
;;; Installation:
;;
;;   Drop the theme in a folder that is on `custom-theme-load-path'
;; and enjoy!
;;
;; Don't forget that the theme requires Emacs 24.
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
(deftheme zenburn "The Zenburn color theme")

(let ((class '((class color) (min-colors 89)))
      ;; Zenburn palette
      ;; colors with +x are lighter, colors with -x are darker
      (zenburn-fg "#dcdccc")
      (zenburn-fg-1 "#656555")
      (zenburn-bg-1 "#2b2b2b")
      (zenburn-bg-05 "#383838")
      (zenburn-bg "#3f3f3f")
      (zenburn-bg+1 "#4f4f4f")
      (zenburn-bg+2 "#5f5f5f")
      (zenburn-bg+3 "#6f6f6f")
      (zenburn-red+1 "#dca3a3")
      (zenburn-red "#cc9393")
      (zenburn-red-1 "#bc8383")
      (zenburn-red-2 "#ac7373")
      (zenburn-red-3 "#9c6363")
      (zenburn-red-4 "#8c5353")
      (zenburn-orange "#dfaf8f")
      (zenburn-yellow "#f0dfaf")
      (zenburn-yellow-1 "#e0cf9f")
      (zenburn-yellow-2 "#d0bf8f")
      (zenburn-green-1 "#5f7f5f")
      (zenburn-green "#7f9f7f")
      (zenburn-green+1 "#8fb28f")
      (zenburn-green+2 "#9fc59f")
      (zenburn-green+3 "#afd8af")
      (zenburn-green+4 "#bfebbf")
      (zenburn-cyan "#93e0e3")
      (zenburn-blue+1 "#94bff3")
      (zenburn-blue "#8cd0d3")
      (zenburn-blue-1 "#7cb8bb")
      (zenburn-blue-2 "#6ca0a3")
      (zenburn-blue-3 "#5c888b")
      (zenburn-blue-4 "#4c7073")
      (zenburn-blue-5 "#366060")
      (zenburn-magenta "#dc8cc3"))
  (custom-theme-set-faces
   'zenburn
   '(button ((t (:underline t))))
   `(link ((t (:foreground ,zenburn-yellow :underline t :weight bold))))
   `(link-visited ((t (:foreground ,zenburn-yellow-2 :underline t :weight normal))))

   ;;; basic coloring
   `(default ((t (:foreground ,zenburn-fg :background ,zenburn-bg))))
   `(cursor ((t (:foreground ,zenburn-fg :background "white"))))
   `(escape-glyph-face ((t (:foreground ,zenburn-red))))
   `(fringe ((t (:foreground ,zenburn-fg :background ,zenburn-bg+1))))
   `(header-line ((t (:foreground ,zenburn-yellow
                                  :background ,zenburn-bg-1
                                  :box (:line-width -1 :style released-button)))))
   `(highlight ((t (:background ,zenburn-bg-05))))

   ;;; compilation
   `(compilation-column-face ((t (:foreground ,zenburn-yellow))))
   `(compilation-enter-directory-face ((t (:foreground ,zenburn-green))))
   `(compilation-error-face ((t (:foreground ,zenburn-red-1 :weight bold :underline t))))
   `(compilation-face ((t (:foreground ,zenburn-fg))))
   `(compilation-info-face ((t (:foreground ,zenburn-blue))))
   `(compilation-info ((t (:foreground ,zenburn-green+4 :underline t))))
   `(compilation-leave-directory-face ((t (:foreground ,zenburn-green))))
   `(compilation-line-face ((t (:foreground ,zenburn-yellow))))
   `(compilation-line-number ((t (:foreground ,zenburn-yellow))))
   `(compilation-message-face ((t (:foreground ,zenburn-blue))))
   `(compilation-warning-face ((t (:foreground ,zenburn-yellow-1 :weight bold :underline t))))

   ;;; grep
   `(grep-context-face ((t (:foreground ,zenburn-fg))))
   `(grep-error-face ((t (:foreground ,zenburn-red-1 :weight bold :underline t))))
   `(grep-hit-face ((t (:foreground ,zenburn-blue))))
   `(grep-match-face ((t (:foreground ,zenburn-orange :weight bold))))
   `(match ((t (:background ,zenburn-bg-1 :foreground ,zenburn-orange :weight bold))))

   ;; faces used by isearch
   `(isearch ((t (:foreground ,zenburn-yellow :background ,zenburn-bg-1))))
   `(isearch-fail ((t (:foreground ,zenburn-fg :background ,zenburn-red-4))))
   `(lazy-highlight ((t (:foreground ,zenburn-yellow :background ,zenburn-bg+2))))

   `(menu ((t (:foreground ,zenburn-fg :background ,zenburn-bg))))
   `(minibuffer-prompt ((t (:foreground ,zenburn-yellow))))
   `(mode-line
     ((,class (:foreground ,zenburn-green+1
                           :background ,zenburn-bg-1
                           :box (:line-width -1 :style released-button)))
      (t :inverse-video t)))
   `(mode-line-buffer-id ((t (:foreground ,zenburn-yellow :weight bold))))
   `(mode-line-inactive
     ((t (:foreground ,zenburn-green-1
                      :background ,zenburn-bg-05
                      :box (:line-width -1 :style released-button)))))
   `(region ((,class (:background ,zenburn-bg-1))
             (t :inverse-video t)))
   `(secondary-selection ((t (:background ,zenburn-bg+2))))
   `(trailing-whitespace ((t (:background ,zenburn-red))))
   `(vertical-border ((t (:foreground ,zenburn-fg))))

   ;;; font lock
   `(font-lock-builtin-face ((t (:foreground ,zenburn-cyan))))
   `(font-lock-comment-face ((t (:foreground ,zenburn-green))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,zenburn-green))))
   `(font-lock-constant-face ((t (:foreground ,zenburn-green+4))))
   `(font-lock-doc-face ((t (:foreground ,zenburn-green+1))))
   `(font-lock-doc-string-face ((t (:foreground ,zenburn-blue-2))))
   `(font-lock-function-name-face ((t (:foreground ,zenburn-blue))))
   `(font-lock-keyword-face ((t (:foreground ,zenburn-yellow :weight bold))))
   `(font-lock-negation-char-face ((t (:foreground ,zenburn-fg))))
   `(font-lock-preprocessor-face ((t (:foreground ,zenburn-blue+1))))
   `(font-lock-string-face ((t (:foreground ,zenburn-red))))
   `(font-lock-type-face ((t (:foreground ,zenburn-blue-1))))
   `(font-lock-variable-name-face ((t (:foreground ,zenburn-orange))))
   `(font-lock-warning-face ((t (:foreground ,zenburn-yellow-1 :weight bold :underline t))))

   `(c-annotation-face ((t (:inherit font-lock-constant-face))))

   ;;; newsticker
   `(newsticker-date-face ((t (:foreground ,zenburn-fg))))
   `(newsticker-default-face ((t (:foreground ,zenburn-fg))))
   `(newsticker-enclosure-face ((t (:foreground ,zenburn-green+3))))
   `(newsticker-extra-face ((t (:foreground ,zenburn-bg+2 :height 0.8))))
   `(newsticker-feed-face ((t (:foreground ,zenburn-fg))))
   `(newsticker-immortal-item-face ((t (:foreground ,zenburn-green))))
   `(newsticker-new-item-face ((t (:foreground ,zenburn-blue))))
   `(newsticker-obsolete-item-face ((t (:foreground ,zenburn-red))))
   `(newsticker-old-item-face ((t (:foreground ,zenburn-bg+3))))
   `(newsticker-statistics-face ((t (:foreground ,zenburn-fg))))
   `(newsticker-treeview-face ((t (:foreground ,zenburn-fg))))
   `(newsticker-treeview-immortal-face ((t (:foreground ,zenburn-green))))
   `(newsticker-treeview-listwindow-face ((t (:foreground ,zenburn-fg))))
   `(newsticker-treeview-new-face ((t (:foreground ,zenburn-blue :weight bold))))
   `(newsticker-treeview-obsolete-face ((t (:foreground ,zenburn-red))))
   `(newsticker-treeview-old-face ((t (:foreground ,zenburn-bg+3))))
   `(newsticker-treeview-selection-face ((t (:foreground ,zenburn-yellow))))

   ;;; external

   ;; full-ack
   `(ack-separator ((t (:foreground ,zenburn-fg))))
   `(ack-file ((t (:foreground ,zenburn-blue))))
   `(ack-line ((t (:foreground ,zenburn-yellow))))
   `(ack-match ((t (:foreground ,zenburn-orange :background ,zenburn-bg-1 :weight bold))))

   ;; auctex
   `(font-latex-bold ((t (:inherit bold))))
   `(font-latex-warning ((t (:inherit font-lock-warning))))
   `(font-latex-sedate ((t (:foreground ,zenburn-yellow :weight bold ))))
   `(font-latex-title-4 ((t (:inherit variable-pitch :weight bold))))

   ;; auto-complete
   `(ac-candidate-face ((t (:background ,zenburn-bg+3 :foreground "black"))))
   `(ac-selection-face ((t (:background ,zenburn-blue-4 :foreground ,zenburn-fg))))
   `(popup-tip-face ((t (:background ,zenburn-yellow-2 :foreground "black"))))
   `(popup-scroll-bar-foreground-face ((t (:background ,zenburn-blue-5))))
   `(popup-scroll-bar-background-face ((t (:background ,zenburn-bg-1))))
   `(popup-isearch-match ((t (:background ,zenburn-bg :foreground ,zenburn-fg))))

   ;; diff
   `(diff-added ((,class (:foreground ,zenburn-green+4))
                 (t (:foreground ,zenburn-green-1))))
   `(diff-changed ((t (:foreground ,zenburn-yellow))))
   `(diff-removed ((,class (:foreground ,zenburn-red))
                   (t (:foreground ,zenburn-red-3))))
   `(diff-header ((,class (:background ,zenburn-bg+2))
                  (t (:background ,zenburn-fg :foreground ,zenburn-bg))))
   `(diff-file-header
     ((,class (:background ,zenburn-bg+2 :foreground ,zenburn-fg :bold t))
      (t (:background ,zenburn-fg :foreground ,zenburn-bg :bold t))))

   ;; ert
   `(ert-test-result-expected ((t (:foreground ,zenburn-green+4 :background ,zenburn-bg))))
   `(ert-test-result-unexpected ((t (:foreground ,zenburn-red :background ,zenburn-bg))))

   ;; eshell
   `(eshell-prompt ((t (:foreground ,zenburn-yellow :weight bold))))
   `(eshell-ls-archive ((t (:foreground ,zenburn-red-1 :weight bold))))
   `(eshell-ls-backup ((t (:inherit font-lock-comment))))
   `(eshell-ls-clutter ((t (:inherit font-lock-comment))))
   `(eshell-ls-directory ((t (:foreground ,zenburn-blue+1 :weight bold))))
   `(eshell-ls-executable ((t (:foreground ,zenburn-red+1 :weight bold))))
   `(eshell-ls-unreadable ((t (:foreground ,zenburn-fg))))
   `(eshell-ls-missing ((t (:inherit font-lock-warning))))
   `(eshell-ls-product ((t (:inherit font-lock-doc))))
   `(eshell-ls-special ((t (:foreground ,zenburn-yellow :weight bold))))
   `(eshell-ls-symlink ((t (:foreground ,zenburn-cyan :weight bold))))

   ;; flymake
   `(flymake-errline ((t (:foreground ,zenburn-red-1 :weight bold :underline t))))
   `(flymake-warnline ((t (:foreground ,zenburn-yellow-1 :weight bold :underline t))))

   ;; flyspell
   `(flyspell-duplicate ((t (:foreground ,zenburn-yellow-1 :weight bold :underline t))))
   `(flyspell-incorrect ((t (:foreground ,zenburn-red-1 :weight bold :underline t))))

   ;; erc
   `(erc-action-face ((t (:inherit erc-default-face))))
   `(erc-bold-face ((t (:weight bold))))
   `(erc-current-nick-face ((t (:foreground ,zenburn-blue :weight bold))))
   `(erc-dangerous-host-face ((t (:inherit font-lock-warning))))
   `(erc-default-face ((t (:foreground ,zenburn-fg))))
   `(erc-direct-msg-face ((t (:inherit erc-default))))
   `(erc-error-face ((t (:inherit font-lock-warning))))
   `(erc-fool-face ((t (:inherit erc-default))))
   `(erc-highlight-face ((t (:inherit hover-highlight))))
   `(erc-input-face ((t (:foreground ,zenburn-yellow))))
   `(erc-keyword-face ((t (:foreground ,zenburn-blue :weight bold))))
   `(erc-nick-default-face ((t (:foreground ,zenburn-yellow :weight bold))))
   `(erc-my-nick-face ((t (:foreground ,zenburn-red :weight bold))))
   `(erc-nick-msg-face ((t (:inherit erc-default))))
   `(erc-notice-face ((t (:foreground ,zenburn-green))))
   `(erc-pal-face ((t (:foreground ,zenburn-orange :weight bold))))
   `(erc-prompt-face ((t (:foreground ,zenburn-orange :background ,zenburn-bg :weight bold))))
   `(erc-timestamp-face ((t (:foreground ,zenburn-green+1))))
   `(erc-underline-face ((t (:underline t))))

   ;; gnus
   `(gnus-group-mail-1 ((t (:bold t :inherit gnus-group-mail-1-empty))))
   `(gnus-group-mail-1-empty ((t (:inherit gnus-group-news-1-empty))))
   `(gnus-group-mail-2 ((t (:bold t :inherit gnus-group-mail-2-empty))))
   `(gnus-group-mail-2-empty ((t (:inherit gnus-group-news-2-empty))))
   `(gnus-group-mail-3 ((t (:bold t :inherit gnus-group-mail-3-empty))))
   `(gnus-group-mail-3-empty ((t (:inherit gnus-group-news-3-empty))))
   `(gnus-group-mail-4 ((t (:bold t :inherit gnus-group-mail-4-empty))))
   `(gnus-group-mail-4-empty ((t (:inherit gnus-group-news-4-empty))))
   `(gnus-group-mail-5 ((t (:bold t :inherit gnus-group-mail-5-empty))))
   `(gnus-group-mail-5-empty ((t (:inherit gnus-group-news-5-empty))))
   `(gnus-group-mail-6 ((t (:bold t :inherit gnus-group-mail-6-empty))))
   `(gnus-group-mail-6-empty ((t (:inherit gnus-group-news-6-empty))))
   `(gnus-group-mail-low ((t (:bold t :inherit gnus-group-mail-low-empty))))
   `(gnus-group-mail-low-empty ((t (:inherit gnus-group-news-low-empty))))
   `(gnus-group-news-1 ((t (:bold t :inherit gnus-group-news-1-empty))))
   `(gnus-group-news-2 ((t (:bold t :inherit gnus-group-news-2-empty))))
   `(gnus-group-news-3 ((t (:bold t :inherit gnus-group-news-3-empty))))
   `(gnus-group-news-4 ((t (:bold t :inherit gnus-group-news-4-empty))))
   `(gnus-group-news-5 ((t (:bold t :inherit gnus-group-news-5-empty))))
   `(gnus-group-news-6 ((t (:bold t :inherit gnus-group-news-6-empty))))
   `(gnus-group-news-low ((t (:bold t :inherit gnus-group-news-low-empty))))
   `(gnus-header-content ((t (:inherit message-header-other))))
   `(gnus-header-from ((t (:inherit message-header-from))))
   `(gnus-header-name ((t (:inherit message-header-name))))
   `(gnus-header-newsgroups ((t (:inherit message-header-other))))
   `(gnus-header-subject ((t (:inherit message-header-subject))))
   `(gnus-summary-cancelled ((t (:foreground ,zenburn-orange))))
   `(gnus-summary-high-ancient ((t (:foreground ,zenburn-blue))))
   `(gnus-summary-high-read ((t (:foreground ,zenburn-green :weight bold))))
   `(gnus-summary-high-ticked ((t (:foreground ,zenburn-orange :weight bold))))
   `(gnus-summary-high-unread ((t (:foreground ,zenburn-fg :weight bold))))
   `(gnus-summary-low-ancient ((t (:foreground ,zenburn-blue))))
   `(gnus-summary-low-read ((t (:foreground ,zenburn-green))))
   `(gnus-summary-low-ticked ((t (:foreground ,zenburn-orange :weight bold))))
   `(gnus-summary-low-unread ((t (:foreground ,zenburn-fg))))
   `(gnus-summary-normal-ancient ((t (:foreground ,zenburn-blue))))
   `(gnus-summary-normal-read ((t (:foreground ,zenburn-green))))
   `(gnus-summary-normal-ticked ((t (:foreground ,zenburn-orange :weight bold))))
   `(gnus-summary-normal-unread ((t (:foreground ,zenburn-fg))))
   `(gnus-summary-selected ((t (:foreground ,zenburn-yellow :weight bold))))
   `(gnus-cite-1 ((t (:foreground ,zenburn-blue))))
   `(gnus-cite-10 ((t (:foreground ,zenburn-yellow-1))))
   `(gnus-cite-11 ((t (:foreground ,zenburn-yellow))))
   `(gnus-cite-2 ((t (:foreground ,zenburn-blue-1))))
   `(gnus-cite-3 ((t (:foreground ,zenburn-blue-2))))
   `(gnus-cite-4 ((t (:foreground ,zenburn-green+2))))
   `(gnus-cite-5 ((t (:foreground ,zenburn-green+1))))
   `(gnus-cite-6 ((t (:foreground ,zenburn-green))))
   `(gnus-cite-7 ((t (:foreground ,zenburn-red))))
   `(gnus-cite-8 ((t (:foreground ,zenburn-red-1))))
   `(gnus-cite-9 ((t (:foreground ,zenburn-red-2))))
   `(gnus-group-news-1-empty ((t (:foreground ,zenburn-yellow))))
   `(gnus-group-news-2-empty ((t (:foreground ,zenburn-green+3))))
   `(gnus-group-news-3-empty ((t (:foreground ,zenburn-green+1))))
   `(gnus-group-news-4-empty ((t (:foreground ,zenburn-blue-2))))
   `(gnus-group-news-5-empty ((t (:foreground ,zenburn-blue-3))))
   `(gnus-group-news-6-empty ((t (:foreground ,zenburn-bg+2))))
   `(gnus-group-news-low-empty ((t (:foreground ,zenburn-bg+2))))
   `(gnus-signature ((t (:foreground ,zenburn-yellow))))
   `(gnus-x ((t (:background ,zenburn-fg :foreground ,zenburn-bg))))

   ;; helm
   `(helm-header
     ((t (:foreground ,zenburn-green
                      :background ,zenburn-bg
                      :underline nil
                      :box nil))))
   `(helm-source-header
     ((t (:foreground ,zenburn-yellow
                      :background ,zenburn-bg-1
                      :underline nil
                      :weight bold
                      :box (:line-width -1 :style released-button)))))
   `(helm-selection ((t (:background ,zenburn-bg+1 :underline nil))))
   `(helm-selection-line ((t (:background ,zenburn-bg+1))))
   `(helm-visible-mark ((t (:foreground ,zenburn-bg :background ,zenburn-yellow-2))))
   `(helm-candidate-number ((t (:foreground ,zenburn-green+4 :background ,zenburn-bg-1))))

   ;; hl-line-mode
   `(hl-line-face ((,class (:background ,zenburn-bg-05))
                   (t :weight bold)))
   `(hl-line ((,class (:background ,zenburn-bg-05)) ; old emacsen
              (t :weight bold)))

   ;; hl-sexp
   `(hl-sexp-face ((,class (:background ,zenburn-bg+1))
                   (t :weight bold)))

   ;; ido-mode
   `(ido-first-match ((t (:foreground ,zenburn-yellow :weight bold))))
   `(ido-only-match ((t (:foreground ,zenburn-orange :weight bold))))
   `(ido-subdir ((t (:foreground ,zenburn-yellow))))

   ;; js2-mode
   `(js2-warning-face ((t (:underline ,zenburn-orange))))
   `(js2-error-face ((t (:foreground ,zenburn-red :weight bold))))
   `(js2-jsdoc-tag-face ((t (:foreground ,zenburn-green-1))))
   `(js2-jsdoc-type-face ((t (:foreground ,zenburn-green+2))))
   `(js2-jsdoc-value-face ((t (:foreground ,zenburn-green+3))))
   `(js2-function-param-face ((t (:foreground, zenburn-green+3))))
   `(js2-external-variable-face ((t (:foreground ,zenburn-orange))))

   ;; jabber-mode
   `(jabber-roster-user-away ((t (:foreground ,zenburn-green+2))))
   `(jabber-roster-user-online ((t (:foreground ,zenburn-blue-1))))
   `(jabber-roster-user-dnd ((t (:foreground ,zenburn-red+1))))
   `(jabber-rare-time-face ((t (:foreground ,zenburn-green+1))))
   `(jabber-chat-prompt-local ((t (:foreground ,zenburn-blue-1))))
   `(jabber-chat-prompt-foreign ((t (:foreground ,zenburn-red+1))))
   `(jabber-activity-face((t (:foreground ,zenburn-red+1))))
   `(jabber-activity-personal-face ((t (:foreground ,zenburn-blue+1))))
   `(jabber-title-small ((t (:height 1.1 :weight bold))))
   `(jabber-title-medium ((t (:height 1.2 :weight bold))))
   `(jabber-title-large ((t (:height 1.3 :weight bold))))

   ;; linum-mode
   `(linum ((t (:foreground ,zenburn-green+2 :background ,zenburn-bg))))

   ;; magit
   `(magit-section-title ((t (:foreground ,zenburn-yellow :weight bold))))
   `(magit-branch ((t (:foreground ,zenburn-orange :weight bold))))
   `(magit-item-highlight ((t (:background ,zenburn-bg+1))))

   ;; message-mode
   `(message-cited-text ((t (:inherit font-lock-comment))))
   `(message-header-name ((t (:foreground ,zenburn-green+1))))
   `(message-header-other ((t (:foreground ,zenburn-green))))
   `(message-header-to ((t (:foreground ,zenburn-yellow :weight bold))))
   `(message-header-from ((t (:foreground ,zenburn-yellow :weight bold))))
   `(message-header-cc ((t (:foreground ,zenburn-yellow :weight bold))))
   `(message-header-newsgroups ((t (:foreground ,zenburn-yellow :weight bold))))
   `(message-header-subject ((t (:foreground ,zenburn-orange :weight bold))))
   `(message-header-xheader ((t (:foreground ,zenburn-green))))
   `(message-mml ((t (:foreground ,zenburn-yellow :weight bold))))
   `(message-separator ((t (:inherit font-lock-comment))))

   ;; mew
   `(mew-face-header-subject ((t (:foreground ,zenburn-orange))))
   `(mew-face-header-from ((t (:foreground ,zenburn-yellow))))
   `(mew-face-header-date ((t (:foreground ,zenburn-green))))
   `(mew-face-header-to ((t (:foreground ,zenburn-red))))
   `(mew-face-header-key ((t (:foreground ,zenburn-green))))
   `(mew-face-header-private ((t (:foreground ,zenburn-green))))
   `(mew-face-header-important ((t (:foreground ,zenburn-blue))))
   `(mew-face-header-marginal ((t (:foreground ,zenburn-fg :weight bold))))
   `(mew-face-header-warning ((t (:foreground ,zenburn-red))))
   `(mew-face-header-xmew ((t (:foreground ,zenburn-green))))
   `(mew-face-header-xmew-bad ((t (:foreground ,zenburn-red))))
   `(mew-face-body-url ((t (:foreground ,zenburn-orange))))
   `(mew-face-body-comment ((t (:foreground ,zenburn-fg :slant italic))))
   `(mew-face-body-cite1 ((t (:foreground ,zenburn-green))))
   `(mew-face-body-cite2 ((t (:foreground ,zenburn-blue))))
   `(mew-face-body-cite3 ((t (:foreground ,zenburn-orange))))
   `(mew-face-body-cite4 ((t (:foreground ,zenburn-yellow))))
   `(mew-face-body-cite5 ((t (:foreground ,zenburn-red))))
   `(mew-face-mark-review ((t (:foreground ,zenburn-blue))))
   `(mew-face-mark-escape ((t (:foreground ,zenburn-green))))
   `(mew-face-mark-delete ((t (:foreground ,zenburn-red))))
   `(mew-face-mark-unlink ((t (:foreground ,zenburn-yellow))))
   `(mew-face-mark-refile ((t (:foreground ,zenburn-green))))
   `(mew-face-mark-unread ((t (:foreground ,zenburn-red-2))))
   `(mew-face-eof-message ((t (:foreground ,zenburn-green))))
   `(mew-face-eof-part ((t (:foreground ,zenburn-yellow))))

   ;; mic-paren
   `(paren-face-match ((t (:foreground ,zenburn-cyan :background ,zenburn-bg :weight bold))))
   `(paren-face-mismatch ((t (:foreground ,zenburn-bg :background ,zenburn-magenta :weight bold))))
   `(paren-face-no-match ((t (:foreground ,zenburn-bg :background ,zenburn-red :weight bold))))

   ;; nav
   `(nav-face-heading ((t (:foreground ,zenburn-yellow))))
   `(nav-face-button-num ((t (:foreground ,zenburn-cyan))))
   `(nav-face-dir ((t (:foreground ,zenburn-green))))
   `(nav-face-hdir ((t (:foreground ,zenburn-red))))
   `(nav-face-file ((t (:foreground ,zenburn-fg))))
   `(nav-face-hfile ((t (:foreground ,zenburn-red-4))))

   ;; mumamo
   `(mumamo-background-chunk-major ((t (:background nil))))
   `(mumamo-background-chunk-submode1 ((t (:background ,zenburn-bg-1))))
   `(mumamo-background-chunk-submode2 ((t (:background ,zenburn-bg+2))))
   `(mumamo-background-chunk-submode3 ((t (:background ,zenburn-bg+3))))
   `(mumamo-background-chunk-submode4 ((t (:background ,zenburn-bg+1))))

   ;; org-mode
   `(org-agenda-date-today
     ((t (:foreground "white" :slant italic :weight bold))) t)
   `(org-agenda-structure
     ((t (:inherit font-lock-comment-face))))
   `(org-archived ((t (:foreground ,zenburn-fg :weight bold))))
   `(org-checkbox ((t (:background ,zenburn-bg+2 :foreground "white"
                                   :box (:line-width 1 :style released-button)))))
   `(org-date ((t (:foreground ,zenburn-blue :underline t))))
   `(org-deadline-announce ((t (:foreground ,zenburn-red-1))))
   `(org-done ((t (:bold t :weight bold :foreground ,zenburn-green+3))))
   `(org-formula ((t (:foreground ,zenburn-yellow-2))))
   `(org-headline-done ((t (:foreground ,zenburn-green+3))))
   `(org-hide ((t (:foreground ,zenburn-bg-1))))
   `(org-level-1 ((t (:foreground ,zenburn-orange))))
   `(org-level-2 ((t (:foreground ,zenburn-green+1))))
   `(org-level-3 ((t (:foreground ,zenburn-blue-1))))
   `(org-level-4 ((t (:foreground ,zenburn-yellow-2))))
   `(org-level-5 ((t (:foreground ,zenburn-cyan))))
   `(org-level-6 ((t (:foreground ,zenburn-green-1))))
   `(org-level-7 ((t (:foreground ,zenburn-red-4))))
   `(org-level-8 ((t (:foreground ,zenburn-blue-4))))
   `(org-link ((t (:foreground ,zenburn-yellow-2 :underline t))))
   `(org-scheduled ((t (:foreground ,zenburn-green+4))))
   `(org-scheduled-previously ((t (:foreground ,zenburn-red-4))))
   `(org-scheduled-today ((t (:foreground ,zenburn-blue+1))))
   `(org-special-keyword ((t (:foreground ,zenburn-fg-1 :weight normal))))
   `(org-table ((t (:foreground ,zenburn-green+2))))
   `(org-tag ((t (:bold t :weight bold))))
   `(org-time-grid ((t (:foreground ,zenburn-orange))))
   `(org-todo ((t (:bold t :foreground ,zenburn-red :weight bold))))
   `(org-upcoming-deadline ((t (:inherit font-lock-keyword-face))))
   `(org-warning ((t (:bold t :foreground ,zenburn-red :weight bold :underline nil))))
   `(org-column ((t (:background ,zenburn-bg-1))))
   `(org-column-title ((t (:background ,zenburn-bg-1 :underline t :weight bold))))

   ;; outline
   `(outline-8 ((t (:inherit default))))
   `(outline-7 ((t (:inherit outline-8 :height 1.0))))
   `(outline-6 ((t (:inherit outline-7 :height 1.0))))
   `(outline-5 ((t (:inherit outline-6 :height 1.0))))
   `(outline-4 ((t (:inherit outline-5 :height 1.0))))
   `(outline-3 ((t (:inherit outline-4 :height 1.0))))
   `(outline-2 ((t (:inherit outline-3 :height 1.0))))
   `(outline-1 ((t (:inherit outline-2 :height 1.0))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,zenburn-fg))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,zenburn-green+2))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,zenburn-yellow-2))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,zenburn-cyan))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,zenburn-green-1))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,zenburn-blue+1))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,zenburn-yellow-1))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,zenburn-green+1))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,zenburn-blue-2))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground ,zenburn-orange))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground ,zenburn-green))))
   `( rainbow-delimiters-depth-12-face ((t (:foreground ,zenburn-blue-5))))

   ;; rpm-mode
   `(rpm-spec-dir-face ((t (:foreground ,zenburn-green))))
   `(rpm-spec-doc-face ((t (:foreground ,zenburn-green))))
   `(rpm-spec-ghost-face ((t (:foreground ,zenburn-red))))
   `(rpm-spec-macro-face ((t (:foreground ,zenburn-yellow))))
   `(rpm-spec-obsolete-tag-face ((t (:foreground ,zenburn-red))))
   `(rpm-spec-package-face ((t (:foreground ,zenburn-red))))
   `(rpm-spec-section-face ((t (:foreground ,zenburn-yellow))))
   `(rpm-spec-tag-face ((t (:foreground ,zenburn-blue))))
   `(rpm-spec-var-face ((t (:foreground ,zenburn-red))))

   ;; rst-mode
   `(rst-level-1-face ((t (:foreground ,zenburn-orange))))
   `(rst-level-2-face ((t (:foreground ,zenburn-green+1))))
   `(rst-level-3-face ((t (:foreground ,zenburn-blue-1))))
   `(rst-level-4-face ((t (:foreground ,zenburn-yellow-2))))
   `(rst-level-5-face ((t (:foreground ,zenburn-cyan))))
   `(rst-level-6-face ((t (:foreground ,zenburn-green-1))))

   ;; show-paren
   `(show-paren-mismatch ((t (:foreground ,zenburn-red-3 :background ,zenburn-bg :weight bold))))
   `(show-paren-match ((t (:foreground ,zenburn-blue-1 :background ,zenburn-bg :weight bold))))

   ;; sml-mode-line
   '(sml-modeline-end-face ((t :inherit default :width condensed)))

   ;; SLIME
   `(slime-repl-inputed-output-face ((t (:foreground ,zenburn-red))))

   ;; tabbar
   `(tabbar-button ((t (:foreground ,zenburn-fg
                                    :background ,zenburn-bg))))
   `(tabbar-selected ((t (:foreground ,zenburn-fg
                                      :background ,zenburn-bg
                                      :box (:line-width -1 :style pressed-button)))))
   `(tabbar-unselected ((t (:foreground ,zenburn-fg
                                        :background ,zenburn-bg+1
                                        :box (:line-width -1 :style released-button)))))

   ;; volatile-highlights
   `(vhl/default-face ((t (:background ,zenburn-bg+1))))

   ;; emacs-w3m
   `(w3m-anchor ((t (:foreground ,zenburn-yellow :underline t
                                 :weight bold))))
   `(w3m-arrived-anchor ((t (:foreground ,zenburn-yellow-2
                                         :underline t :weight normal))))
   `(w3m-form ((t (:foreground ,zenburn-red-1 :underline t))))
   `(w3m-header-line-location-title ((t (:foreground ,zenburn-yellow
                                                     :underline t :weight bold))))
   '(w3m-history-current-url ((t (:inherit match))))
   `(w3m-lnum ((t (:foreground ,zenburn-green+2 :background ,zenburn-bg))))
   `(w3m-lnum-match ((t (:background ,zenburn-bg-1
                                     :foreground ,zenburn-orange
                                     :weight bold))))
   `(w3m-lnum-minibuffer-prompt ((t (:foreground ,zenburn-yellow))))

   ;; whitespace-mode
   `(whitespace-space ((t (:background ,zenburn-bg :foreground ,zenburn-bg+1))))
   `(whitespace-hspace ((t (:background ,zenburn-bg :foreground ,zenburn-bg+1))))
   `(whitespace-tab ((t (:background ,zenburn-bg :foreground ,zenburn-red))))
   `(whitespace-newline ((t (:foreground ,zenburn-bg+1))))
   `(whitespace-trailing ((t (:foreground ,zenburn-red :background ,zenburn-bg))))
   `(whitespace-line ((t (:background ,zenburn-bg-05 :foreground ,zenburn-magenta))))
   `(whitespace-space-before-tab ((t (:background ,zenburn-orange :foreground ,zenburn-orange))))
   `(whitespace-indentation ((t (:background ,zenburn-yellow :foreground ,zenburn-red))))
   `(whitespace-empty ((t (:background ,zenburn-yellow :foreground ,zenburn-red))))
   `(whitespace-space-after-tab ((t (:background ,zenburn-yellow :foreground ,zenburn-red))))

   ;; wanderlust
   `(wl-highlight-folder-few-face ((t (:foreground ,zenburn-red-2))))
   `(wl-highlight-folder-many-face ((t (:foreground ,zenburn-red-1))))
   `(wl-highlight-folder-path-face ((t (:foreground ,zenburn-orange))))
   `(wl-highlight-folder-unread-face ((t (:foreground ,zenburn-blue))))
   `(wl-highlight-folder-zero-face ((t (:foreground ,zenburn-fg))))
   `(wl-highlight-folder-unknown-face ((t (:foreground ,zenburn-blue))))
   `(wl-highlight-message-citation-header ((t (:foreground ,zenburn-red-1))))
   `(wl-highlight-message-cited-text-1 ((t (:foreground ,zenburn-red))))
   `(wl-highlight-message-cited-text-2 ((t (:foreground ,zenburn-green+2))))
   `(wl-highlight-message-cited-text-3 ((t (:foreground ,zenburn-blue))))
   `(wl-highlight-message-cited-text-4 ((t (:foreground ,zenburn-blue+1))))
   `(wl-highlight-message-header-contents-face ((t (:foreground ,zenburn-green))))
   `(wl-highlight-message-headers-face ((t (:foreground ,zenburn-red+1))))
   `(wl-highlight-message-important-header-contents ((t (:foreground ,zenburn-green+2))))
   `(wl-highlight-message-header-contents ((t (:foreground ,zenburn-green+1))))
   `(wl-highlight-message-important-header-contents2 ((t (:foreground ,zenburn-green+2))))
   `(wl-highlight-message-signature ((t (:foreground ,zenburn-green))))
   `(wl-highlight-message-unimportant-header-contents ((t (:foreground ,zenburn-fg))))
   `(wl-highlight-summary-answered-face ((t (:foreground ,zenburn-blue))))
   `(wl-highlight-summary-disposed-face ((t (:foreground ,zenburn-fg
                                                         :slant italic))))
   `(wl-highlight-summary-new-face ((t (:foreground ,zenburn-blue))))
   `(wl-highlight-summary-normal-face ((t (:foreground ,zenburn-fg))))
   `(wl-highlight-summary-thread-top-face ((t (:foreground ,zenburn-yellow))))
   `(wl-highlight-thread-indent-face ((t (:foreground ,zenburn-magenta))))
   `(wl-highlight-summary-refiled-face ((t (:foreground ,zenburn-fg))))
   `(wl-highlight-summary-displaying-face ((t (:underline t :weight bold))))

   ;; which-func-mode
   `(which-func ((t (:foreground ,zenburn-green+4))))

   ;; yascroll
   `(yascroll:thumb-text-area ((t (:background ,zenburn-bg-1))))
   `(yascroll:thumb-fringe ((t (:background ,zenburn-bg-1 :foreground ,zenburn-bg-1))))
   )

  ;;; custom theme variables
  (custom-theme-set-variables
   'zenburn
   `(ansi-color-names-vector [,zenburn-bg ,zenburn-red ,zenburn-green ,zenburn-yellow
                                          ,zenburn-blue ,zenburn-magenta ,zenburn-cyan ,zenburn-fg])

   ;; fill-column-indicator
   `(fci-rule-color ,zenburn-bg-05))

  ;;; colors for the ansi-term
  (eval-after-load 'term
    `(setq ansi-term-color-vector
           (vector 'unspecified ,zenburn-bg ,zenburn-red ,zenburn-green ,zenburn-yellow
                   ,zenburn-blue ,zenburn-magenta ,zenburn-cyan ,zenburn-fg))))

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'zenburn)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; eval: (when (fboundp 'rainbow-mode) (rainbow-mode +1))
;; End:

;;; zenburn-theme.el ends here.
