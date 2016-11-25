
local myname, ns = ...


local function OnRefreshDisplay()
  ns.SendMessage("_TRADESKILL_DETAILS_REFRESH")
end


local function OnLoad()
  hooksecurefunc(TradeSkillFrame.DetailsFrame, "RefreshDisplay", OnRefreshDisplay)
end


ns.RegisterCallback("_THIS_ADDON_LOADED", OnLoad)
