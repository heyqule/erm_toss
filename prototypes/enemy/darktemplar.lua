--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--
require('__stdlib__/stdlib/utils/defines/time')
local Sprites = require('__stdlib__/stdlib/data/modules/sprites')

local ERM_UnitHelper = require('__enemyracemanager__/lib/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local TossSound = require('__erm_toss__/prototypes/sound')
local name = 'darktemplar'

local health_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local hitpoint = 120
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 2

local resistance_mutiplier = settings.startup["enemyracemanager-level-multipliers"].value
-- Handles acid and poison resistance
local base_acid_resistance = 0
local incremental_acid_resistance = 90
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 95
-- Handles fire and explosive resistance
local base_fire_resistance = 0
local incremental_fire_resistance = 95
-- Handles laser and electric resistance
local base_electric_resistance = 25
local incremental_electric_resistance = 70
-- Handles cold resistance
local base_cold_resistance = 25
local incremental_cold_resistance = 70

-- Handles physical damages
local damage_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_physical_damage = 50
local incremental_physical_damage = 70

-- Handles Attack Speed
local attack_speed_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_attack_speed = 120
local incremental_attack_speed = 30

local attack_range = 1

local movement_multiplier = settings.startup["enemyracemanager-level-multipliers"].value
local base_movement_speed = 0.1
local incremental_movement_speed = 0.075

-- Misc settings
local vision_distance = 30

local pollution_to_join_attack = 300
local distraction_cooldown = 20

-- Animation Settings
local unit_scale = 1

local collision_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }
local selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }

function ErmToss.make_darktemplar(level)
    level = level or 1

    data:extend({
        {
            type = "unit",
            name = MOD_NAME .. '/' .. name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. name, level },
            icon = "__erm_toss__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "breaths-air" },
            has_belt_immunity = false,
            max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_multiplier, health_multiplier, level),
            order = MOD_NAME .. '/'  .. name .. '/' .. level,
            subgroup = "enemies",
            shooting_cursor_size = 2,
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
            healing_per_tick = ERM_UnitHelper.get_healing(hitpoint, max_hitpoint_multiplier, health_multiplier, level),
            --collision_mask = { "player-layer" },
            collision_box = collision_box,
            selection_box = selection_box,
            sticker_box = selection_box,
            vision_distance = vision_distance,
            movement_speed = ERM_UnitHelper.get_movement_speed(base_movement_speed, incremental_movement_speed, movement_multiplier, level),
            pollution_to_join_attack = pollution_to_join_attack,
            distraction_cooldown = distraction_cooldown,
            ai_settings = biter_ai_settings,
            attack_parameters = {
                type = "projectile",
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed, attack_speed_multiplier, level),
                cooldown_deviation = 0.1,
                ammo_type = {
                    category = "melee",
                    action = {
                        type = "area",
                        radius = 2,
                        ignore_collision_condition = true,
                        action_delivery = {
                            type = "instant",
                            target_effects = {
                                {
                                    type = "damage",
                                    damage = {
                                        amount = ERM_UnitHelper.get_damage(base_physical_damage, incremental_physical_damage, damage_multiplier, level),
                                        type = "physical"
                                    },
                                    apply_damage_to_trees = true
                                }
                            }
                        }
                    }
                },
                sound = TossSound.darktemplar_attack(0.75),
                animation = {
                    layers = {
                        {
                            filename = "__erm_toss__/graphics/entity/units/" .. name .. "/" .. name .. "-attack.png",
                            width = 64,
                            height = 64,
                            frame_count = 9,
                            axially_symmetrical = false,
                            direction_count = 16,
                            scale = unit_scale,
                            animation_speed = 0.6
                        },
                        {
                            filename = "__erm_toss__/graphics/entity/units/" .. name .. "/" .. name .. "-attack.png",
                            width = 64,
                            height = 64,
                            frame_count = 9,
                            axially_symmetrical = false,
                            direction_count = 16,
                            scale = unit_scale,
                            animation_speed = 0.6,
                            tint = ERM_UnitTint.tint_shadow(),
                            draw_as_shadow = true,
                            shift = { 0.2, 0 }
                        }
                    }
                }
            },

            distance_per_frame = 0.2,
            run_animation = {
                layers = {
                    {
                        filename = "__erm_toss__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                        width = 64,
                        height = 64,
                        frame_count = 10,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        animation_speed = 1,
                    },
                    {
                        filename = "__erm_toss__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                        width = 64,
                        height = 64,
                        frame_count = 10,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        animation_speed = 1,
                        tint = ERM_UnitTint.tint_shadow(),
                        draw_as_shadow = true,
                        shift = { 0.2, 0 }
                    }
                }
            },
            dying_sound = TossSound.enemy_death(name, 0.75),
            dying_explosion = 'protoss-zealot-death',
            corpse = name .. '-corpse'
        },
        {
            type = "corpse",
            name = name .. '-corpse',
            icon = "__erm_toss__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-off-grid", "building-direction-8-way", "not-on-map" },
            selection_box = selection_box,
            selectable_in_game = false,
            dying_speed = 0.04,
            time_before_removed = defines.time.second * 5,
            subgroup = "corpses",
            order = "x" .. name .. level,
            animation = Sprites.empty_pictures(),
        }
    })
end
