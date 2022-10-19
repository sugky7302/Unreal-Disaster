local jass = require 'jass.common'
local pairs = pairs

function ReloadModule(module_name)
    local old_module = package.loaded[module_name] or {}
    package.loaded[module_name] = nil
    require (module_name)

    local new_module = package.loaded[module_name]
    for k, v in pairs(new_module) do
        old_module[k] = v
    end

    package.loaded[module_name] = old_module
    return old_module
end

---再將此表中的版本號與 _ENV.VERSION_RECORD 進行比對，如果不一致則會重新加載
---最後把 _ENV.VERSION_RECORD 設為 file_version 的內容
local function Hotfix()
    print(2)
    -- 先重新讀取 file_version，以便在 hotfix 時能夠重新讀取最新的版本號
    package.loaded['scripts.file_version'] = nil
    print(3)
    local content = Import('file_version')
    print(content)
    for k, v in pairs(content) do
        print(k, v)
        if ENV.VERSION_RECORDS[k] ~= content[k] then
            print("hotfix: " .. k .. " " .. ENV.VERSION_RECORDS[k] .. " -> " .. content[k])
            ReloadModule(k)
        end
    end
end

local function main()
    print(1)
    local trg = jass.CreateTrigger()
    jass.TriggerRegisterPlayerChatEvent(trg, jass.Player(0), "reload", true)
    jass.TriggerAddCondition(trg, jass.Condition(function()
        Hotfix()
        return true
    end))
end

main()
