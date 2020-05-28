local desk = {
    type = "item",
    name = "research-desk",
    icon = "__research-desk__/graphics/research-desk-icon.png",
    icon_size = 32,
    picture = {
        filename = "__research-desk__/graphics/research-desk-horizontal.png"
    },
    place_result = "research-desk",
    group = "production",
    subgroup = "production-machine",
    order = "g[research-desk]",
    stack_size = 1
}

_G.data:extend{desk}
