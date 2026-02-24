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
local rpgicons_pages = {}
local rpgicons_objects = {}

function rpgicons_get_refs(file)
    local rpgicons_file = pdfe.open(file)
    for i, o in pairs(pdfe.pagestotable(rpgicons_file)) do
        rpgicons_pages[i] = o[3]
    end
    
    local rpgicons_dest = ''
    local rpgicons_dests = rpgicons_file.Catalog.Names.Dests.Names
    for i, o in pairs(pdfe.arraytotable(rpgicons_dests)) do
        if (math.mod(i, 2) == 0) then
            rpgicons_objects[rpgicons_dest] = pdfe.arraytotable(rpgicons_dests[i].D)[1][3]
        else
            rpgicons_dest = rpgicons_dests[i]
        end
    end
end

local function rpgicons_get_page(dest)
    for p, d in pairs(rpgicons_pages) do
        if (d == rpgicons_objects[ref]) then
            return p
        end
    end
end

function rpgicons_load_icon(file, dest)
    img.write({filename=file, page=rpgicons_get_page(dest)})
end