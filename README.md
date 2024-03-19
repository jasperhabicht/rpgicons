![Version 1.7.0](https://img.shields.io/badge/version-1.7.0-blue)

<img width="200" alt="dndicons-example" src="https://github.com/jasperhabicht/dndicons/assets/6378801/81a1d0aa-7a4f-4f83-bbdc-3bc3332023b2" /> 

# The `dndicons` package

This package provides a set of high-quality icons for use in notes for tabletop role-playing games. 
The icons are meant to be used in the body text, but they can also be used in other contexts such 
as graphics or diagrams.

The basic `dndicons` package provides the icons as Ti*k*Z shapes. Since the commands to typeset the 
icons use `tikzpicture` environments, these commands should not be used inside another 
`tikzpicture`. However, because the package defines the icons as Ti*k*Z shapes, it is possible to 
use the icons in `tikzpicture` environments directly. Apart from that, as of version 1.1.0, the 
package provides a way to define custom commands to typeset the icons as boxed material which is 
safe to use in a tikzpicture context. As of version 1.3.1, the package provides an additional way 
to use the icons as Ti*k*Z pics. 

As of version 1.4.0, the `dndicons-l3` package, a variant of the basic package, provides an 
alternative way to typeset the icons using the `l3draw` package. 

The `dndicons` package is installed by copying the relevant `.sty` file into the working or `texmf`
directory. The package is loaded by calling `\usepackage{dndicons}` (or 
`\usepackage{dndicons-l3}` for the `l3draw` package variant) in the preamble of the document.

This package including all files is subject to the LPPL 1.3c license.
