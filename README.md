# About #

Zenburn for Emacs is a direct port of the popular
[Zenburn](http://slinky.imukuppi.org/zenburnpage/ Zenburn) theme for vim,
developed by Jani Nurminen. It's my personal belief (and
that of its many users I presume) that it's one of the best low
contrast color themes out there and that it's is exceptionally easy on
the eyes.

# Installation #

Zenburn depends on the color-theme package, so you should have it
installed. In zenburn's repo you'll find a stripped down version of
color-theme (without the built-in themes) suitable for use with
zenburn. Finally put this in your .emacs(or init.el):

`(require 'color-theme-zenburn)`

`(color-theme-zenburn)`

Zenburn for Emacs is also available for installation via the
[Marmalade](http://marmalade-repo.org/) package repository. Follow the
installation instructions there to install **package.el** and
afterwards you can install the zenburn theme like this:

`M-x package-install color-theme-zenburn`

# Bugs & Improvements #

Please, report any problems that you find on the projects integrated
issue tracker. If you've added some improvements and you want them
included upstream don't hesitate to send me a patch or even better - a
GitHub pull request.

# Contributors

So far - none. You could be the first. :-)
