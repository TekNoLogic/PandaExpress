
local myname, ns = ...


local recipes = {}


function ns.GetNumRecipes()
  return #recipes
end


function ns.GetRecipe(i)
  return recipes[i]
end


local function OnRecipeListRebuilt()
  wipe(recipes)

  for i,recipe in ipairs(TradeSkillFrame.RecipeList.dataList) do
    if recipe.recipeID then
      table.insert(recipes, recipe)
    end
  end
  ns.SendMessage("_RECIPE_LIST_UPDATED")
end


ns.RegisterCallback("_TRADESKILL_RECIPE_LIST_REBUILT", OnRecipeListRebuilt)
