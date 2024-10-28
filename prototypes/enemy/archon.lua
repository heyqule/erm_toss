--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--
require('__stdlib__/stdlib/utils/defines/time')


local ERM_UnitHelper = require('__enemyracemanager__/lib/rig/unit_helper')
local ERM_UnitTint = require('__enemyracemanager__/lib/rig/unit_tint')
local ERM_DebugHelper = require('__enemyracemanager__/lib/debug_helper')
local TossSound = require('__erm_toss__/prototypes/sound')
local AnimationDB = require('__erm_libs__/prototypes/animation_db')
local util = require('util')

local name = 'archon'


local hitpoint = 360
local max_hitpoint_multiplier = settings.startup['enemyracemanager-max-hitpoint-multipliers'].value * 3.25


-- Handles acid and poison resistance
local base_acid_resistance = 0
local incremental_acid_resistance = 90
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

-- Handles physical damages

local base_electric_damage = 1
local incremental_electric_damage = 2

-- Handles Attack Speed

local base_attack_speed = 120
local incremental_attack_speed = 60

local attack_range = 1


local base_movement_speed = 0.125
local incremental_movement_speed = 0.1

-- Misc settings
local vision_distance = ERM_UnitHelper.get_vision_distance(attack_range)

local pollution_to_join_attack = 250
local distraction_cooldown = 300

-- Animation Settings
local unit_scale = 1.3

local collision_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }
local selection_box = { { -1, -1 }, { 1, 1 } }

function ErmToss.make_archon(level)
    level = level or 1

    local attack_animation = AnimationDB.get_layered_animations('units', name, 'attack')
    local archon_animation = AnimationDB.get_single_animation('units', name,'attack_attachment')
    table.insert(attack_animation, archon_animation)

    data:extend({
        {
            type = 'unit',
            name = MOD_NAME .. '--' .. name .. '--' .. level,
            localised_name = { 'entity-name.' .. MOD_NAME .. '--' .. name, tostring(level) },
            icon = '__erm_toss_hd_assets__/graphics/entity/icons/units/' .. name .. '.png',
            icon_size = 64,
            flags = { 'placeable-enemy', 'placeable-player', 'placeable-off-grid', 'not-flammable' },
            has_belt_immunity = false,
            max_health = ERM_UnitHelper.get_health(hitpoint, hitpoint * max_hitpoint_multiplier,  level),
            order = MOD_NAME .. '--'  .. name .. '--' .. level,
            subgroup = 'enemies',
            map_color = ERM_UnitHelper.format_map_color(settings.startup['erm_toss-map-color'].value),
            shooting_cursor_size = 2,
            resistances = {
                { type = 'acid', percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance,  level) },
                { type = 'poison', percent = ERM_UnitHelper.get_resistance(base_acid_resistance, incremental_acid_resistance,  level) },
                { type = 'physical', percent = ERM_UnitHelper.get_resistance(base_physical_resistance, incremental_physical_resistance,  level) },
                { type = 'fire', percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance,  level) },
                { type = 'explosion', percent = ERM_UnitHelper.get_resistance(base_fire_resistance, incremental_fire_resistance,  level) },
                { type = 'laser', percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance,  level) },
                { type = 'electric', percent = ERM_UnitHelper.get_resistance(base_electric_resistance, incremental_electric_resistance,  level) },
                { type = 'cold', percent = ERM_UnitHelper.get_resistance(base_cold_resistance, incremental_cold_resistance,  level) }
            },
            healing_per_tick = ERM_UnitHelper.get_healing(hitpoint, max_hitpoint_multiplier,  level),
            --collision_mask = { 'player-layer' },
            collision_box = collision_box,
            selection_box = selection_box,
            sticker_box = selection_box,
            vision_distance = vision_distance,
            movement_speed = ERM_UnitHelper.get_movement_speed(base_movement_speed, incremental_movement_speed,  level),
            absorptions_to_join_attack = { pollution = ERM_UnitHelper.get_pollution_attack(pollution_to_join_attack, level)},
            distraction_cooldown = distraction_cooldown,
            ai_settings = biter_ai_settings,
            spawning_time_modifier = 2,
            light = {
                intensity = 1,
                size = 16,
                color = ERM_UnitTint.tint_archon_light()
            },
            attack_parameters = {
                type = 'projectile',
                range_mode = 'bounding-box-to-bounding-box',
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed,  level),
                cooldown_deviation = 0.1,
                damage_modifier = ERM_UnitHelper.get_damage(base_electric_damage, incremental_electric_damage,  level),
                ammo_category = 'protoss-damage',
                ammo_type = {
                    target_type = 'direction',
                    action = {
                        type = 'direct',
                        action_delivery = {
                            type = 'instant',
                            target_effects = {
                                {
                                    type = 'create-explosion',
                                    entity_name = MOD_NAME..'--archon-hit-explosion'
                                },
                                {
                                    type = 'nested-result',
                                    action = {
                                        type = 'area',
                                        force = 'not-same',
                                        radius = 3,
                                        ignore_collision_condition = true,
                                        action_delivery = {
                                            type = 'instant',
                                            target_effects = {
                                                type = 'damage',
                                                damage = { amount = 50, type = 'electric' }
                                            },
                                            apply_damage_to_trees = true
                                        }
                                    }
                                }
                            }
                        }
                    },
                },
                sound = TossSound.archon_attack(0.66),
                animation = attack_animation
            },

            distance_per_frame = 0.16,
            run_animation = AnimationDB.get_layered_animations('units', name, 'run'),
            dying_sound = TossSound.enemy_death(name, 0.75),
            dying_explosion = MOD_NAME..'--small-building-explosion',
            corpse = MOD_NAME .. '--' .. name .. '-corpse'
        },
        {
            type = 'corpse',
            name = MOD_NAME .. '--' .. name .. '-corpse',
            icon = '__erm_toss_hd_assets__/graphics/entity/icons/units/' .. name .. '.png',
            icon_size = 64,
            flags = { 'placeable-off-grid', 'building-direction-8-way', 'not-on-map' },
            selection_box = selection_box,
            selectable_in_game = false,
            dying_speed = 0.04,
            time_before_removed = defines.time.second,
            subgroup = 'corpses',
            order = MOD_NAME..'--' .. name,
            animation = util.empty_sprite(),
        },
    })
end
