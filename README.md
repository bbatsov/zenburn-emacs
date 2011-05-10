# About #

Zenburn for Emacs is a direct port of the popular
[Zenburn](http://slinky.imukuppi.org/zenburnpage/ Zenburn) theme for vim,
developed originally by Jani Nurminen. It's my personal belief(and
that of many of its users I presume) that it's one of the best low
contrast themes out there and that Zenburn is exceptionally easy on
the eyes.

The project was originally ported to Emacs by Daniel Brockman, but it
seems that he has lost interest in it recently. This is the reason why
I gathered here all improvements over the last official Zenburn
version and started this fork of the project. It's my hope that it
will be become a central place for zenburn development.  

Daniel's version of Zenburn had reached a state in which it took me
too much to make improvements to it so I started work on clean new
version of the theme with a simpler design and code base. It's in very
early stage of development and it doesn't currently include all the
faces from the old version, but this will quickly change (hopefully).

# Installation #

Zenburn depends on the color-theme package, so you should have it
installed. After that just put this in your .emacs(or equivalent):

`(require 'zenburn)`

if you want to use the new Zenburn or 

`(require 'zenburn-legacy)

if you wish to use the legacy version. 

`(zenburn)`

# Bugs & Improvements #

Please, report any problems that you find on the projects integrated
issue tracker. If you've added some improvements and you want them
included upstream don't hesitate to send me a patch or even better - a
GitHub pull request.

# Contributors
  * Ranko Radonić
  * Dr. Mark A. Friedman
