---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 8/26/2022 11:52 PM
---
require("__erm_toss__/global")
util.empty_sprite()
local ERMConfig = require("__enemyracemanager__/lib/global_config")
local ERMDataHelper = require("__enemyracemanager__/lib/rig/data_helper")
local AnimationDB = require("__erm_libs__/prototypes/animation_db")

local boss_difficulty = settings.startup["enemyracemanager-boss-difficulty"].value
local damage_multiplier = {
    [BOSS_NORMAL] = 1,
    [BOSS_HARD] = 1.2,
    [BOSS_GODLIKE] = 1.5
}

local get_damage = function(init_dmg, tier ,multiplier)
    return init_dmg * (1 + tier * multiplier - multiplier) * damage_multiplier[boss_difficulty]
end

--- Basic Attack #1
local create_psystorm_projectile = function(tier)
    return     {
        type = "projectile",
        name = MOD_NAME.."--psystorm-projectile-t"..tier,
        flags = { "not-on-map" },
        acceleration = 0,

        collision_box = {{-0.5,-0.5},{0.5, 0.5}},
        direction_only = true,
        force_condition = "enemy",
        hit_collision_mask =  { layers = {player = true, train = true,   [ERMDataHelper.getFlyingLayerName()] = true}},
        final_action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "protoss--psystorm-explosion",
                        trigger_created_entity = false
                    },
                    {
                        type = "create-smoke",
                        show_in_tooltip = true,
                        entity_name = MOD_NAME.."--psystorm-t" .. tier
                    },
                }
            }
        },
        animation = AnimationDB.get_layered_animations("projectiles","stasis","projectile")
    }
end

--- Basic Attack #2
local create_stasis_projectile = function(tier)
    return   {
        type = "projectile",
        name = MOD_NAME.."--stasis-projectile-t"..tier,
        flags = { "not-on-map" },
        acceleration = 0,

        collision_box = {{-0.5,-0.5},{0.5, 0.5}},
        direction_only = true,
        force_condition = "enemy",
        hit_collision_mask =  { layers = {player = true, train = true,   [ERMDataHelper.getFlyingLayerName()] = true}},
        final_action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = MOD_NAME.."--stasis-explosion",
                        trigger_created_entity = false
                    },
                    {
                        type = "create-smoke",
                        show_in_tooltip = true,
                        entity_name = MOD_NAME.."--stasis-t" .. tier
                    },
                }
            }
        },
        AnimationDB.get_layered_animations("projectiles","stasis","projectile")
    }
end

--- Basic Attack #3
local create_cold_fire_projectile = function(tier)
    return   {
        type = "projectile",
        name = MOD_NAME.."--stasis-projectile-t"..tier,
        flags = { "not-on-map" },
        acceleration = 0,

        collision_box = {{-0.5,-0.5},{0.5, 0.5}},
        direction_only = true,
        force_condition = "enemy",
        hit_collision_mask =  { layers = {player = true, train = true,   [ERMDataHelper.getFlyingLayerName()] = true}},
        final_action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    --@TODO new explosion
                    --{
                    --    type = "create-entity",
                    --    entity_name = "erm-small-explosion-cold-1",
                    --    trigger_created_entity = false
                    --},
                    {
                        type = "nested-result",
                        action = {
                            type = "area",
                            force = "not-same",
                            radius = 2,
                            ignore_collision_condition = true,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    type = "damage",
                                    damage = { amount = 400 * tier, type = "cold" },
                                }
                            }
                        }
                    }
                }
            }
        },
        AnimationDB.get_layered_animations("projectiles","stasis","projectile")
    }
end

