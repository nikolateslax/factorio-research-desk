-- New tech for existing recipes, so disable them at first.
-- Helper to disable a recipe, regardless of normal/expensive/default
local function disable_recipe(recipe)
    recipe.enabled = false
    if recipe.normal then
        recipe.normal.enabled = false
    end
    if recipe.expensive then
        recipe.expensive.enabled = false
    end
end
disable_recipe(_G.data.raw["recipe"]["lab"])
disable_recipe(_G.data.raw["recipe"]["electronic-circuit"])
disable_recipe(_G.data.raw["recipe"]["copper-cable"])
disable_recipe(_G.data.raw["recipe"]["transport-belt"])
disable_recipe(_G.data.raw["recipe"]["burner-inserter"])
disable_recipe(_G.data.raw["recipe"]["inserter"])
disable_recipe(_G.data.raw["recipe"]["small-electric-pole"])
disable_recipe(_G.data.raw["recipe"]["pipe"])
disable_recipe(_G.data.raw["recipe"]["pipe-to-ground"])
disable_recipe(_G.data.raw["recipe"]["radar"])
disable_recipe(_G.data.raw["recipe"]["offshore-pump"])
disable_recipe(_G.data.raw["recipe"]["steam-engine"])
disable_recipe(_G.data.raw["recipe"]["boiler"])
disable_recipe(_G.data.raw["recipe"]["electric-mining-drill"])
disable_recipe(_G.data.raw["recipe"]["repair-pack"])

-- Rearrange existing tech to depend on some of the new ones, as makes sense.
-- Helper to add a value to a table, creating the table if necessary.
-- If tbl[entity] does not exist, it is created as {value}; if it does exist, value is inserted at the end.
local function add_table_entry(tbl, entity, value)
    if not tbl[entity] then
        tbl[entity] = {value}
        return
    end
    table.insert(tbl[entity], value)
end
add_table_entry(_G.data.raw["technology"]["circuit-network"], "prerequisites", "copper-cable")
add_table_entry(_G.data.raw["technology"]["optics"], "prerequisites", "electronics")
add_table_entry(_G.data.raw["technology"]["electronics"], "prerequisites", "copper-cable")
add_table_entry(_G.data.raw["technology"]["automation"], "prerequisites", "electronics")
add_table_entry(_G.data.raw["technology"]["automation"], "prerequisites", "inserter")
add_table_entry(_G.data.raw["technology"]["automation-2"], "prerequisites", "automation")
add_table_entry(_G.data.raw["technology"]["fast-inserter"], "prerequisites", "inserter")
add_table_entry(_G.data.raw["technology"]["logistics"], "prerequisites", "transport-belt")
add_table_entry(_G.data.raw["technology"]["logistic-science-pack"], "prerequisites", "transport-belt")
add_table_entry(_G.data.raw["technology"]["logistic-science-pack"], "prerequisites", "inserter")
add_table_entry(_G.data.raw["technology"]["electric-energy-distribution-1"], "prerequisites", "electric-energy-distribution-0")
add_table_entry(_G.data.raw["technology"]["space-science-pack"], "prerequisites", "visibility")
add_table_entry(_G.data.raw["technology"]["nuclear-power"], "prerequisites", "steam-power")
add_table_entry(_G.data.raw["technology"]["mining-productivity-1"], "prerequisites", "electric-mining")

-- Add old recipes to old technologies, to fit new style
add_table_entry(_G.data.raw["technology"]["electronics"], "effects", {type = "unlock-recipe", recipe = "electronic-circuit"})
add_table_entry(_G.data.raw["technology"]["fluid-handling"], "effects", {type = "unlock-recipe", recipe = "pipe"})
add_table_entry(_G.data.raw["technology"]["fluid-handling"], "effects", {type = "unlock-recipe", recipe = "pipe-to-ground"})
add_table_entry(_G.data.raw["technology"]["fluid-handling"], "effects", {type = "unlock-recipe", recipe = "offshore-pump"})

-- Remove electronics requirement from automation, since we've reversed those.
for i, v in ipairs(_G.data.raw["technology"]["electronics"].prerequisites) do
    if v == 'automation' then
        table.remove(_G.data.raw["technology"]["electronics"].prerequisites, i)
        break
    end
end