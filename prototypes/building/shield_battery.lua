---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 7/20/2023 9:14 PM
---

---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/22/2020 12:37 AM
---
require('__stdlib__/stdlib/utils/defines/time')

local ERM_UnitHelper = require('__enemyracemanager__/lib/rig/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/rig/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local ERM_Config = require('__enemyracemanager__/lib/global_config')
local TossSound = require('__erm_toss__/prototypes/sound')

local enemy_autoplace = require("__enemyracemanager__/lib/enemy-autoplace-utils")
local name = 'shield_battery'

-- Hitpoints

local hitpoint = 300
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 3


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

local collision_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }
local map_generator_bounding_box = { { -2.5, -2.5 }, { 2.5, 2.5 } }
local selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

-- Handles damages

local base_heal_damage = 1
local incremental_heal_damage = 4


-- Handles Attack Speed

local base_attack_speed = 900
local incremental_attack_speed = 300

local attack_range = 30

-- Animation Settings
local unit_scale = 1.5

local folded_animation = function()
    return {
        layers = {
            {
                filename = "__erm_toss__/graphics/entity/buildings/" .. name .. ".png",
                width = 96,
                height = 64,
                frame_count = 1,
                direction_count = 1,
                scale = unit_scale,
            },
            {
                filename = "__erm_toss__/graphics/entity/buildings/" .. name .. ".png",
                width = 96,
                height = 64,
                frame_count = 1,
                direction_count = 1,
                scale = unit_scale,
                draw_as_shadow = true,
                shift = { 0.25, 0.1 },
            },
        }
    }
end

local attack_animation = function()
    return {
        layers = {
            {
                filename = "__erm_toss__/graphics/entity/buildings/" .. name .. ".png",
                width = 96,
                height = 64,
                frame_count = 1,
                direction_count = 1,
                scale = unit_scale,
            },
            {
                filename = "__erm_toss__/graphics/entity/buildings/" .. name .. ".png",
                width = 96,
                height = 64,
                frame_count = 1,
                direction_count = 1,
                scale = unit_scale,
                draw_as_shadow = true,
                shift = { 0.25, 0.1 },
            },
        }
    }
end

function ErmToss.make_shield_battery(level)
    level = level or 1

    data:extend({

        {
            type = "turret",
            name = MOD_NAME .. '/' .. name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. name, level },
            icon = "__erm_toss__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            flags = { "placeable-player", "placeable-enemy", },
            max_health = ERM_UnitHelper.get_building_health(hitpoint, hitpoint * max_hitpoint_multiplier,  level),
            order = MOD_NAME .. "-" .. name,
            subgroup = "enemies",
            map_color = ERM_UnitHelper.format_map_color(settings.startup['erm_toss-map-color'].value),
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
            shooting_cursor_size = 4,
            rotation_speed = 1,
            corpse = "toss-small-base-corpse",
            dying_explosion = "toss-small-building-explosion",
            dying_sound = TossSound.building_dying_sound(1),
            call_for_help_radius = 50,
            folded_speed = 0.01,
            folded_speed_secondary = 0.01,
            folded_animation = folded_animation(),
            working_sound = TossSound.cannon_idle(1),
            starting_attack_animation = attack_animation(),
            starting_attack_speed = 0.02,
            autoplace = enemy_autoplace.enemy_worm_autoplace(0, FORCE_NAME),
            attack_from_start_frame = true,
            prepare_range = attack_range,
            allow_turning_when_starting_attack = true,
            attack_parameters = {
                type = "projectile",
                range_mode = "bounding-box-to-bounding-box",
                ammo_category = 'protoss-damage',
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed,  level),
                cooldown_deviation = 0.1,
                damage_modifier = ERM_UnitHelper.get_damage(base_heal_damage, incremental_heal_damage,  level),
                ammo_type = {
                    category = "protoss-damage",
                    target_type = "direction",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "create-explosion",
                                    entity_name = "shield-battery-explosion"
                                },
                                {
                                    type = "damage",
                                    damage = { amount = 20, type = "electric" },
                                },
                                {
                                    type = "nested-result",
                                    action = {
                                        type = "area",
                                        force = 'same',
                                        radius = 5,
                                        ignore_collision_condition = true,
                                        action_delivery = {
                                            type = "instant",
                                            target_effects = {
                                                {
                                                    type = "damage",
                                                    damage = { amount = -200, type = "healing" },
                                                },
                                            },
                                        }
                                    }
                                }
                            }
                        }
                    },
                },
                sound = TossSound.shield_battery_ability(0.75),
            }
        },
    })
end