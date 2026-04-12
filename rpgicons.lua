-- File: rpgicons.lua
-- Copyright 2024-2026 Jasper Habicht (mail(at)jasperhabicht.de).
--
-- This work may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License version 1.3c,
-- available at http://www.latex-project.org/lppl/.
--
-- This file is part of the `rpgicons' package (The Work in LPPL)
-- and all files in that bundle must be distributed together.
--
-- This work has the LPPL maintenance status `maintained'.
--

-- v2.7.2 2026-04-10

rpgicons = rpgicons or {}

local pairs             = pairs
local pdfe_open         = pdfe.open
local pdfe_pagestotable = pdfe.pagestotable
local pdfe_arraytotable = pdfe.arraytotable
local math_mod          = math.mod
local img_write         = img.write

--- Stores the objnums of all pages of a PDF with the relevant page numbers.
-- The objnums are stored as keys of the table.
-- The page numbers are stored as values to the relevant keys.
local pages = {}

--- Stores the named dests in a PDF with the relevant page numbers.
-- The named dests are stored as keys of the table.
-- The page numbers are stored as values to the relevant keys.
local dests = {}

--- Retrieves the page numbers of all named dests in a PDF.
-- Stores the objnums of all pages of the PDF file in table `pages`.
-- For each named dest, gets the objnum of the referenced page
-- and stores the relevant page number in table `dests`.
-- @param file string The PDF file to be processed.
-- @return nil - -
function rpgicons.get_dest_pages(file)
    local _file = pdfe_open(file)
    for i, o in pairs(pdfe_pagestotable(_file)) do
        -- The third item of the array obtained by pdfe.arraytotable
        -- contains the objnum.
        pages[o[3]] = i
    end

    local _dest_name = ''
    local _dest_names = _file.Catalog.Names.Dests.Names
    for i, o in pairs(pdfe_arraytotable(_dest_names)) do
        -- The PDF item /Dests/Names contains pairs
        -- consisting of dest name and object reference.
        if (math_mod(i, 2) ~= 0) then
            _dest_name = _dest_names[i]
        else
            -- The PDF item /D contains a single pair
            -- consisting of object reference and fit parameter.
            -- The third item of the array obtained by pdfe.arraytotable
            -- contains the objnum.
            dests[_dest_name] =
                pages[pdfe_arraytotable(_dest_names[i].D)[1][3]]
        end
    end
end

--- Retrieves the PDF page including the icon via the relevant named dest.
-- Finds the page number to the relevant named dest via table `dests`.
-- Outputs a TeX node containing the PDF page as included graphic.
-- @param dest string The named dest.
-- @param file string The PDF file.
-- @return luatex.node PDF page as TeX node.
function rpgicons.load_icon(dest, file)
    return img_write({page = dests[dest], filename = file})
end

return rpgicons

-- EOF