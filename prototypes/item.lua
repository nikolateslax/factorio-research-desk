data:extend{
	{
		type = "item",
		name = "research-desk",
		icon = "__research-desk-fork__/graphics/research-desk-icon.png",
		icon_size = 32,
		picture = {
			filename = "__research-desk-fork__/graphics/research-desk-horizontal.png"
		},
		place_result = "research-desk",
		group = "production",
		subgroup = "production-machine",
		order = "g[research-desk]",
		stack_size = 1
	}, {
		type = "item",
		name = "circuit-board",
		icon = "__research-desk-fork__/graphics/board.png",
		icon_size = 64,
		icon_mipmaps = 4,
		subgroup = "intermediate-product",
		order = "e[cuircuit-board]",
		stack_size = 200
	}
};
