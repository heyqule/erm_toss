--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/15/2020
-- Time: 9:39 PM
-- To change this template use File | Settings | File Templates.
--



local ERM_UnitHelper = require("__enemyracemanager__/lib/rig/unit_helper")
local ERM_UnitTint = require("__enemyracemanager__/lib/rig/unit_tint")
local ERM_DebugHelper = require("__enemyracemanager__/lib/debug_helper")
local GlobalConfig = require("__enemyracemanager__/lib/global_config")
local ERMDataHelper = require("__enemyracemanager__/lib/rig/data_helper")
local TossSound = require("__erm_toss_hd_assets__/sound")
local biter_ai_settings = require ("__base__.prototypes.entity.biter-ai-settings")
local AnimationDB = require("__erm_libs__/prototypes/animation_db")
local name = "shuttle"


-- Hitpoints

local hitpoint = 200
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value * 1.65


-- Handles acid and poison resistance
local base_acid_resistance = 0
local incremental_acid_resistance = 75
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 85
-- Handles fire and explosive resistance
local base_fire_resistance = 0
local incremental_fire_resistance = 80
-- Handles laser and electric resistance
local base_electric_resistance = 20
local incremental_electric_resistance = 55
-- Handles cold resistance
local base_cold_resistance = 20
local incremental_cold_resistance = 60

-- Handles damages
--
--local base_electric_damage = 20
--local incremental_electric_damage = 50

-- Handles Attack Speed

local base_attack_speed = 3600
local incremental_attack_speed = 900


local base_movement_speed = 0.3
local incremental_movement_speed = 0.2

-- Misc Settings
local pollution_to_join_attack = 120
local distraction_cooldown = 300


local collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
local selection_box = { { -0.75, -0.75 }, { 0.75, 0.75 } }

function ErmToss.make_shuttle(level)
    level = level or 1
    local attack_range = ERM_UnitHelper.get_attack_range(level,0.5)
    local vision_distance = ERM_UnitHelper.get_vision_distance(attack_range)
    data:extend({
        {
            type = "unit",
            name = MOD_NAME .. "--" .. name .. "--" .. level,
            localised_name = { "entity-name." .. MOD_NAME .. "--" .. name, GlobalConfig.QUALITY_MAPPING[level] },
            icon = "__erm_toss_hd_assets__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-enemy", "placeable-player", "placeable-off-grid", "not-flammable" },
            has_belt_immunity = true,
            max_health = ERM_UnitHelper.get_health(hitpoint, max_hitpoint_multiplier,  level),
            order = MOD_NAME .. "--unit--" .. name .. "--".. level,
            subgroup = "erm-dropship-enemies",
            map_color = ERM_UnitHelper.format_map_color(settings.startup["enemy_erm_toss-map-color"].value),
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
            absorptions_to_join_attack = { pollution = ERM_UnitHelper.get_pollution_attack(pollution_to_join_attack, level)},
            distraction_cooldown = distraction_cooldown,
            ai_settings = biter_ai_settings,
            spawning_time_modifier = 1.5,
            attack_parameters = {
                type = "projectile",
                range_mode = "bounding-box-to-bounding-box",
                ammo_category = "erm-protoss-damage",
                range = attack_range,
                cooldown = ERM_UnitHelper.get_attack_speed(base_attack_speed, incremental_attack_speed,  level),
                cooldown_deviation = 0.1,
                warmup = 12,
                ammo_type = {
                    category = "erm-protoss-damage",
                    target_type = "direction",
                    action = {
                        type = "direct",
                        action_delivery = {
                            type = "instant",
                            source_effects = {
                                type = "script",
                                effect_id = SHUTTLE_ATTACK,
                            }
                        }
                    }
                },
                sound = TossSound.shuttle_drop(0.9),
                animation = AnimationDB.get_layered_animations("units", name, "run")
            },

            render_layer = "wires-above",
            distance_per_frame = 0.5,
            run_animation = AnimationDB.get_layered_animations("units", name, "run"),
            dying_sound = TossSound.enemy_death("shuttle", 1),
            dying_explosion = "protoss--small-air-death",
            corpse = name .. "-corpse"
        },
        {
            type = "corpse",
            name = name .. "-corpse",
            icon = "__erm_toss_hd_assets__/graphics/entity/icons/units/" .. name .. ".png",
            icon_size = 64,
            flags = { "placeable-off-grid", "building-direction-8-way", "not-on-map" },
            selection_box = selection_box,
            selectable_in_game = false,
            dying_speed = 0.04,
            time_before_removed = second,
            subgroup = "corpses",
            name = name .. "-corpse",
            animation = util.empty_sprite(),
        }
    })
end
