local util = require("lib.recipe-util")


util.add_prerequisite("circuit-network", "copper-cable")
util.add_prerequisite("optics", "basic-electronics")
util.add_prerequisite("electronics", "basic-electronics")
util.add_prerequisite("automation", "inserter")
util.add_prerequisite("automation-2", "automation")
util.add_prerequisite("fast-inserter", "inserter")
util.add_prerequisite("logistics", "transport-belt")
util.add_prerequisite("logistic-science-pack", "transport-belt")
util.add_prerequisite("logistic-science-pack", "inserter")
util.add_prerequisite("electric-energy-distribution-1", "electric-energy-distribution-0")
util.add_prerequisite("space-science-pack", "visibility")
util.add_prerequisite("nuclear-power", "steam-power")
util.add_prerequisite("mining-productivity-1", "electric-mining")
util.add_prerequisite("fluid-handling", "basic-fluid-management")

util.add_prerequisite("electronics", "lab")

if mods.MoreScience then
	util.add_prerequisite("lab", "steam-power")
	util.add_prerequisite("bottling-research", "electric-lab")
	util.add_prerequisite("transport-belt", "basic-automation")
end
