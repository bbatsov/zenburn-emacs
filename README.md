## About

Zenburn for Emacs is a direct port of the popular
[Zenburn](http://slinky.imukuppi.org/zenburnpage/) theme for vim,
developed by Jani Nurminen. It's my personal belief (and
that of its many users I presume) that it's one of the best low
contrast color themes out there and that it's is exceptionally easy on
the eyes.

This theme uses the new built-in theming support available starting
with Emacs 24.

## Installation

### Manual

Download `zenburn-theme.el` to the directory `~/.emacs.d/themes/`. Add this to your
`.emacs`:

```lisp
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
```

Now you can load the theme with the interactive function `load-theme` like this:

`M-x load-theme RET zenburn`

### Package.el

Zenburn is available in both [Marmalade](http://marmalade-repo.org)
and [MELPA](http://melpa.milkbox.net).
Keep in mind the fact the version in the Marmalade repo may not always
be up-to-date.

You can install `zenburn` with the following command:

`M-x package-install zenburn-theme`

To load it automatically on Emacs startup add this to your init file:

```lisp
(load-theme 'zenburn t)
```

### Emacs Prelude

Zenburn for Emacs is already bundled into
[Emacs Prelude](https://github.com/bbatsov/prelude). If you're a
Prelude user - you're probably already using Zenburn, since it's
Prelude's default color theme. You can load Zenburn at any time by
`M-x load-theme zenburn`.

## Ugly colors in the terminal Emacs version

If your Emacs looks considerably uglier in a terminal (compared to the
GUI version) try adding this to your `.bashrc` or `.zshrc`:

```bash
export TERM=xterm-256color
```

Source the `.bashrc`(`.zshrc`) file and start Emacs again.

# Bugs & Improvements

Please, report any problems that you find on the projects integrated
issue tracker. If you've added some improvements and you want them
included upstream don't hesitate to send me a patch or even better - a
GitHub pull request. [These](https://github.com/bbatsov/zenburn-emacs/contributors)
contributors have done so.

Cheers,<br\>
Bozhidar
