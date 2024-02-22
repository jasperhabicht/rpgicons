![Version 1.4.3](https://img.shields.io/badge/version-1.4.3-blue)

# The `dndicons` package

The `dndicons` package provides a set of high quality icons made with Ti*k*Z for use in notes for
tabletop role-playing games. The icons are meant to be used in the body text, but they can also be
used in other contexts such as graphics or diagrams.

Since the commands to typeset the icons use `tikzpicture` environments, these commands should 
not be used inside another `tikzpicture`. However, because the package defines the icons as Ti*k*Z 
shapes, it is possible to use the icons in `tikzpicture` environments directly. Apart from that, as 
of version 1.1.0, the package provides a way to define custom commands to typeset the icons as 
boxed material which is safe to use in a tikzpicture context. As of version 1.3.1, the package 
provides an additional way to use the icons as Ti*k*Z pics. As of version 1.4.0, a variant of the 
package provides an alternative way to typeset the icons using the `l3draw` package.

The `dndicons` package is loaded by calling `\usepackage{dndicons}` (or 
`\usepackage{dndicons-l3draw}` for the `l3draw` packagee variant) in the preamble of the document.
