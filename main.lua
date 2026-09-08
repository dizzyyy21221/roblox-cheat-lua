-- GRABB.VIP - Protected (Working version)

local function decode(s)
    local t = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    local result = ""
    for i = 1, #s, 4 do
        local a = t:find(s:sub(i,i)) or 0
        local b = t:find(s:sub(i+1,i+1)) or 0
        local c = t:find(s:sub(i+2,i+2)) or 0
        local d = t:find(s:sub(i+3,i+3)) or 0
        local n = a * 0x40000 + b * 0x1000 + c * 0x40 + d
        result = result .. string.char(math.floor(n/0x10000) % 256)
        result = result .. string.char(math.floor(n/0x100) % 256)
        result = result .. string.char(n % 256)
    end
    return result:sub(1, -math.max(0, s:match("=*$"):len()))
end

local function decrypt(s,k)
    local r = ""
    for i = 1, #s do
        r = r .. string.char(string.byte(s,i) ~ k)
    end
    return r
end

-- Your encrypted script goes here
local e = ""

loadstring(decrypt(decode(e), 123))()
