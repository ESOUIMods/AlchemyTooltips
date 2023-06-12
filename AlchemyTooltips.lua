_G["AlchemyTooltips"] = {}

local function overrideDebug()
  --local old = _G["ItemTransferDialog_Keyboard"]["Refresh"]
  --_G[ATT_Variables.name]["ItemTransferDialog_Keyboard"]["Refresh"] = old
  local ItemTransferDialog_Keyboard = ZO_ItemTransferDialog_Base:Subclass()
  ItemTransferDialog_Keyboard["Initialize"] = function(control)
    return true
  end
end

local function OnAddOnLoaded(eventCode, addonName)
  if addonName == "AlchemyTooltips" then
    EVENT_MANAGER:UnregisterForEvent("AlchemyTooltips", EVENT_ADD_ON_LOADED)

    savedVars = ZO_SavedVars:NewAccountWide("AlchemyTooltipsSV", 1, nil, ATT_defaultSettings)
    ATT_HookBagTips()
    if not ATT_Variables.isInitialized then
      LibAlchemy:InitializePrices(LibAlchemy.SOURCE_ATTip)
      ATT_Variables.isInitialized = true
    end
    if savedVars.useCustomNames or savedVars.useCustomIcons or savedVars.useCustomQualities then
      ATT_HookItems()
    end

    ATT_LoadSettings()
    --overrideDebug()
  end
end
EVENT_MANAGER:RegisterForEvent("AlchemyTooltips", EVENT_ADD_ON_LOADED, OnAddOnLoaded)
