---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/22/2020 12:37 AM
---
require('__stdlib__/stdlib/utils/defines/time')

local ERM_UnitHelper = require('__enemyracemanager__/lib/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local ERM_Config = require('__enemyracemanager__/lib/global_config')
local TossSound = require('__erm_toss__/prototypes/sound')

local enemy_autoplace = require("__enemyracemanager__/lib/enemy-autoplace-utils")
local name = 'cannon'
local shortrange_name = 'cannon_shortrange'

-- Hitpoints
local health_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local hitpoint = 200
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 2

local resistance_mutiplier = settings.startup["enemyracemanager-level-multipliers"].value
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
local map_generator_bounding_box = { { -3, -3 }, { 3, 3 } }
local selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

-- Handles damages
local damage_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_electric_damage = 5
local incremental_electric_damage = 70

-- for acid cannon
local base_acid_damage = 5
local incremental_acid_damage = 25

-- Handles Attack Speed
local attack_speed_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_attack_speed = 300
local incremental_attack_speed = 240

local attack_range = 20
local acid_attack_range = 30
local attack_shortrange = ERM_Config.get_max_attack_range()

-- Animation Settings
local unit_scale = 1.5

local folded_animation = function()
    return {
        layers = {
            {
                filename = "__erm_toss__/graphics/entity/buildings/" .. name .. ".png",
                width = 128,
                height = 128,
                frame_count = 1,
                direction_count = 1,
                scale = unit_scale,
            },
        }
    }
end

local attack_animation = function()
    return {
        layers = {
            {
                filename = "__erm_toss__/graphics/entity/buildings/" .. name .. "_attack.png",
                width = 128,
                height = 128,
                frame_count = 3,
                direction_count = 1,
                scale = unit_scale,
                run_mode = "forward-then-backward",
            },
        }
    }
end

function ErmToss.make_cannon(level)
    level = level or 1

    data:extend({
        --- Regular cannon turret
        {
            type = "turret",
            name = MOD_NAME .. '/' .. name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. name, level },
            icon = "__erm_toss__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            flags = { "placeable-player", "placeable-enemy", "placeable-off-grid" },
            max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_multiplier, health_multiplier, level),
            order = MOD_NAME .. "-" .. name,
            subgroup = "enemies",
            resistances = {
                { type = "acid", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance, resistance_mutiplier, level) },
                { type = "poison", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance, resistance_mutiplier, level) },
                { type = "physical", percent = ERM_UnitHelper.get_resistance(base_physical_resistance, incremental_physical_resistance, resistance_mutiplier, level) },
                { type = "fire", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance, resistance_mutiplier, level) },
                { type = "explosion", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance, resistance_mutiplier, level) },
                { type = "laser", percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance, resistance_mutiplier, level) },
                { type = "electric", percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance, resistance_mutiplier, level) },
                { type = "cold", percent = ERM_UnitHelper.get_resistance(base_cold_resistance, incremental_cold_resistance, resistance_mutiplier, level) }
            },
            healing_per_tick = ERM_UnitHelper.get_building_healing(hitpoint, max_hitpoint_multiplier, health_multiplier, level),
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
            integration = {
                layers = {
                    {
                        filename = "__erm_toss__/graphics/entity/buildings/" .. name .. ".png",
                        variation_count = 1,
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        line_length = 1,
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
                        shift = { 0.5, 0.1 },
                        scale = unit_scale
                    }
                }
            },
            autoplace = enemy_autoplace.enemy_worm_autoplace(0, FORCE_NAME),
            attack_from_start_frame = true,
            prepare_range = attack_range,
            allow_turning_when_starting_attack = true,
            attack_parameters = {
                type = "projectile",
                ammo_category = 'protoss-cannon-shell',
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed, attack_speed_multiplier, level),
                cooldown_deviation = 0.1,
                ammo_type = {
                    category = "protoss-cannon-shell",
                    target_type = "direction",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "projectile",
                            projectile = "dragoon-projectile",
                            starting_speed = 0.3,
                            target_effects = {
                                {
                                    type = "damage",
                                    damage = { amount = ERM_UnitHelper.get_damage(base_electric_damage, incremental_electric_damage, damage_multiplier, level), type = "electric" }
                                }
                            }
                        }
                    }
                },
                sound = TossSound.ball_attack(1),
            }
        },
        --- Acid cannon turret
        {
            type = "turret",
            name = MOD_NAME .. '/acid-' .. name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/acid-' .. name, level },
            icon = "__erm_toss__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            flags = { "placeable-player", "placeable-enemy", "placeable-off-grid" },
            max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_multiplier, health_multiplier, level),
            order = MOD_NAME .. "-" .. name,
            subgroup = "enemies",
            resistances = {
                { type = "acid", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance, resistance_mutiplier, level) },
                { type = "poison", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance, resistance_mutiplier, level) },
                { type = "physical", percent = ERM_UnitHelper.get_resistance(base_physical_resistance, incremental_physical_resistance, resistance_mutiplier, level) },
                { type = "fire", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance, resistance_mutiplier, level) },
                { type = "explosion", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance, resistance_mutiplier, level) },
                { type = "laser", percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance, resistance_mutiplier, level) },
                { type = "electric", percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance, resistance_mutiplier, level) },
                { type = "cold", percent = ERM_UnitHelper.get_resistance(base_cold_resistance, incremental_cold_resistance, resistance_mutiplier, level) }
            },
            healing_per_tick = ERM_UnitHelper.get_building_healing(hitpoint, max_hitpoint_multiplier, health_multiplier, level),
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
            integration = {
                layers = {
                    {
                        filename = "__erm_toss__/graphics/entity/buildings/" .. name .. ".png",
                        variation_count = 1,
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        line_length = 1,
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
                        shift = { 0.5, 0.1 },
                        scale = unit_scale
                    }
                }
            },
            autoplace = enemy_autoplace.enemy_worm_autoplace(0, FORCE_NAME),
            attack_from_start_frame = true,
            prepare_range = acid_attack_range,
            allow_turning_when_starting_attack = true,
            attack_parameters = {
                type = "projectile",
                ammo_category = 'biological',
                damage_modifier = ERM_UnitHelper.get_damage(base_acid_damage, incremental_acid_damage, damage_multiplier, level),
                range = acid_attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed, attack_speed_multiplier, level),
                cooldown_deviation = 0.1,
                warmup = 12,
                use_shooter_direction = true,
                lead_target_for_projectile_speed = 0.2 * 0.75 * 1.5 * 1.5,
                ammo_type = {
                    category = "biological",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "stream",
                            stream = "acid-stream-worm-behemoth",
                            source_offset = { 0.15, -0.5 }
                        }
                    }
                },
                sound = TossSound.ball_attack(1),
            }
        },
        --- Short range cannon turret
        {
            type = "turret",
            name = MOD_NAME .. '/' .. shortrange_name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. shortrange_name, level },
            icon = "__erm_toss__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            flags = { "placeable-player", "placeable-enemy", "placeable-off-grid" },
            max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_multiplier, health_multiplier, level) / 2,
            order = MOD_NAME .. "-" .. shortrange_name,
            subgroup = "enemies",
            resistances = {
                { type = "acid", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance, resistance_mutiplier, level) },
                { type = "poison", percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance, resistance_mutiplier, level) },
                { type = "physical", percent = ERM_UnitHelper.get_resistance(base_physical_resistance, incremental_physical_resistance, resistance_mutiplier, level) },
                { type = "fire", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance, resistance_mutiplier, level) },
                { type = "explosion", percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance, resistance_mutiplier, level) },
                { type = "laser", percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance, resistance_mutiplier, level) },
                { type = "electric", percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance, resistance_mutiplier, level) },
                { type = "cold", percent = ERM_UnitHelper.get_resistance(base_cold_resistance, incremental_cold_resistance, resistance_mutiplier, level) }
            },
            healing_per_tick = ERM_UnitHelper.get_building_healing(hitpoint, max_hitpoint_multiplier, health_multiplier, level),
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
            integration = {
                layers = {
                    {
                        filename = "__erm_toss__/graphics/entity/buildings/" .. name .. ".png",
                        variation_count = 1,
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        line_length = 1,
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
                        shift = { 0.5, 0.1 },
                        scale = unit_scale
                    }
                }
            },
            --autoplace = enemy_autoplace.enemy_worm_autoplace(0, FORCE_NAME),
            attack_from_start_frame = true,
            prepare_range = attack_range,
            allow_turning_when_starting_attack = true,
            attack_parameters = {
                type = "projectile",
                ammo_category = 'protoss-cannon-shell',
                range = attack_shortrange,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed, attack_speed_multiplier, level),
                cooldown_deviation = 0.1,
                ammo_type = {
                    category = "protoss-cannon-shell",
                    target_type = "direction",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "projectile",
                            projectile = "dragoon-projectile",
                            starting_speed = 0.3,
                            target_effects = {
                                {
                                    type = "damage",
                                    damage = { amount = ERM_UnitHelper.get_damage(base_electric_damage, incremental_electric_damage, damage_multiplier, level), type = "electric" }
                                }
                            }
                        }
                    }
                },
                sound = TossSound.ball_attack(1),
            }
        }
    })
end