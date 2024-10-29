---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 01/09/2020 6:40 PM
---
require("__stdlib__/stdlib/utils/defines/time")

local ERM_WeaponRig = require("__enemyracemanager__/lib/rig/weapon")
local ERMDataHelper = require("__enemyracemanager__/lib/rig/data_helper")

local AnimationDB = require("__erm_toss_hd_assets__/animation_db")

local smoke_animations = require("__base__/prototypes/entity/smoke-animations")


local smoke_fast_animation = smoke_animations.trivial_smoke_fast

require("util")

local scout_rocket = ERM_WeaponRig.standardize_rocket_damage(
        util.table.deepcopy(data.raw["projectile"]["rocket"]),
        MOD_NAME.."--scout-rocket"
)
table.insert(scout_rocket["action"]["action_delivery"]["target_effects"],  {
    type = "nested-result",
    action = {
        type = "area",
        force = "not-same",
        radius = 1,
        ignore_collision_condition = true,
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "damage",
                    damage = { amount = 5, type = "explosion" },
                    apply_damage_to_trees = true,
                },
            }
        }
    }
})
scout_rocket["animation"] = AnimationDB.get_layered_animations("projectiles","scout_rocket","projectile")
scout_rocket["turn_speed"] = 1
scout_rocket["turning_speed_increases_exponentially_with_projectile_speed"] = false
scout_rocket["smoke"][1]["name"] = "scout-smoke-fast"
scout_rocket["smoke"][1]["frequency"] = 1 / 5

data:extend({
    {
        type = "trivial-smoke",
        name = "scout-smoke-fast",
        animation = smoke_fast_animation(),
        duration = 60,
        fade_away_duration = 60,
        color =  {r = 65, g = 150, b = 240, a = 0.5}
    },
    --- Projectiles
    scout_rocket,
    {
        type = "projectile",
        name = MOD_NAME.."--dragoon-projectile",
        flags = { "not-on-map" },
        acceleration = 0.005,

        direction_only = true,
        collision_box = {{-0.5,-0.5},{0.5,0.5}},
        force_condition = "not-same",
        hit_collision_mask =  { layers = {player = true, train = true, transport_belt = true,  [ERMDataHelper.getFlyingLayerName()] = true}},
        hit_at_collision_position = true,

        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = MOD_NAME.."--dragoon-explosion"
                    },
                    {
                        type = "damage",
                        damage = { amount = 15, type = "electric" },
                        apply_damage_to_trees = true
                    }
                }
            }
        },
        animation = AnimationDB.get_layered_animations("projectiles","dragoon","projectile")
    },
    {
        type = "projectile",
        name = MOD_NAME.."--interceptor-laser",
        flags = { "not-on-map" },
        acceleration = 0.005,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "damage",
                        damage = { amount = 5, type = "electric" },
                        apply_damage_to_trees = true
                    }
                }
            }
        },
        animation = AnimationDB.get_layered_animations("projectiles","interceptor_laser","projectile")
    },
    {
        type = "projectile",
        name = MOD_NAME.."--stasis-projectile",
        flags = { "not-on-map" },
        acceleration = 0.005,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = MOD_NAME.."--stasis-explosion"
                    },
                    {
                        type = "nested-result",
                        action = {
                            type = "area",
                            force = "not-same",
                            radius = 4,
                            ignore_collision_condition = true,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    type = "damage",
                                    damage = { amount = 20, type = "cold" }
                                }
                            }
                        }
                    }
                }
            }
        },
        animation = AnimationDB.get_layered_animations("projectiles","stasis","projectile")
    },
    --- Explosions
    {
        type = "explosion",
        name = MOD_NAME.."--dragoon-explosion",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("projectiles","dragoon","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--corsair-explosion",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("projectiles","corsair","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--stasis-explosion",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("projectiles","stasis","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--psystorm-explosion",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("projectiles","psystorm","explosion")
    },
    --- Death Explosion
    {
        type = "explosion",
        name = MOD_NAME.."--archon-hit-explosion",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("projectiles","archon_hit","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--small-air-death",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("death","small_air","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--large-air-death",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("death","large_building","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--zealot-death",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("death","zealot","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--templar-death",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("death","templar","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--recall-80",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("projectiles","recall_80","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--recall",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("projectiles","recall","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--disrupt-80",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("projectiles","disrupt_80","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--disrupt",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("projectiles","disrupt","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--darkarchon-feedback",
        flags = { "not-on-map" },
        animations = AnimationDB.get_layered_animations("projectiles","darkarchon_feedback","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--scarab-explosion",
        flags = {"not-on-map"},
        animations = AnimationDB.get_layered_animations("projectiles","scarab","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--shield-battery-explosion",
        flags = {"not-on-map"},
        animations = AnimationDB.get_layered_animations("projectiles","shield_battery","explosion")
    },
    {
        type = "explosion",
        name = MOD_NAME.."--demo-darkarchon-maelstrom",
        flags = {"not-on-map"},
        animations =         {
            filename = "__erm_toss__/graphics/entity/projectiles/maelstrom.png",
            width = 128,
            height = 128,
            frame_count = 25,
            animation_speed = 0.5,
            scale = 1,
            draw_as_glow = true
        }
    },
    {
        type = "sticker",
        name = MOD_NAME.."--darkarchon-maelstrom",
        flags = { "not-on-map" },
        duration_in_ticks = 2 * defines.time.second,
        damage_interval = defines.time.second / 4,
        damage_per_tick = { amount = 10, type = "explosion" },
        single_particle = true,
        fire_spread_radius = 0,
        render_layer = "explosion",
        animation =AnimationDB.get_layered_animations("projectiles","darkarchon_maelstrom","explosion")
    },
    --- Stickers
    {
        type = "sticker",
        name = "5-067-slowdown-sticker",
        flags = {"not-on-map" },
        animation = util.empty_sprite(),
        duration_in_ticks = 5 * 60,
        target_movement_modifier = 0.67,
        vehicle_speed_modifier = 0.67,
    },
    {
        type = "sticker",
        name = "5-033-slowdown-sticker",
        flags = {"not-on-map" },
        animation = util.empty_sprite(),
        duration_in_ticks = 5 * 60,
        target_movement_modifier = 0.33,
        vehicle_speed_modifier = 0.33,
    },
    {
        type = "sticker",
        name = "5-010-slowdown-sticker",
        flags = {"not-on-map" },
        animation = util.empty_sprite(),
        duration_in_ticks = 5 * 60,
        target_movement_modifier = 0.1,
        vehicle_speed_modifier = 0.1,
    }
})
