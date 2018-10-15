-- Addon.lua
-- @Author : DengSir (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/10/2018, 1:18:02 PM

-- local doNothing = CreateFrame('Button', 'tdVechicleHotkeyDoNothing', UIParent, 'SecureHandlerClickTemplate')

local override = CreateFrame('Button', 'tdVechicleHotkey', UIParent, 'SecureHandlerShowHideTemplate')
RegisterStateDriver(override, 'visibility', '[vehicleui][overridebar]show;hide')
override:Hide()
override:SetAttribute('_onshow', [[
    for i = 1, 6 do
        self:SetBindingClick(false, tostring(i), 'OverrideActionBarButton' .. i)

        for _, key in ipairs(table.new(GetBindingKey('ACTIONBUTTON' .. i))) do
            self:SetBindingClick(false, key, 'tdVechicleHotkey')
        end
    end
]])
override:SetAttribute('_onhide', [[
    self:ClearBindings()
]])

local function UpdateHotkey()
    for i = 1, 6 do
        local hotkey = _G['OverrideActionBarButton' .. i].HotKey
        hotkey:SetText(i)
        hotkey:Show()
    end
end

override:RegisterEvent('UPDATE_BINDINGS')
override:SetScript('OnEvent', UpdateHotkey)
override:HookScript('OnShow', UpdateHotkey)

if not InCombatLockdown() and OverrideActionBar:IsShown() then
    override:SetAttribute('state-vehicleui', 1)
end
