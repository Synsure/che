local hooks = require("hooks")
local inicfg = require 'inicfg'
local directIni = "sprinthook.ini"
local ini = inicfg.load({
    config = {
        act = true,
        speed = 0.25
    }
}, directIni)

local original_GetButtonSprintResults
function GetButtonSprintResults_hooked(CPlayerPed, sprintType)
    local result = original_GetButtonSprintResults(CPlayerPed, sprintType);
    if ini.config.act then
        result = result + ini.config.speed
    end
    return result
end

function main()
    while not isSampAvailable() do wait(0) end
    original_GetButtonSprintResults = hooks.jmp.new(
        "float(__thiscall*)(void* CPlayerPed, int sprintType)",
        GetButtonSprintResults_hooked, 0x60A820
    )
    wait(-1)
end

addEventHandler("onSendRpc", function(id, bs)
    if id == 50 then
        local length = raknetBitStreamReadInt32(bs)
        local cmd = raknetBitStreamReadString(bs, length)
        if string.find(cmd, "/sspeed") then
            local args = {}
            for arg in cmd:gmatch("%S+") do
                table.insert(args, arg)
            end
            if #args == 2 and (args[2]:match("^%d+$") or args[2]:match("^%d+%.%d+$")) then
                ini.config.speed = tonumber(args[2])
                sampAddChatMessage("Sprinthook -> ñêîðîñòü óñòàíîâëåíà íà "..ini.config.speed, -1)
                
            else
                sampAddChatMessage("Sprinthook -> Èñïîëüçóéòå /sspeed <ñêîðîñòü> | íàïðèìåð 0.25 èëè 1", -1)
            end
            inicfg.save(ini, directIni)
            return false
        end
    end
end)
