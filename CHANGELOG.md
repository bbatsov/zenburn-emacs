# Changelog

## master (unreleased)

## 2.7 (2020-11-21)

### New features

* [#347](https://github.com/bbatsov/zenburn-emacs/issues/347): Add support for `highlight-symbol` and `highlight-thing`.
* Add `helm-lxc` support.
* Theme `swiper-line-face` and `swiper-isearch-current-match`.
* [#330](https://github.com/bbatsov/zenburn-emacs/pull/330): Add centaur-tabs, doom-modeline, and solaire-mode support.
* Add `notmuch` support

### Changes

* [#346](https://github.com/bbatsov/zenburn-emacs/pull/346): Make numbers in `highlight-numbers` blue.
* Make `zenburn-add-font-lock-keywords` customizable.

### Bugs fixed

* [#321](https://github.com/bbatsov/zenburn-emacs/issues/321): Scale `org-document-title` only if `zenburn-scale-org-headlines` is `t`.
* Fix lots of face inheritance issues on Emacs 27.

## 2.6 (2018-10-14)

### New features

* Port scaled headings and variable pitch features from solarized
* Add parenthesis colour for paren-face
* Support for line-numbers-mode (#311)
* Add faces for org-ref (#312)
* Add support for markup-faces (covers adoc-mode) (#310)
* Add diredfl support
* Add some initial cperl custom faces
* Add hackernews support
* Add `go-guru` support
* Add sx support
* Add git-annex support
* Add eww certificate support
* Add missing ivy face ivy-cursor
* Add faces for merlin-mode
* Add hi-lock support
* Add cider-fringe-good-face
* Add realgud settings
* Customize company-quickhelp colors

### Changes

* Use `diff-refine-changed` face name
* Modify diff colors
* Add more colors to palette
* Rename `zenburn-green-1` to `zenburn-green-2`
* Make `zenburn-override-colors-alist` a customizable variable
* Add zenburn red/green for magit diff remove/add blocks
* Add more magit-signature-* faces
* Update hackernews face names
* Update git-commit faces
* Set the foreground color for "font-latex-script-char-face" to "zenburn-orange" (#292)

### Bugs fixed

* Fix widget-field face on 24bit color text terminals
* Try boxed attribute on enable/disable bp face
* Fix background in Gnus (#271)
