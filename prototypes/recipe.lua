local desk = {
    type = "recipe",
    name = "research-desk",
    ingredients = {
        {"wood", 1}, -- should be higher, maybe 10 wood, 5 plate, or something
        {"iron-plate", 1},
    },
    result = "research-desk",
    energy_required = 5, -- Seconds
}

_G.data:extend{desk}
