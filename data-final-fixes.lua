local util = require("lib.recipe-util")

-- again...
util.add_unlock_force("electronics", "electronic-circuit")

if mods.MoreScience then
	util.add_ingredient("lab", "electronic-circuit", 10)
end
