
local myname, ns = ...


local CRAFT_MACRO = "/run C_TradeSkillUI.CraftRecipe(RECIPE_ID)"
local ENCH_MACRO = [[
/run C_TradeSkillUI.CraftRecipe(RECIPE_ID)
/use item:38682
]]
local JUMP_MACRO = [[
/run TradeSkillFrame.RecipeList:SetSelectedRecipeID(RECIPE_ID)
/run TradeSkillFrame.RecipeList:ForceRecipeIntoView(RECIPE_ID)
]]


local function Memo(macro)
  local function f(recipe_id) return macro:gsub("RECIPE_ID", recipe_id) end
  return ns.NewMemoizingTable(f)
end


local craft_macros = Memo(CRAFT_MACRO)
local ench_macros = Memo(ENCH_MACRO)
local jump_macros = Memo(JUMP_MACRO)


local function GenerateCraftMacro(recipe_id)
  if ns.GetNumCraftable(recipe_id) == 0 then return end
  if ns.CanUseVellum(recipe_id) then return ench_macros[recipe_id] end
  return craft_macros[recipe_id]
end


local function GenerateJumpMacro(recipe_id)
  return jump_macros[recipe_id]
end


function ns.GenerateMacro(button, recipe_id)
  if button == "LeftButton" then
    return GenerateCraftMacro(recipe_id) or GenerateJumpMacro(recipe_id)
  end

  return GenerateJumpMacro(recipe_id)
end
