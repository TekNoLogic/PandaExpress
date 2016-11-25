
local myname, ns = ...


local function OnRebuildDataList()
  ns.SendMessage("_TRADESKILL_RECIPE_LIST_REBUILT")
end


local function OnLoad()
  hooksecurefunc(TradeSkillFrame.RecipeList, "RebuildDataList", OnRebuildDataList)
end


ns.RegisterCallback("_THIS_ADDON_LOADED", OnLoad)
