ZZEditBox = {}
ZZEditBox.name = "ZZEditBox"

local LOG = LibDebugLogger and LibDebugLogger.Create(ZZEditBox.name)


function ZZEditBox.CreateWindow()
    if self.window then return self.window end

    local container = ZZEditBox_TopLevel

    local backdrop = WINDOW_MANAGER:CreateControlFromVirtual( nil
                                                            , container
                                                            , "ZO_EditBackdrop"
                                                            )
    backdrop:SetAnchor(TOPLEFT,     container, TOPLEFT,      5, 50)
    backdrop:SetAnchor(BOTTOMRIGHT, container, BOTTOMRIGHT, -5, -5)

    local editbox = WINDOW_MANAGER:CreateControlFromVirtual(
          nil
        , backdrop
        , "ZO_DefaultEditMultiLineForBackdrop"
        )

    editbox:SetMaxInputChars(20000)

    local text = self.GenerateText(6000)
    editbox:SetText(text)

    self.editbox = editbox

    return ZZEditBox_TopLevel
end

function ZZEditBox.GenerateText(char_ct)
    local char_per_line = 100
    local line_template = "%04d: 789 1234 6789 1234 6789 1234 6789 1234 6789 1234 6789 1234 6789 1234 6789 1234 6789 1234 6789 1234 6789 1234 6789 1234 6789 "
    local line_template = string.sub(line_template,1,char_per_line-1).."\n"
    local lines = {}
    for char_i = 1,char_ct,char_per_line do
        local line = string.format(line_template, char_i)
        table.insert(lines,line)
    end
    return table.concat(lines,"")
end

function ZZEditBox.SlashCommand()
    LOG:Debug("ZZEditBox.SlashCommand")
    self = ZZEditBox
    if not self.window then
        self.window = ZZEditBox.CreateWindow()
    end
    local was_hidden = self.window:IsHidden()

    self.window:SetHidden(not was_hidden)
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
