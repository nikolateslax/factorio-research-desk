local util = require("lib.recipe-util")

local function reset_recipe(tech, recipe)
	--util.set_enabled(recipe, false)
	util.add_unlock_force(tech, recipe)
end

util.add_unlock("basic-electronics", "circuit-board")

reset_recipe("transport-belt", "transport-belt")
reset_recipe("inserter", "burner-inserter")
reset_recipe("inserter", "inserter")
reset_recipe("electric-energy-distribution-0", "small-electric-pole")
reset_recipe("basic-fluid-management", "pipe")
reset_recipe("basic-fluid-management", "pipe-to-ground")
reset_recipe("visibility", "radar")
reset_recipe("basic-fluid-management", "offshore-pump")
reset_recipe("steam-power", "steam-engine")
reset_recipe("steam-power", "boiler")
reset_recipe("electric-mining", "electric-mining-drill")
reset_recipe("machine-repair", "repair-pack")

util.add_unlock_force("electronics", "electronic-circuit") 


-- nod compat

local lab = "lab"
local plate = settings.startup["circuit-material"].value
local cable = mods.bzaluminum and "aluminum-cable" or "copper-cable"

if not data.raw.item[plate] then
	log("Unknow material " .. plate .. " cannot be used in circuit-board recipe. Rollback to wood.")
	plate = "wood"
end

reset_recipe("basic-cable", cable)

if mods.MoreScience then
	lab = "lab-mk0"
	reset_recipe("electric-lab", "lab")
end
reset_recipe("lab", lab) 


if data.raw.item["chute-miniloader"] then
	reset_recipe("transport-belt", "chute-miniloader")
	util.add_ingredient("miniloader", "chute-miniloader", 1)
	util.add_ingredient("filter-miniloader", "chute-miniloader", 1)
end


-- recipe chages
util.replace_ingredient("circuit-board", "wood", plate)
util.replace_ingredient("circuit-board", "copper-cable", cable)

util.replace_ingredients_prior_to("electronics", "electronic-circuit", "circuit-board")

if settings.startup["inherit-desk"].value then
	util.add_ingredient(lab, "research-desk", 1)
end
if settings.startup["inherit-circuit"].value then
	util.add_ingredient("electronic-circuit", "circuit-board", 1)
end
