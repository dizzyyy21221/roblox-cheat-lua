-- OBFUSCATOR.lua - Run this to encrypt your script
-- Paste your FULL script where it says YOUR_SCRIPT_HERE

local script = [[
-- Paste your ENTIRE GRABB.VIP script here
-- Everything from "if not game:IsLoaded()" to the end
]]

-- Simple but effective obfuscation
local function obfuscate(code)
    -- Remove comments
    code = code:gsub("%-%-[^\n]*", "")
    
    -- Simple variable renaming
    local vars = {}
    local counter = 0
    code = code:gsub("local (%w+)", function(name)
        if not vars[name] then
            counter = counter + 1
            vars[name] = "_" .. string.char(65 + math.random(0,25)) .. counter
        end
        return "local " .. vars[name]
    end)
    
    -- Encode strings
    code = code:gsub('"([^"]*)"', function(str)
        local encoded = ""
        for i = 1, #str do
            encoded = encoded .. "\\" .. string.byte(str, i)
        end
        return '"' .. encoded .. '"'
    end)
    
    return code
end

local obfuscated = obfuscate(script)
print("-- Obfuscated GRABB.VIP")
print(obfuscated)
