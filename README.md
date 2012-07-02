# About

Zenburn for Emacs is a direct port of the popular
[Zenburn](http://slinky.imukuppi.org/zenburnpage/) theme for vim,
developed by Jani Nurminen. It's my personal belief (and
that of its many users I presume) that it's one of the best low
contrast color themes out there and that it's is exceptionally easy on
the eyes. 

The theme has two versions - one for Emacs 24 using it's new built-in
theming support, which you can find in this branch.  A version for
Emacs 23 exist in the emacs23 branch.

# Installation

## Manual

Download `zenburn-theme.el` to the directory `~/.emacs.d/themes/`. Add this to your
`.emacs`:

`(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")`

Now you can load the theme with the interactive function `load-theme` like this:

`M-x load-theme RET zenburn`

## Package.el

Zenburn is available in both [Marmalade](http://marmalade-repo.org) and [MELPA](http://melpa.milkbox.net).
You can install with the following command:

`M-x package-install zenburn-theme`

To load it automatically on Emacs startup add this to your init file:

```elisp
(load-theme 'zenburn t)
```

## Emacs Prelude

Zenburn for Emacs is already bundled into
[Emacs Prelude](https://github.com/bbatsov/prelude). If you're a
Prelude user - you're probably already using Zenburn, since it's
Prelude's default color theme. You can load Zenburn at any time by
`M-x load-theme zenburn`.

# Bugs & Improvements

Please, report any problems that you find on the projects integrated
issue tracker. If you've added some improvements and you want them
included upstream don't hesitate to send me a patch or even better - a
GitHub pull request.  [These](https://github.com/bbatsov/zenburn-emacs/contributors)
contributors have done so.

Cheers,</br>
Bozhidar
