---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 8/26/2022 11:52 PM
---

local Sprites = require('__stdlib__/stdlib/data/modules/sprites')
local ERMConfig = require('__enemyracemanager__/lib/global_config')

--- Basic Attack #1
local create_blood_cloud_projectile = function(tier)
    return     {
        type = "projectile",
        name = MOD_NAME.."/blood-cloud-projectile-t"..tier,
        flags = { "not-on-map" },
        acceleration = 0.01,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "blood-cloud-explosion",
                        trigger_created_entity = false
                    },
                    {
                        type = "create-smoke",
                        show_in_tooltip = true,
                        entity_name = MOD_NAME .. "/blood-cloud-t" .. tier
                    },
                }
            }
        },
        animation = {
            filename = "__erm_zerg__/graphics/entity/projectiles/spores_2_red.png",
            priority = "extra-high",
            width = 24,
            height = 24,
            frame_count = 4,
            animation_speed = 0.2,
            scale = 2
        }
    }
end

--- Basic Attack #2
local create_acid_cloud_projectile = function(tier)
    return   {
        type = "projectile",
        name = MOD_NAME.."/acid-cloud-projectile-t"..tier,
        flags = { "not-on-map" },
        acceleration = 0.01,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "acid-cloud-explosion",
                        trigger_created_entity = false
                    },
                    {
                        type = "create-smoke",
                        show_in_tooltip = true,
                        entity_name = MOD_NAME .. "/acid-cloud-t" .. tier
                    },
                }
            }
        },
        animation = {
            filename = "__erm_zerg__/graphics/entity/projectiles/spores_2.png",
            priority = "extra-high",
            width = 24,
            height = 24,
            frame_count = 4,
            animation_speed = 0.2,
            scale = 2
        }
    }
end

--- Basic Attack #3
local create_blood_fire_projectile = function(tier)
    return   {
        type = "projectile",
        name = MOD_NAME.."/blood-fire-projectile-t"..tier,
        flags = { "not-on-map" },
        acceleration = 0.01,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "erm-small-explosion-blood-1",
                        trigger_created_entity = false
                    },
                    {
                        type = "nested-result",
                        action = {
                            type = "area",
                            force = 'not-same',
                            radius = 2,
                            ignore_collision_condition = true,
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    type = "damage",
                                    damage = { amount = 300 * tier, type = "acid" },
                                }
                            }
                        }
                    }
                }
            }
        },
        animation = {
            filename = "__erm_zerg__/graphics/entity/projectiles/spores_2.png",
            priority = "extra-high",
            width = 24,
            height = 24,
            frame_count = 4,
            animation_speed = 0.2,
            scale = 2
        }
    }
end

local create_damage_cloud = function (name, tier, target_effects, radius, duration, cooldown, attack_flyer)
    radius = radius or 2
    duration = duration or 120
    attack_flyer = attack_flyer or true
    cooldown = cooldown or 15
    return  {
        name = MOD_NAME.."/"..name.."-t"..tier,
        type = "smoke-with-trigger",
        flags = { "not-on-map" },
        show_when_smoke_off = true,
        particle_count = 1,
        render_layer = "explosion",

        affected_by_wind = false,
        duration = duration,
        cyclic = true,

        animation = Sprites.empty_picture(),
        action = {
            type = "direct",
            ignore_collision_condition = true,
            force = 'not-same',
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "nested-result",
                    action = {
                        type = "area",
                        force = 'not-same',
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

for i = 1, ERMConfig.BOSS_MAX_TIERS do
    data:extend({
        create_blood_cloud_projectile(i),
        create_damage_cloud('blood-cloud', i,{
                type = "damage",
                --- process 4 ticks per second
                damage = { amount = 100 * i, type = "acid" },
                apply_damage_to_trees = true
            },  5,60),
        create_acid_cloud_projectile(i),
        create_damage_cloud('acid-cloud', i,{{
                type = "damage",
                --- process 4 ticks per second
                damage = { amount = 50 * i, type = "acid" },
            },{
                type = "create-sticker",
                sticker = "5-075-slowdown-sticker",
                show_in_tooltip = true,
            }}, 5,60),
        create_blood_fire_projectile(i),
    })
end
