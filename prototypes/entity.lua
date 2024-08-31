local desk = table.deepcopy(_G.data.raw["lab"]["lab"])
for k,v in pairs({
    type = "lab",
    name = "research-desk",
    icon = "__research-desk-fork-localized-en__/graphics/research-desk-icon.png",
    icon_size = 32,
    order = "c",
    max_health = 50,
    minable = {mining_time = 0.5, result = "research-desk"},
    off_animation = {
        layers = {
            {
                filename = "__research-desk-fork-localized-en__/graphics/research-desk-horizontal.png",
                size = {82, 82},
                frame_count = 1,
                line_length = 1,
                shift = {0.25, 0},
            },
            {
                filename = "__research-desk-fork-localized-en__/graphics/research-desk-horizontal-shadow.png",
                size = {82, 82},
                frame_count = 1,
                line_length = 1,
                draw_as_shadow = true,
                shift = {0.25, 0},
            },
        },
    },
    on_animation = {
        -- TODO: Animate this!
        layers = {
            {
                filename = "__research-desk-fork-localized-en__/graphics/research-desk-horizontal-busy.png",
                size = {82, 82},
                frame_count = 1,
                line_length = 1,
                shift = {0.25, 0},
            },
            {
                filename = "__research-desk-fork-localized-en__/graphics/research-desk-horizontal-shadow.png",
                size = {82, 82},
                frame_count = 1,
                line_length = 1,
                draw_as_shadow = true,
                shift = {0.25, 0},
            },
        },
    },
    placeable_by = {
        item = "research-desk",
        count = 1,
    },
    tile_width = 2,
    tile_height = 2,
    collision_box = {{-0.9, -0.9}, {0.9, 0.1}},
    selection_box = {{-1, -1}, {1, 1}},
    researching_speed = 2,
    energy_source = {
        type = "void",
        emissions = 0,
    },
    module_specification = {},

}) do
    desk[k] = v
end
desk.next_upgrade = nil
desk.localised_name = nil
data:extend{desk}
