--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--
require('__stdlib__/stdlib/utils/defines/time')
local Sprites = require('__stdlib__/stdlib/data/modules/sprites')

local ERM_UnitHelper = require('__enemyracemanager__/lib/rig/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/rig/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local ERM_Config = require('__enemyracemanager__/lib/global_config')
local ERMDataHelper = require('__enemyracemanager__/lib/rig/data_helper')
local TossSound = require('__erm_toss__/prototypes/sound')
local name = 'carrier'

-- Hitpoints

local hitpoint = 450
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 2


-- Handles acid and poison resistance
local base_acid_resistance = 0
local incremental_acid_resistance = 85
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 95
-- Handles fire and explosive resistance
local base_fire_resistance = 0
local incremental_fire_resistance = 90
-- Handles laser and electric resistance
local base_electric_resistance = 20
local incremental_electric_resistance = 70
-- Handles cold resistance
local base_cold_resistance = 20
local incremental_cold_resistance = 70

-- Handles damages

local base_electric_damage = 1
local incremental_electric_damage = 3

-- Handles Attack Speed

local base_attack_speed = 720 -- 12s
local incremental_attack_speed = 240 -- 8s


local base_movement_speed = 0.15
local incremental_movement_speed = 0.125

-- Misc Settings
local pollution_to_join_attack = 350
local distraction_cooldown = 300

-- Animation Settings
local unit_scale = 1.5
local collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
local selection_box = { { -1.5, -1.25 }, { 1.5, 1.25 } }

function ErmToss.make_carrier(level)
    level = level or 1
    local attack_range = ERM_UnitHelper.get_attack_range(level)
    local vision_distance = ERM_UnitHelper.get_vision_distance(attack_range)

    data:extend({
        {
            type = "unit",
            name = MOD_NAME .. '/' .. name .. '/' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '/' .. name, level },
            icon = "__erm_toss__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "not-flammable" },
            has_belt_immunity = true,
            max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_multiplier,  level),
            order = MOD_NAME .. '/'  .. name .. '/' .. level,
            subgroup = "erm-flying-enemies",
            map_color = ERM_UnitHelper.format_map_color(settings.startup['erm_toss-map-color'].value),
            shooting_cursor_size = 2,
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
            healing_per_tick = ERM_UnitHelper.get_healing(hitpoint, max_hitpoint_multiplier,  level),
            collision_mask = ERMDataHelper.getFlyingCollisionMask(),
            collision_box = collision_box,
            selection_box = selection_box,
            sticker_box = selection_box,
            vision_distance = vision_distance,
            movement_speed = ERM_UnitHelper.get_movement_speed(base_movement_speed, incremental_movement_speed,  level),
            pollution_to_join_attack = ERM_UnitHelper.get_pollution_attack(pollution_to_join_attack, level),
            distraction_cooldown = distraction_cooldown,
            ai_settings = biter_ai_settings,
            spawning_time_modifier = 2,
            attack_parameters = {
                type = "projectile",
                range_mode = "bounding-box-to-bounding-box",
                ammo_category = 'protoss-damage',
                range = attack_range,
                min_attack_distance = attack_range - 4,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed,  level),
                cooldown_deviation = 0.1,
                warm_up = 120,
                damage_modifier = ERM_UnitHelper.get_damage(base_electric_damage, incremental_electric_damage,  level),
                ammo_type = {
                    category = "protoss-damage",
                    target_type = "direction",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = 'instant',
                            source_effects = {
                                type = "script",
                                effect_id = CARRIER_ATTACK,
                            }
                        }
                    }
                },
                sound = TossSound.interceptor_attack(0.5),
                animation = {
                    layers = {
                        {
                            filename = "__erm_toss__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                            width = 128,
                            height = 128,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 16,
                            scale = unit_scale,
                            animation_speed = 1,
                        },
                        {
                            filename = "__erm_toss__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                            width = 128,
                            height = 128,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 16,
                            scale = unit_scale,
                            animation_speed = 1,
                            draw_as_shadow = true,
                            shift = { 6, 0 }
                        },
                        {
                            filename = "__erm_toss__/graphics/entity/units/" .. name .. "/" .. name .. "-effect.png",
                            width = 76,
                            height = 76,
                            frame_count = 1,
                            axially_symmetrical = false,
                            direction_count = 16,
                            scale = unit_scale,
                            animation_speed = 1,
                            draw_as_glow = true,
                            blend_mode = "additive",
                            tint = ERM_UnitTint.tint_blue_flame_burner(),
                        }
                    }
                }
            },

            render_layer = "wires-above",
            distance_per_frame = 0.5,
            run_animation = {
                layers = {
                    {
                        filename = "__erm_toss__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        animation_speed = 1,
                    },
                    {
                        filename = "__erm_toss__/graphics/entity/units/" .. name .. "/" .. name .. "-run.png",
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        animation_speed = 1,
                        draw_as_shadow = true,
                        shift = { 6, 0 }
                    },
                    {
                        filename = "__erm_toss__/graphics/entity/units/" .. name .. "/" .. name .. "-effect.png",
                        width = 128,
                        height = 128,
                        frame_count = 1,
                        axially_symmetrical = false,
                        direction_count = 16,
                        scale = unit_scale,
                        animation_speed = 1,
                        draw_as_glow = true,
                        blend_mode = "additive",
                        tint = ERM_UnitTint.tint_blue_flame_burner(),
                    }
                }
            },
            dying_sound = TossSound.enemy_death(name, 0.75),
            dying_explosion = MOD_NAME..'/large-air-death',
            corpse = MOD_NAME .. '/' .. name .. '-corpse'
        },
        {
            type = "corpse",
            name = MOD_NAME .. '/' .. name .. '-corpse',
            icon = "__erm_toss__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-off-grid", "building-direction-8-way", "not-on-map" },
            selection_box = selection_box,
            selectable_in_game = false,
            dying_speed = 0.04,
            time_before_removed = defines.time.second,
            subgroup = "corpses",
            order = MOD_NAME .. "/" .. name .. level,
            animation = Sprites.empty_pictures(),
        }
    })
end
