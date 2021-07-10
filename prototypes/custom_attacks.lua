---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/23/2020 8:27 PM
---

local String = require('__stdlib__/stdlib/utils/string')
local Math = require('__stdlib__/stdlib/utils/math')
local Table = require('__stdlib__/stdlib/utils/table')

local ForceHelper = require('__enemyracemanager__/lib/helper/force_helper')

local current_tier
local get_unit = function(unit_name)
    if current_tier == nil then
        current_tier = remote.call('enemy_race_manager', 'get_race_tier', MOD_NAME)
    end
    return unit_name[current_tier][Math.random(#unit_name[current_tier])]
end

local unit_name = {
    { 'cannon_shortrange' },
    { 'cannon_shortrange' },
    { 'cannon_shortrange', 'pylon' },
}
local get_probe_buildable_turrets = function()
    return get_unit(unit_name)
end

local CustomAttacks = {}

--effect_id :: string: The effect_id specified in the trigger effect.
--surface_index :: uint: The surface the effect happened on.
--source_position :: Position (optional)
--source_entity :: LuaEntity (optional)
--target_position :: Position (optional)
--target_entity :: LuaEntity (optional)
--https://lua-api.factorio.com/latest/LuaSurface.html#LuaSurface.create_entity
function CustomAttacks.process_probe(event)
    local surface = game.surfaces[event.surface_index]
    local nameToken = ForceHelper.getNameToken(event.source_entity.name)
    local level = nameToken[3]
    local position = event.source_position

    local unit_name = MOD_NAME .. '/' .. get_probe_buildable_turrets() .. '/' .. level

    if not surface.can_place_entity({ name = unit_name, position = position }) then
        position = surface.find_non_colliding_position(unit_name, event.source_position, 5, 1, true)
    end

    if position then
        surface.create_entity({ name = unit_name, position = position, force = event.source_entity.force })
    end

    event.source_entity.die('neutral')
end

return CustomAttacks