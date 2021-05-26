ZZEditBox = {}
ZZEditBox.name = "ZZEditBox"

local LOG = LibDebugLogger and LibDebugLogger.Create(ZZEditBox.name)

function ZZEditBox.SlashCommand()
	LOG:Debug("ZZEditBox.SlashCommand")
end


-- Init ----------------------------------------------------------------------

function ZZEditBox.OnAddOnLoaded(event, addonName)
    local self = ZZEditBox
    if addonName ~= self.name then return end


    SLASH_COMMANDS["/zzee"] = ZZEditBox.SlashCommand
end


EVENT_MANAGER:RegisterForEvent( ZZEditBox.name
                              , EVENT_ADD_ON_LOADED
                              , ZZEditBox.OnAddOnLoaded
                              )
