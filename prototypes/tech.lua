local function make_tech(tech_name, pre, cnt, tm, img, img_sz)
	local tech = {
		type = "technology",
		name = tech_name,
		order = "a",
		prerequisites = pre,
		unit = {
			count = cnt,
			ingredients = {{"automation-science-pack", 1}},
			time = tm,
		},
		icon = "__research-desk-fork-localized-en__/graphics/" .. img
	}
	
	if img_sz then
		tech.icon_size = img_sz
	else
		tech.icon_size = 64
		tech.icon_mipmaps = 4
	end
	
	data:extend{tech}
end


make_tech("basic-cable", {}, 5, 5, "cable.png")
make_tech("basic-electronics", {"basic-cable"},  10,  5, "board.png")
make_tech("electric-energy-distribution-0", {"basic-cable"}, 5, 5, "pole.png", 128)

make_tech("transport-belt", {}, 10, 5, "belt.png", 128)
make_tech("inserter", {"electric-energy-distribution-0", "basic-electronics"}, 10, 10, "inserter.png")

make_tech("basic-fluid-management", {}, 10, 10, "pipe.png", 160)
make_tech("steam-power", {"basic-fluid-management", "electric-energy-distribution-0"}, 30, 15, "steam.png", 196)

make_tech("visibility", {"basic-electronics"}, 10, 10, "radar.png", 128)
make_tech("electric-mining", {"basic-electronics"}, 30, 10, "mining.png", 128)
make_tech("machine-repair", {"basic-electronics"}, 10, 10, "repair.png")


-- mod compat

make_tech("lab", {"transport-belt", "basic-electronics"}, 20, 10, "lab.png", 196)

if mods.MoreScience then
	make_tech("electric-lab", {"lab", "electronics"}, 30, 20, "lab.png", 196)
end
