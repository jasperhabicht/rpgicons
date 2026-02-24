-- File: rpgicons.lua
-- Copyright 2024-2026 Jasper Habicht (mail(at)jasperhabicht.de).
--
-- This work may be distributed and/or modified under the
-- conditions of the LaTeX Project Public License version 1.3c,
-- available at http://www.latex-project.org/lppl/.
--
-- This file is part of the `rpgicons'  package (The Work in LPPL)
-- and all files in that bundle must be distributed together.
--
-- This work has the LPPL maintenance status `maintained'.
--

-- rpgicons_pages = { objnum = page }
local rpgicons_pages = {}

-- rpgicons_dests = { dest = page }
local rpgicons_dests = {}

function rpgicons_get_dest_pages(file)
    local rpgicons_file = pdfe.open(file)
    for i, o in pairs(pdfe.pagestotable(rpgicons_file)) do
        -- third item of array contains objnum
        rpgicons_pages[o[3]] = i
    end

    local rpgicons_dest_current = ''
    local rpgicons_dest_names = rpgicons_file.Catalog.Names.Dests.Names
    for i, o in pairs(pdfe.arraytotable(rpgicons_dest_names)) do
        -- /Dests/Names contains pairs of name and ref
        if (math.mod(i, 2) ~= 0) then
            rpgicons_dest_current = rpgicons_dest_names[i]
        else
            -- /D contains single pair of ref and fit
            -- third item of array contains objnum
            rpgicons_dests[rpgicons_dest_current] =
                rpgicons_pages[pdfe.arraytotable(rpgicons_dest_names[i].D)[1][3]]
        end
    end
end

function rpgicons_load_icon(dest, file)
    img.write({page = rpgicons_dests[dest], filename = file})
end