local create_damage_cloud = function (name, tier, target_effects, radius, duration, cooldown)
    radius = radius or 2
    duration = duration or 120
    cooldown = cooldown or 15
    return  {
        name = MOD_NAME.."--"..name.."-t"..tier,
        type = "smoke-with-trigger",
        flags = { "not-on-map" },
        show_when_smoke_off = true,
        particle_count = 1,
        render_layer = "explosion",

        affected_by_wind = false,
        duration = duration,
        cyclic = true,

        animation = util.empty_sprite(),
        action = {
            type = "direct",
            ignore_collision_condition = true,
            force = "not-same",
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "nested-result",
                    action = {
                        type = "area",
                        force = "not-same",
                        radius = radius,
                        ignore_collision_condition = true,
                        action_delivery = {
                            type = "instant",
                            target_effects = target_effects
                        }
                    }
                }
            }
        },
        action_cooldown = cooldown
    }
end

-- Advanced Attacks
local create_cold_star_projectile = function(tier)
    return   {
        type = "projectile",
        name = MOD_NAME.."--stasis-projectile-t"..tier,
        flags = { "not-on-map" },
        acceleration = 0,

        collision_box = {{-0.5,-0.5},{0.5, 0.5}},
        direction_only = true,
        force_condition = "enemy",
        hit_collision_mask =  { layers = {player = true, train = true,   [ERMDataHelper.getFlyingLayerName()] = true}},
        final_action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    --@TODO new explosion
                    --{
                    --    type = "create-entity",
                    --    entity_name = "erm-circular-effect-cold-1",
                    --    trigger_created_entity = false
                    --},
                    {
                        type = "nested-result",
                        action = {
                            type = "area",
                            force = "not-same",
                            radius = 5,
                            ignore_collision_condition = true,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    type = "damage",
                                    damage = { amount = 1000 * (1 + tier * 0.5 - 0.5) , type = "cold" },
                                }
                            }
                        }
                    }
                }
            }
        },
        animation = AnimationDB.get_layered_animations("projectiles","stasis","projectile")
    }
end

-- Super Attacks
local create_recall_projectile = function(tier, script_attack)
    return   {
        type = "projectile",
        name = MOD_NAME.."--recall-"..script_attack.."-projectile-t"..tier,
        flags = { "not-on-map" },
        acceleration = 0,

        collision_box = {{-1,-1},{1, 1}},
        direction_only = true,
        force_condition = "enemy",
        hit_collision_mask =  { layers = {player = true, train = true,   [ERMDataHelper.getFlyingLayerName()] = true}},
        final_action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "protoss--recall",
                        trigger_created_entity = false
                    },
                    {
                        type = "create-smoke",
                        show_in_tooltip = true,
                        entity_name = MOD_NAME.."--recall-cloud-t" .. tier
                    },
                    {
                        type = "script",
                        effect_id = script_attack,
                    }
                }
            }
        },
        animation = AnimationDB.get_layered_animations("projectiles","stasis","projectile")
    }
end


for i = 1, ERMConfig.BOSS_MAX_TIERS do
    data:extend({
        create_psystorm_projectile(i),
        create_damage_cloud("psystorm", i,{
            type = "damage",
            --- process 4 ticks per second
            damage = { amount = 200 * (1 + i * 0.5 - 0.5), type = "electric" },
            apply_damage_to_trees = true
        },  5,120),
        create_stasis_projectile(i),
        create_damage_cloud("stasis", i,{{
                                                 type = "damage",
                                                 --- process 4 ticks per second
                                                 damage = { amount = 100 * (1 + i * 0.25 - 0.25), type = "electric" },
                                                 apply_damage_to_trees = false
                                             },{
                                                 type = "create-sticker",
                                                 sticker = "5-075-slowdown-sticker",
                                                 show_in_tooltip = true,
                                             }}, 5,60),
        create_cold_fire_projectile(i),
        create_cold_star_projectile(i),
        create_recall_projectile(i, BOSS_SPAWN_ATTACK),
        create_recall_projectile(i, UNITS_SPAWN_ATTACK),
        create_damage_cloud("recall-cloud", i,{{
            type = "damage",
            --- process 4 ticks per second
            damage = { amount = 200 * (1 + i * 0.75 - 0.75), type = "electric" },
            apply_damage_to_trees = true
        }},  8,120),
    })
end
