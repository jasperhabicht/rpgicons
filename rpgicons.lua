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

local open         = pdfe.open
local pagestotable = pdfe.pagestotable
local arraytotable = pdfe.arraytotable
local mod          = math.mod
local img_write    = img.write

--- Stores the objnums of all pages of a PDF with the relevant page numbers.
-- The objnums are stored as keys of the table.
-- The page numbers are stored as values to the relevant keys. 
local _pages = {}

--- Stores the named dests in a PDF with the relevant page numbers.
-- The named dests are stored as keys of the table.
-- The page numbers are stored as values to the relevant keys. 
local _dests = {}

--- Retrieves the page numbers of all named dests in a PDF.
-- Stores the objnums of all pages of the PDF file in rpgicons_pages (table). 
-- For each named dest, gets the objnum of the referenced page
-- and stores the relevant page number in rpgicons_dests (table).
-- @param file The PDF file to be processed.
function get_dest_pages(file)
    local _file = open(file)
    for i, o in pairs(pagestotable(_file)) do
        -- The third item of the array obtained by pdfe.arraytotable
        -- contains the objnum.
        _pages[o[3]] = i
    end

    local _dest_current = ''
    local _dest_names = _file.Catalog.Names.Dests.Names
    for i, o in pairs(arraytotable(_dest_names)) do
        -- The PDF item /Dests/Names contains pairs
        -- consisting of dest name and object reference.
        if (mod(i, 2) ~= 0) then
            _dest_current = _dest_names[i]
        else
            -- The PDF item /D contains a single pair
            -- consisting of object reference and fit parameter.
            -- The third item of the array obtained by pdfe.arraytotable
            -- contains the objnum.
            _dests[_dest_current] =
                _pages[
                    arraytotable(_dest_names[i].D)[1][3]
                ]
        end
    end
end

--- Retrieves the PDF page including the icon via the relevant named dest.
-- Finds the page number to the relevant named dest via rpgicons_dests (table).
-- Outputs a TeX node containing the PDF page as included graphic.
-- @param dest The named dest.
-- @param file The PDF file.
-- @return PDF page as TeX node.
function load_icon(dest, file)
    return img_write({page = _dests[dest], filename = file})
end

rpgicons = {
    get_dest_pages = get_dest_pages,
    load_icon      = load_icon
}

return rpgicons

-- EOF