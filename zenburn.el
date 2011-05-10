;;; zenburn.el --- A low contrast colour theme for Emacs

;; Copyright (C) 2011 Bozhidar Batsov

;; Author: Bozhidar Batsov <bozhidar.batsov [at] gmail.com>
;; Keywords: convenience, emulations
;; X-URL: http://github.com/bbatsov/zenburn-emacs
;; URL: http://github.com/bbatsov/zenburn-emacs
;; EmacsWiki: ColorThemeZenburn
;; Version: 1.0
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
     ;; color-theme mapping
     ((foreground-color . ,zenburn-fg)
      (background-color . ,zenburn-bg)
      (background-mode . dark)
      (cursor-color . ,zenburn-fg))

     ;; basic colouring
     (default ((t (:foreground ,zenburn-fg))))
     (cursor
      ((t (:foreground ,zenburn-fg))))
     (escape-glyph-face ((t (:foreground ,zenburn-red))))
     (fringe ((t (:foreground ,zenburn-fg :background ,zenburn-bg))))
     (header-line ((t (:foreground ,zenburn-fg :background ,zenburn-bg))))
     (highlight ((t (:background ,zenburn-bg-1))))
     (isearch ((t (:foreground ,zenburn-yellow))))
     (menu ((t (:foreground ,zenburn-fg :background ,zenburn-bg))))
     (minibuffer-prompt ((t (:foreground ,zenburn-yellow))))
     (mode-line
      ((t (:foreground ,zenburn-fg :background ,zenburn-bg-1))))
     (mode-line-buffer-id ((t (:foreground ,zenburn-fg))))
     (mode-line-inactive
      ((t (:foreground ,zenburn-fg  :background ,zenburn-bg-1))))
     (region ((t (:background ,zenburn-bg-1))))
     (secondary-selection ((t (:background ,zenburn-bg-1))))
     (trailing-whitespace ((t (:foreground ,zenburn-red))))
     (vertical-border ((t (:foreground ,zenburn-fg))))

     ;; diff
     (diff-added ((t (:foreground ,zenburn-green))))
     (diff-changed ((t (:foreground ,zenburn-yellow))))
     (diff-removed ((t (:foreground ,zenburn-red))))
     (diff-header ((t (:background ,zenburn-bg))))
     (diff-file-header
      ((t (:background ,zenburn-bg :foreground ,zenburn-fg :bold t))))

     ;; font lock
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

     ;; hl-line-mode
     (hl-line-face ((t (:background ,zenburn-bg-1))))
     )))

(defalias 'zenburn #'color-theme-zenburn)

(add-to-list 'color-themes '(color-theme-zenburn
                             "Zenburn"
                             "Bozhidar Batsov <bozhidar.batsov@gmail.com"))

(provide 'zenburn)

;; Local Variables:
;; time-stamp-format: "%:y-%02m-%02d %02H:%02M"
;; time-stamp-start: "Updated: "
;; time-stamp-end: "$"
;; End:

;;; zenburn.el ends here.
