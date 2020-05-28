local events = _G.defines.events
local script = _G.script

local game -- = _G.game, but _G.game is not available until on_init is called.

-- Format: {{entity = <LuaEntity>, nearby_players = {}}, ...}
local desks = {}

local function is_nearby(player, desk)
    -- Same Force?
    if player.force and desk.force and player.force.name ~= desk.force.name then
        return false
    end
    -- Same Surface?
    if player.surface and desk.surface and player.surface.name ~= desk.surface.name then
        return false
    end
    -- Player has a character, and a position, and is not spectating?
    if not player.character or not player.position or player.spectator then
        return false
    end
    -- In range of selection box?
    if desk.selection_box.left_top.x <= player.position.x
        and desk.selection_box.left_top.y <= player.position.y
        and desk.selection_box.right_bottom.x >= player.position.x
        and desk.selection_box.right_bottom.y >= player.position.y
    then
        return true
    end
    return false
end

local function table_contains(tbl, entry)
    for _, v in pairs(tbl) do
        if entry == v then
            return true
        end
    end
    return false
end

local function check_nearby_desks(player)
    if player and player.character and player.position then
        for _, desk in ipairs(desks) do
            -- If player is at the desk, enable the desk, add player to desk.nearby_players.
            if is_nearby(player, desk.entity) and not table_contains(desk.nearby_players, player) then
                table.insert(desk.nearby_players, player)
                desk.entity.active = true
            end
        end
    end
end

local function add_desk(event)
    if event.created_entity.name == "research-desk" then
        table.insert(desks, {entity = event.created_entity, nearby_players = {}})
        -- See if any players are close enough to use it, so we can enable it.
        for _, player in pairs(game.players) do
           check_nearby_desks(player)
        end
    end
end

local function remove_desk(event)
    if event.entity.name == "research-desk" then
        for i, desk in ipairs(desks) do
            if desk.entity == event.entity then
                -- Modifying mid-loop breaks iteration, but we're returning anyway
                table.remove(desks, i)
                return
            end
        end
    end
end

-- If a player walks near a desk, enable it
local function on_player_changed_position(event)
    -- Check if the player moved near a desk.
    check_nearby_desks(game.get_player(event.player_index))
    -- Check if any desks have lost their players.
    for _, desk in ipairs(desks) do
        local new_players = desk.nearby_players
        for i, player in ipairs(desk.nearby_players) do
            -- If player is no longer nearby, remove from nearby_players.
            -- Check the player who performed the action, too, in case they
            -- moved away. check_nearby_desks only adds.
            -- TODO: We could have check_nearby_desks return a list of added
            -- desks, or something, so we could avoid the is_nearby calculation
            -- again. Not sure if it's worth it; it's a fairly simple check.
            if not is_nearby(player, desk.entity) then
                table.remove(new_players, i)
                i = i - 1
            end
        end
        desk.nearby_players = new_players
        -- If desk.nearby_players is empty, disable the desk.
        desk.entity.active = next(desk.nearby_players) and true or false
    end
end

script.on_init(function()
    -- Start by finding all existing desks on the map, and store them for later.
    game = _G.game
    for surface_name, surface in pairs(game.surfaces) do
        for _, desk in ipairs(surface.find_entities_filtered{name = "research-desk"}) do
            table.insert(desks, {entity = desk, nearby_players = {}})
        end
    end
    -- Then add any nearby players from the start (only applicable in single-player mode)
    for _, player in pairs(game.players) do
        check_nearby_desks(player)
    end

    -- If a desk is added, add it
    script.on_event(events.on_built_entity, add_desk)
    script.on_event(events.on_robot_built_entity, add_desk)

    -- If a desk is mined, remove it
    script.on_event(events.on_player_mined_entity, remove_desk)
    script.on_event(events.on_robot_mined_entity, remove_desk)

    -- If a desk is destroyed, remove it
    script.on_event(events.on_entity_died, remove_desk)

    -- All of these need to re-check player range for the player.
    script.on_event(events.on_player_changed_force, on_player_changed_position)
    script.on_event(events.on_player_changed_position, on_player_changed_position)
    script.on_event(events.on_player_changed_surface, on_player_changed_position)
    script.on_event(events.on_player_died, on_player_changed_position)
    script.on_event(events.on_player_left_game, on_player_changed_position)
    script.on_event(events.on_player_kicked, on_player_changed_position)
    script.on_event(events.on_player_joined_game, on_player_changed_position)
    script.on_event(events.on_player_removed, on_player_changed_position)
    script.on_event(events.on_player_respawned, on_player_changed_position)
end)
