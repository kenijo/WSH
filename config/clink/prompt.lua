-------------------------------------------------------------------------------
-- @author       Kenrick JORUS
-- @copyright    2022 Kenrick JORUS
-- @license      MIT License
-- @link         http://kenijo.github.io/WSH/
-- @description  Use a custom CMD prompt (using Clink prompt filter)
--               !!! THIS FILE GETS OVERWRITTEN WHEN WSH IS UPDATED
-------------------------------------------------------------------------------

-- Makes a string safe to use as the replacement in string.gsub
local function verbatim(s)
    s = string.gsub(s, "%%", "%%%%")
    return s
end

local prompt = clink.promptfilter(30)
function prompt:filter(prompt)
    local cwd = clink.get_cwd()

    -- build our own prompt
    local new_prompt = "\x1b[0;37m[Path:\x1b[0;34m {cwd}\x1b[0;37m]\n\x1b[0;32m[{user}@{host}] \x1b[0;37mλ \x1b[0m"
    local lambda = "λ" 
    
    new_prompt = string.gsub(new_prompt, "{user}", os.getenv("USERNAME"))
    new_prompt = string.gsub(new_prompt, "{host}", os.getenv("COMPUTERNAME"))
    new_prompt = string.gsub(new_prompt, "{cwd}", verbatim(cwd))
    
    if env ~= nil then
        lambda = "("..env..") "..lambda
    end
    
    clink.prompt.value = string.gsub(new_prompt, "{lamb}", verbatim(lambda))
    
    return clink.prompt.value;
end
