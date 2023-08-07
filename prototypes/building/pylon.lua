---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/21/2020 4:42 PM
---

require('__stdlib__/stdlib/utils/defines/time')

local ERM_UnitHelper = require('__enemyracemanager__/lib/rig/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/rig/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local TossSound = require('__erm_toss__/prototypes/sound')

local enemy_autoplace = require("__enemyracemanager__/lib/enemy-autoplace-utils")
local name = 'pylon'

-- Hitpoints

local hitpoint = 600
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value


-- Handles acid and poison resistance
local base_acid_resistance = 0
local incremental_acid_resistance = 75
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 85
-- Handles fire and explosive resistance
local base_fire_resistance = 10
local incremental_fire_resistance = 70
-- Handles laser and electric resistance
local base_electric_resistance = 25
local incremental_electric_resistance = 55
-- Handles cold resistance
local base_cold_resistance = 10
local incremental_cold_resistance = 65

-- Animation Settings
local unit_scale = 2

local pollution_absorption_absolute = 100
local spawning_cooldown = {780, 480}
local spawning_radius = 10
local max_count_of_owned_units = 9
local max_friends_around_to_spawn = 6
local spawn_table = function(level)
    local res = {}
    --Tire 1
    res[1] = { MOD_NAME .. '/zealot/' .. level, { { 0.0, 0.7 }, { 0.2, 0.7 }, { 0.4, 0.5 }, { 0.6, 0.3 }, { 0.8, 0.2 }, {1.0, 0.0} } }
    res[2] = { MOD_NAME .. '/dragoon/' .. level, { { 0.0, 0.3 }, { 0.2, 0.3 }, { 0.4, 0.3 }, { 0.6, 0.3 }, { 0.8, 0.2 } , {1.0, 0.0}} }
    --Tire 2
    res[3] = { MOD_NAME .. '/scout/' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.1 }, { 0.8, 0.15 }, {1.0, 0.1} } }
    res[4] = { MOD_NAME .. '/corsair/' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.1 }, { 0.8, 0.15 }, {1.0, 0.1} } }
    res[5] = { MOD_NAME .. '/probe/' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.1 }, { 0.8, 0.1 }, {1.0, 0.1} } }
    res[6] = { MOD_NAME .. '/shuttle/' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.1 }, { 0.8, 0.1 }, { 1.0, 0.1 } } }
    --Tire 3
    res[7] = { MOD_NAME .. '/templar/' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, {1.0, 0.1} } }
    res[8] = { MOD_NAME .. '/darktemplar/' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.1 }, {1.0, 0.1} } }
    res[9] = { MOD_NAME .. '/archon/' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, {1.0, 0.1} } }
    res[10] = { MOD_NAME .. '/carrier/' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, { 1.0, 0.05 } } }
    res[11] = { MOD_NAME .. '/arbiter/' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, { 1.0, 0.05 } } }
    res[12] = { MOD_NAME .. '/reaver/' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, { 1.0, 0.05 } } }
    res[13] = { MOD_NAME .. '/darkarchon/' .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, { 1.0, 0.05 } } }
    return res
end

local collision_box = { { -2, -2 }, { 2, 2 } }
local map_generator_bounding_box = { { -3, -3 }, { 3, 3 } }
local selection_box = { { -2, -2 }, { 2, 2 } }

function ErmToss.make_pylon(level)
    level = level or 1

    data:extend({
        {
            type = "unit-spawner",
            name = MOD_NAME .. '/' .. name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. name, level },
            icon = "__erm_toss__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            flags = { "placeable-player", "placeable-enemy" },
            max_health = ERM_UnitHelper.get_building_health(hitpoint, hitpoint * max_hitpoint_multiplier,  level),
            order = MOD_NAME .. "-" .. name,
            subgroup = "enemies",
            map_color = ERM_UnitHelper.format_map_color(settings.startup['erm_toss-map-color'].value),
            working_sound = TossSound.building_working_sound(name, 1),
            dying_sound = TossSound.building_dying_sound(1),
            resistances = {
                { type = "acid", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance,  level) },
                { type = "poison", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance,  level) },
                { type = "physical", percent = ERM_UnitHelper.get_resistance(base_physical_resistance, incremental_physical_resistance,  level) },
                { type = "fire", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance,  level) },
                { type = "explosion", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance,  level) },
                { type = "laser", percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance,  level) },
                { type = "electric", percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance,  level) },
                { type = "cold", percent = ERM_UnitHelper.get_resistance(base_cold_resistance, incremental_cold_resistance,  level) }
            },
            healing_per_tick = ERM_UnitHelper.get_building_healing(hitpoint, max_hitpoint_multiplier,  level),
            collision_box = collision_box,
            map_generator_bounding_box = map_generator_bounding_box,
            selection_box = selection_box,
            pollution_absorption_absolute = pollution_absorption_absolute,
            pollution_absorption_proportional = 0.01,
            corpse = MOD_NAME.."/small-base-corpse",
            dying_explosion = MOD_NAME..'/small-building-explosion',
            max_count_of_owned_units = max_count_of_owned_units,
            max_friends_around_to_spawn = max_friends_around_to_spawn,
            animations = {
                layers = {
                    {
                        filename = "__erm_toss__/graphics/entity/buildings/" .. name .. ".png",
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        animation_speed = 0.18,
                        direction_count = 1,
                        scale = unit_scale
                    },
                    {
                        filename = "__erm_toss__/graphics/entity/buildings/" .. name .. ".png",
                        variation_count = 1,
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        line_length = 1,
                        draw_as_shadow = true,
                        shift = { 0.25, 0.1 },
                        scale = unit_scale
                    },
                    {
                        filename = "__erm_toss__/graphics/entity/buildings/" .. name .. "_mask.png",
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        animation_speed = 0.18,
                        direction_count = 1,
                        draw_as_glow = true,
                        scale = unit_scale
                    }
                }
            },
            result_units = spawn_table(level),
            -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
            spawning_cooldown = spawning_cooldown,
            spawning_radius = spawning_radius,
            spawning_spacing = 3,
            max_spawn_shift = 0,
            max_richness_for_spawn_shift = 100,
            -- distance_factor used to be 1, but Twinsen says:
            -- "The number or spitter spwners should be roughly equal to the number of biter spawners(regardless of difficulty)."
            -- (2018-12-07)
            autoplace = enemy_autoplace.enemy_spawner_autoplace(0, FORCE_NAME),
            call_for_help_radius = 50,
            spawn_decorations_on_expansion = false,
        }
    })
end