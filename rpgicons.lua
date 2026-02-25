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

--- Stores the objnums of all pages of a PDF with the relevant page numbers.
-- The objnums are stored as keys of the table.
-- The page numbers are stored as values to the relevant keys. 
local rpgicons_pages = {}

--- Stores the named dests in a PDF with the relevant page numbers.
-- The named dests are stored as keys of the table.
-- The page numbers are stored as values to the relevant keys. 
local rpgicons_dests = {}

--- Retrieves the page numbers of all named dests in a PDF.
-- Stores the objnums of all pages of the PDF file in rpgicons_pages (table). 
-- For each named dest, gets the objnum of the referenced page
-- and stores the relevant page number in rpgicons_dests (table).
-- @param file The PDF file to be processed.
-- @return Boolean true
function rpgicons_get_dest_pages(file)
    local rpgicons_file = pdfe.open(file)
    for i, o in pairs(pdfe.pagestotable(rpgicons_file)) do
        -- The third item of the array obtained by pdfe.arraytotable
        -- contains the objnum.
        rpgicons_pages[o[3]] = i
    end

    local rpgicons_dest_current = ''
    local rpgicons_dest_names = rpgicons_file.Catalog.Names.Dests.Names
    for i, o in pairs(pdfe.arraytotable(rpgicons_dest_names)) do
        -- The PDF item /Dests/Names contains pairs
        -- consisting of dest name and object reference.
        if (math.mod(i, 2) ~= 0) then
            rpgicons_dest_current = rpgicons_dest_names[i]
        else
            -- The PDF item /D contains a single pair
            -- consisting of object reference and fit parameter.
            -- The third item of the array obtained by pdfe.arraytotable
            -- contains the objnum.
            rpgicons_dests[rpgicons_dest_current] =
                rpgicons_pages[
                    pdfe.arraytotable(rpgicons_dest_names[i].D)[1][3]
                ]
        end
    end
    return true
end

--- Retrieves the PDF page including the icon via the relevant named dest.
-- Finds the page number to the relevant named dest via rpgicons_dests (table).
-- Outputs a TeX node containing the PDF page as included graphic.
-- @param file The PDF file to be processed.
-- @return TeX node
function rpgicons_load_icon(dest, file)
    return img.write({page = rpgicons_dests[dest], filename = file})
end

-- EOF