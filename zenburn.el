;;; zenburn.el --- A low contrast colour theme for Emacs

;; Copyright (C) 2011 Bozhidar Batsov

;; Author: Bozhidar Batsov <bozhidar.batsov [at] gmail.com>
;; Keywords: color, theme, zenburn
;; X-URL: http://github.com/bbatsov/zenburn-emacs
;; URL: http://github.com/bbatsov/zenburn-emacs
;; EmacsWiki: ColorThemeZenburn
;; Version: 0.1
;; Revision: $Rev$ ($LastChangedDate$)

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
;; theme by Daniel Brockman. Mine version was originally based on it,
;; but it was in such a disarray that I decided to rewrite it from
;; scratch in a more maintainable manner (hopefully).
;;
;;; Installation:
;;
;;   (require 'zenburn)
;;   (zenburn)
;;
;; Don't forget that the theme requires the presence of the
;; color-theme package in your Emacs load-path.
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

;; colour definitions
;; colours with +x are lighter, colours with -x are darker
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

     ;;; basic colouring
     (default ((t (:foreground ,zenburn-fg))))
     (cursor
      ((t (:foreground ,zenburn-fg))))
     (escape-glyph-face ((t (:foreground ,zenburn-red))))
     (fringe ((t (:foreground ,zenburn-fg :background ,zenburn-bg))))
     (header-line ((t (:foreground ,zenburn-fg :background ,zenburn-bg))))
     (highlight ((t (:background ,zenburn-bg+1))))
     (isearch ((t (:foreground ,zenburn-yellow))))
     (menu ((t (:foreground ,zenburn-fg :background ,zenburn-bg))))
     (minibuffer-prompt ((t (:foreground ,zenburn-yellow))))
     (header-line ((t (:background ,zenburn-bg-1
                                :box (:color ,zenburn-bg+2 :line-width 2)))))
     (mode-line
      ((t (:foreground ,zenburn-green+1 :background ,zenburn-bg-1))))
     (mode-line-buffer-id ((t (:foreground ,zenburn-yellow :weight bold))))
     (mode-line-inactive
      ((t (:foreground ,zenburn-green-1  :background ,zenburn-bg-1))))
     (region ((t (:background ,zenburn-bg-1))))
     (secondary-selection ((t (:background ,zenburn-bg+2))))
     (trailing-whitespace ((t (:foreground ,zenburn-red))))
     (vertical-border ((t (:foreground ,zenburn-fg))))

     ;;; font lock
     (font-lock-builtin-face ((t (:foreground ,zenburn-blue))))
     (font-lock-comment-face ((t (:foreground ,zenburn-green))))
     (font-lock-comment-delimiter-face ((t (:foreground ,zenburn-green))))
     (font-lock-constant-face ((t (:foreground ,zenburn-fg))))
     (font-lock-doc-face ((t (:foreground ,zenburn-green+1))))
     (font-lock-doc-string-face ((t (:foreground ,zenburn-blue+1))))
     (font-lock-function-name-face ((t (:foreground ,zenburn-blue))))
     (font-lock-keyword-face ((t (:foreground ,zenburn-yellow :weight bold))))
     (font-lock-negation-char-face ((t (:foreground ,zenburn-fg))))
     (font-lock-preprocessor-face ((t (:foreground ,zenburn-blue))))
     (font-lock-string-face ((t (:foreground ,zenburn-red))))
     (font-lock-type-face ((t (:foreground ,zenburn-yellow))))
     (font-lock-variable-name-face ((t (:foreground ,zenburn-yellow))))
     (font-lock-warning-face ((t (:foreground ,zenburn-red))))

     ;;; external

     ;; diff
     (diff-added ((t (:foreground ,zenburn-green))))
     (diff-changed ((t (:foreground ,zenburn-yellow))))
     (diff-removed ((t (:foreground ,zenburn-red))))
     (diff-header ((t (:background ,zenburn-bg+1))))
     (diff-file-header
      ((t (:background ,zenburn-bg+2 :foreground ,zenburn-fg :bold t))))

     ;; eshell
     (eshell-prompt ((t (:foreground ,zenburn-yellow :weight bold))))
     (eshell-ls-archive ((t (:foreground ,zenburn-red-1 :weight bold))))
     (eshell-ls-backup ((t (:inherit font-lock-comment))))
     (eshell-ls-clutter ((t (:inherit font-lock-comment))))
     (eshell-ls-directory ((t (:foreground ,zenburn-blue+1 :weight bold))))
     (eshell-ls-executable ((t (:foreground ,zenburn-red+1 :weight bold))))
     (eshell-ls-unreadable ((t (:foreground ,zenburn-fg))))
     (eshell-ls-missing ((t (:inherit font-lock-warning))))
     (eshell-ls-product ((t (:inherit font-lock-doc))))
     (eshell-ls-special ((t (:foreground ,zenburn-yellow :weight bold))))
     (eshell-ls-symlink ((t (:foreground ,zenburn-cyan :weight bold))))

     ;; flymake
     (flymake-errline ((t (:underline t :foreground ,zenburn-red-1))))
     (flymake-warnline ((t (:underline t :foreground ,zenburn-yellow))))

     ;; flyspell
     (flyspell-duplicate ((t (:foreground ,zenburn-yellow :underline t))))
     (flyspell-incorrect ((t (:foreground ,zenburn-red-1 :underline t))))

     ;; erc
     (erc-action-face ((t (:inherit erc-default))))
     (erc-bold-face ((t (:weight bold))))
     (erc-current-nick-face ((t (:foreground ,zenburn-yellow :weight bold))))
     (erc-dangerous-host-face ((t (:inherit font-lock-warning))))
     (erc-default-face ((t (:foreground ,zenburn-fg))))
     (erc-direct-msg-face ((t (:inherit erc-default))))
     (erc-error-face ((t (:inherit font-lock-warning))))
     (erc-fool-face ((t (:inherit erc-default))))
     (erc-highlight-face ((t (:inherit hover-highlight))))
     (erc-input-face ((t (:foreground ,zenburn-yellow))))
     (erc-keyword-face ((t (:foreground ,zenburn-yellow :weight bold))))
     (erc-nick-default-face ((t (:weigth bold))))
     (erc-nick-msg-face ((t (:inherit erc-default))))
     (erc-notice-face ((t (:foreground ,zenburn-green))))
     (erc-pal-face ((t (:foreground ,zenburn-orange :weight bold))))
     (erc-prompt-face ((t (:foreground ,zenburn-orange :weight bold))))
     (erc-timestamp-face ((t (:foreground ,zenburn-green+1))))
     (erc-underline-face ((t (:underline t))))

     ;; hl-line-mode
     (hl-line-face ((t (:background ,zenburn-bg-1))))
     
     ;; ido-mode
     (ido-first-match ((t (:foreground ,zenburn-yellow :weight bold))))
     (ido-only-match ((t (:foreground ,zenburn-orange :weight bold))))
     (ido-subdir ((t (:foreground ,zenburn-yellow))))

     ;; magit
     (magit-section-title ((t (:foreground ,zenburn-yellow :weight bold))))
     (magit-branch ((t (:foreground ,zenburn-orange :weight bold))))

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
     (org-agenda-date-today-face
      ((t (:foreground "white" :slant italic :weight bold))) t)
     (org-agenda-structure-face
      ((t (:inherit font-lock-comment-face))))
     (org-archived-face ((t (:foreground ,zenburn-fg :weight bold))))
     (org-checkbox-face ((t (:background ,zenburn-bg+2 :foreground "white"
                                         :box (:line-width 1 :style released-button)))))
     (org-date-face ((t (:foreground ,zenburn-blue :underline t))))
     (org-deadline-announce-face ((t (:foreground ,zenburn-red-1))))
     (org-done-face ((t (:bold t :weight bold :foreground ,zenburn-green+3))))
     (org-formula-face ((t (:foreground ,zenburn-yellow-2))))
     (org-headline-done-face ((t (:foreground ,zenburn-green+3))))
     (org-hide-face ((t (:foreground ,zenburn-bg-1))))
     (org-level-1-face ((t (:foreground ,zenburn-orange))))
     (org-level-2-face ((t (:foreground ,zenburn-yellow))))
     (org-level-3-face ((t (:foreground ,zenburn-blue))))
     (org-level-4-face  ((t (:foreground ,zenburn-cyan))))
     (org-level-5-face  ((t (:foreground ,zenburn-blue-1))))
     (org-level-6-face  ((t (:foreground ,zenburn-blue-2))))
     (org-level-7-face  ((t (:foreground ,zenburn-blue-3))))
     (org-level-8-face ((t (:foreground ,zenburn-blue-4))))
     (org-link-face ((t (:foreground ,zenburn-yellow-2 :underline t))))
     (org-scheduled-face ((t (:foreground ,zenburn-green+4))))
     (org-scheduled-previously-face ((t (:foreground ,zenburn-red-4))))
     (org-scheduled-today-face ((t (:foreground ,zenburn-blue+1))))
     (org-special-keyword-face ((t (:foreground ,zenburn-yellow-1))))
     (org-table-face ((t (:foreground ,zenburn-green+2))))
     (org-tag-face ((t (:bold t :weight bold))))
     (org-time-grid-face ((t (:foreground ,zenburn-orange))))
     (org-todo-face ((t (:bold t :foreground ,zenburn-red :weight bold))))
     (org-upcoming-deadline-face ((t (:inherit font-lock-keyword-face))))
     (org-warning-face ((t (:bold t :foreground ,zenburn-red :weight bold))))

     ;; outline
     (outline-8-face ((t (:inherit default))))
     (outline-7-face ((t (:inherit outline-8 :height 1.0))))
     (outline-6-face ((t (:inherit outline-7 :height 1.0))))
     (outline-5-face ((t (:inherit outline-6 :height 1.0))))
     (outline-4-face ((t (:inherit outline-5 :height 1.0))))
     (outline-3-face ((t (:inherit outline-4 :height 1.0))))
     (outline-2-face ((t (:inherit outline-3 :height 1.0))))
     (outline-1-face ((t (:inherit outline-2 :height 1.0))))

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

     ;; show-paren
     (show-paren-mismatch ((t (:inherit font-lock-warning))))
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
     (wl-highlight-summary-thread-top-face ((t (:foreground "#efdcbc"))))
     (wl-highlight-thread-indent-face ((t (:foreground "#ecbcec"))))
     (wl-highlight-summary-refiled-face ((t (:foreground ,zenburn-fg))))
     (wl-highlight-summary-displaying-face ((t (:underline t :weight bold))))

     )))

(defalias 'zenburn #'color-theme-zenburn)

(add-to-list 'color-themes '(color-theme-zenburn
                             "Zenburn"
                             "Bozhidar Batsov <bozhidar.batsov@gmail.com"))

(provide 'zenburn)

;;; zenburn.el ends here.
