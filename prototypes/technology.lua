_G.data:extend{
    -- Transport Belt
    {
        type = "technology",
        name = "transport-belt",
        icon = "__research-desk__/graphics/belt.png",
        icon_size = 128,
        order = "a",
        prerequisites = {},
        effects = {{type = "unlock-recipe", recipe = "transport-belt"}},
        unit = {
            count = 10,
            ingredients = {{"automation-science-pack", 1}},
            time = 5, -- seconds per pack
        },
    },
    -- Copper Cable; dependency of Electronic Circuit, Small Electric Pole
    {
        type = "technology",
        name = "copper-cable",
        icon = "__research-desk__/graphics/cable.png",
        icon_size = 64,
        order = "a",
        prerequisites = {},
        effects = {{type = "unlock-recipe", recipe = "copper-cable"}},
        unit = {
            count = 5,
            ingredients = {{"automation-science-pack", 1}},
            time = 5,
        },
    },
    -- Lab
    {
        type = "technology",
        name = "lab",
        icon = "__research-desk__/graphics/lab.png",
        icon_size = 196,
        order = "a",
        prerequisites = {"transport-belt", "electronics"},
        effects = {{type = "unlock-recipe", recipe = "lab"}},
        unit = {
            count = 20,
            ingredients = {{"automation-science-pack", 1}},
            time = 10,
        },
    },
    -- Inserter, dependency of Logistic Science Pack
    {
        type = "technology",
        name = "inserter",
        icon = "__research-desk__/graphics/inserter.png",
        icon_size = 64,
        order = "a",
        prerequisites = {"electronics"},
        effects = {{type = "unlock-recipe", recipe = "burner-inserter"}, {type = "unlock-recipe", recipe = "inserter"}},
        unit = {
            count = 10,
            ingredients = {{"automation-science-pack", 1}},
            time = 10,
        },
    },
    -- Small Electric Pole, dependency of Electric Energy Distribution 1
    {
        type = "technology",
        name = "electric-energy-distribution-0",
        icon = "__research-desk__/graphics/pole.png",
        icon_size = 128,
        order = "a",
        prerequisites = {"copper-cable"},
        effects = {{type = "unlock-recipe", recipe = "small-electric-pole"}},
        unit = {
            count = 5,
            ingredients = {{"automation-science-pack", 1}},
            time = 5,
        },
    },
    -- Radar, dependency of Space Science Pack
    {
        type = "technology",
        name = "visibility",
        icon = "__research-desk__/graphics/radar.png",
        icon_size = 128,
        order = "a",
        prerequisites = {"electronics"},
        effects = {{type = "unlock-recipe", recipe = "radar"}},
        unit = {
            count = 10,
            ingredients = {{"automation-science-pack", 1}},
            time = 10,
        },
    },
    -- Steam Power
    {
        type = "technology",
        name = "steam-power",
        icon = "__research-desk__/graphics/steam.png",
        icon_size = 196,
        order = "a",
        prerequisites = {"fluid-handling"},
        effects = {{type = "unlock-recipe", recipe = "boiler"}, {type = "unlock-recipe", recipe = "steam-engine"}},
        unit = {
            count = 30,
            ingredients = {{"automation-science-pack", 1}},
            time = 15,
        },
    },
    -- Electric Mining
    {
        type = "technology",
        name = "electric-mining",
        icon = "__research-desk__/graphics/mining.png",
        icon_size = 128,
        order = "a",
        prerequisites = {"electronics"},
        effects = {{type = "unlock-recipe", recipe = "electric-mining-drill"}},
        unit = {
            count = 30,
            ingredients = {{"automation-science-pack", 1}},
            time = 10,
        },
    },
    -- Machine Repair
    {
        type = "technology",
        name = "machine-repair",
        icon = "__research-desk__/graphics/repair.png",
        icon_size = 64,
        order = "a",
        prerequisites = {"electronics"},
        effects = {{type = "unlock-recipe", recipe = "repair-pack"}},
        unit = {
            count = 10,
            ingredients = {{"automation-science-pack", 1}},
            time = 10,
        },
    },
}
