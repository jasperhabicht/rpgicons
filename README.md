![Version 1.8.2](https://img.shields.io/badge/version-1.8.2-blue)

<img width="200" alt="dndicons-example" src="https://github.com/jasperhabicht/dndicons/assets/6378801/81a1d0aa-7a4f-4f83-bbdc-3bc3332023b2" /> 

# The `dndicons` package

This package provides a set of high-quality icons for use in notes for tabletop role-playing games. 
The icons are meant to be used in the body text, but they can also be used in other contexts such 
as graphics or diagrams. The package comes in two variants, one based on the `l3draw` package and one
based on PGF/Ti*k*Z.

As of version 1.4.0, an `l3draw` variant of the `dndicons` package exists which is loaded by default.
The `l3draw` package does not provide the same variety of styles as Ti*k*Z does. 

The PGF veriant of the `dndicons` package provides the icons as Ti*k*Z shapes. Since the commands to 
typeset the icons use `tikzpicture` environments, these commands should not be used inside another 
`tikzpicture`. However, because the package defines the icons as Ti*k*Z shapes, it is possible to 
use the icons in `tikzpicture` environments directly. Apart from that, as of version 1.1.0, the 
package provides a way to define custom commands to typeset the icons as boxed material which is 
safe to use in a tikzpicture context. As of version 1.3.1, the package provides an additional way 
to use the icons as Ti*k*Z pics. 

The `dndicons` package is installed by copying the relevant `.sty` file into the working or `texmf`
directory. The package is loaded by calling `\usepackage{dndicons}` in the preamble of the document. 
To load the PGF variant, the package can be loaded with the option `pgf`. The `l3draw` variant is 
loaded per default. The PGF or `l3draw` variants can be loaded directly via 
`\usepackage{dndicons-pgf}` or`\usepackage{dndicons-l3}`.

This package including all files is subject to the LPPL 1.3c license.
Copyright 2024 Jasper Habicht (mail(at)jasperhabicht.de).
