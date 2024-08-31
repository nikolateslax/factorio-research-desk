data:extend({
	{
		type = "recipe",
		name = "research-desk",
		ingredients = {
			{"wood", 16},
			{"iron-plate", 6},
			{"stone", 10},
		},
		result = "research-desk",
		energy_required = 5, -- Seconds
	}, {
		type = "recipe",
		name = "circuit-board",
		enabled = false,
		normal = {
			ingredients = {
				{"wood", 1},
				{"copper-cable", 1}
			},
			result = "circuit-board",
			enabled = false,
		},
		expensive = {
			ingredients = {
				{"wood", 2},
				{"copper-cable", 3}
			},
			result = "circuit-board",
			enabled = false,
		}
	}
});



