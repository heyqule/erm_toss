---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 01/09/2020 6:40 PM
---
local Sprites = require('__stdlib__/stdlib/data/modules/sprites')

local ERM_WeaponRig = require('__enemyracemanager__/lib/rig/weapon')

local smoke_animations = require("__base__/prototypes/entity/smoke-animations")

local smoke_fast_animation = smoke_animations.trivial_smoke_fast

require('util')

local scout_rocket = ERM_WeaponRig.standardize_rocket_damage(
        util.table.deepcopy(data.raw['projectile']['rocket']),
        'scout-rocket'
)
table.insert(scout_rocket['action']['action_delivery']['target_effects'],  {
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
scout_rocket['turn_speed'] = 1
scout_rocket['turning_speed_increases_exponentially_with_projectile_speed'] = false
scout_rocket['smoke'][1]['name'] = "scout-smoke-fast"
scout_rocket['smoke'][1]['frequency'] = 1 / 5

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
        name = "dragoon-projectile",
        flags = { "not-on-map" },
        acceleration = 0.005,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "dragoon-explosion"
                    },
                    {
                        type = "damage",
                        damage = { amount = 15, type = "electric" },
                        apply_damage_to_trees = true
                    }
                }
            }
        },
        animation = {
            layers = {
                {
                    filename = "__erm_toss__/graphics/entity/projectiles/dragoon/dragoon-ball.png",
                    frame_count = 5,
                    width = 32,
                    height = 32,
                    scale = 1.5,
                    priority = "high",
                    draw_as_glow = true,
                },
            }
        }
    },
    {
        type = "projectile",
        name = "stasis-projectile",
        flags = { "not-on-map" },
        acceleration = 0.005,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = "stasis-explosion"
                    },
                    {
                        type = "nested-result",
                        action = {
                            type = "area",
                            force = 'not-same',
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
        animation = {
            layers = {
                {
                    filename = "__erm_toss__/graphics/entity/projectiles/dragoon/dragoon-ball.png",
                    frame_count = 5,
                    width = 32,
                    height = 32,
                    scale = 1.5,
                    priority = "high",
                    draw_as_glow = true,
                },
            }
        }
    },
    {
        type = "projectile",
        name = "interceptor-projectile",
        flags = { "not-on-map" },
        acceleration = 0.005,
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
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
                                    damage = { amount = 40, type = "explosion" }
                                },
                                apply_damage_to_trees = true
                            }
                        }
                    },
                    {
                        type = "create-entity",
                        entity_name = "medium-explosion"
                    },
                }
            }
        },
        animation = {
            layers = {
                {
                    filename = "__erm_toss__/graphics/entity/units/interceptor/interceptor-run.png",
                    frame_count = 1,
                    width = 32,
                    height = 32,
                    scale = 1,
                    priority = "high",
                    direction_count = 16,
                },
            }
        }
    },
    --- Explosions
    {
        type = "explosion",
        name = "dragoon-explosion",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_toss__/graphics/entity/projectiles/dragoon/dragoon-hit-effect.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                frame_count = 10,
                animation_speed = 0.5,
                draw_as_glow = true,
            }
        }
    },
    {
        type = "explosion",
        name = "corsair-explosion",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_toss__/graphics/entity/projectiles/corsair-splash.png",
                priority = "extra-high",
                width = 64,
                height = 64,
                frame_count = 7,
                animation_speed = 0.5,
                draw_as_glow = true,
                tint = { 1, 1, 1 }
            }
        }
    },
    {
        type = "explosion",
        name = "stasis-explosion",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_toss__/graphics/entity/projectiles/stasis/stasis.png",
                priority = "extra-high",
                width = 128,
                height = 128,
                frame_count = 13,
                animation_speed = 0.5,
                scale = 2.5,
                draw_as_glow = true,
            }
        }
    },
    {
        type = "explosion",
        name = "psystorm-explosion",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_toss__/graphics/entity/projectiles/psystorm/psystorm.png",
                priority = "extra-high",
                width = 224,
                height = 224,
                frame_count = 14,
                animation_speed = 0.2,
                scale = 2,
                draw_as_glow = true
            }
        }
    },
    --- Death Explosion
    {
        type = "explosion",
        name = "archon-hit-explosion",
        flags = { "not-on-map" },
        animations = {
            {
                filename = "__erm_toss__/graphics/entity/projectiles/archon_attack/archon-hit-effect.png",
                priority = "extra-high",
                width = 80,
                height = 80,
                frame_count = 6,
                animation_speed = 0.5,
                scale = 1.5,
                draw_as_glow = true
            }
        }
    },
    {
        type = "explosion",
        name = "protoss-small-air-death",
        flags = { "not-on-map" },
        animations = {
            filename = "__erm_toss__/graphics/entity/units/air-death/air-death.png",
            width = 220,
            height = 200,
            frame_count = 15,
            direction_count = 1,
            axially_symmetrical = false,
            scale = 1.5,
            animation_speed = 0.5,
            draw_as_glow = true
        }
    },
    {
        type = "explosion",
        name = "protoss-large-air-death",
        flags = { "not-on-map" },
        animations = {
            filename = "__erm_toss__/graphics/entity/units/air-death/air-death.png",
            width = 220,
            height = 200,
            frame_count = 15,
            direction_count = 1,
            axially_symmetrical = false,
            scale = 2.5,
            animation_speed = 0.5,
            draw_as_glow = true
        }
    },
    {
        type = "explosion",
        name = "protoss-zealot-death",
        flags = { "not-on-map" },
        animations = {
            filename = "__erm_toss__/graphics/entity/units/zealot/zealot-death.png",
            width = 128,
            height = 128,
            frame_count = 7,
            direction_count = 1,
            axially_symmetrical = false,
            scale = 1,
            animation_speed = 0.2,
            draw_as_glow = true
        }
    },
    {
        type = "explosion",
        name = "protoss-templar-death",
        flags = { "not-on-map" },
        animations = {
            filename = "__erm_toss__/graphics/entity/units/templar/templar-death.png",
            width = 128,
            height = 128,
            frame_count = 6,
            direction_count = 1,
            axially_symmetrical = false,
            scale = 1,
            animation_speed = 0.2,
            draw_as_glow = true
        },
    },
    {
        type = "explosion",
        name = "protoss-recall-80",
        flags = { "not-on-map" },
        animations = {
            filename = "__erm_toss__/graphics/entity/projectiles/recall-80.png",
            width = 100,
            height = 100,
            frame_count = 21,
            direction_count = 1,
            axially_symmetrical = false,
            scale = 2,
            frame_sequence = {1,2,3,4,5,6,7,8,9,10,11,10,9,8,7,6,5,4,3,2,1},
            animation_speed = 0.2,
            draw_as_glow = true
        },
    },
    {
        type = "explosion",
        name = "protoss-recall",
        flags = { "not-on-map" },
        animations = {
            filename = "__erm_toss__/graphics/entity/projectiles/recall.png",
            width = 100,
            height = 100,
            frame_count = 21,
            direction_count = 1,
            axially_symmetrical = false,
            scale = 2,
            frame_sequence = {1,2,3,4,5,6,7,8,9,10,11,10,9,8,7,6,5,4,3,2,1},
            animation_speed = 0.2,
            draw_as_glow = true
        },
    },
    {
        type = "explosion",
        name = "protoss-disrupt-80",
        flags = { "not-on-map" },
        animations = {
            filename = "__erm_toss__/graphics/entity/projectiles/disrupt-80.png",
            width = 160,
            height = 160,
            frame_count = 21,
            direction_count = 1,
            axially_symmetrical = false,
            scale = 1.5,
            frame_sequence = {1,2,3,4,5,6,7,8,9,10,11,10,9,8,7,6,5,4,3,2,1},
            animation_speed = 0.2,
            draw_as_glow = true
        },
    },
    {
        type = "explosion",
        name = "protoss-disrupt",
        flags = { "not-on-map" },
        animations = {
            filename = "__erm_toss__/graphics/entity/projectiles/disrupt.png",
            width = 160,
            height = 160,
            frame_count = 21,
            direction_count = 1,
            axially_symmetrical = false,
            scale = 1.5,
            frame_sequence = {1,2,3,4,5,6,7,8,9,10,11,10,9,8,7,6,5,4,3,2,1},
            animation_speed = 0.2,
            draw_as_glow = true
        },
    },
    --- Stickers
    {
        type = "sticker",
        name = "5-067-slowdown-sticker",
        flags = {},
        animation = Sprites.empty_pictures(),
        duration_in_ticks = 5 * 60,
        target_movement_modifier = 0.67,
        vehicle_speed_modifier = 0.67,
    },
    {
        type = "sticker",
        name = "3-033-slowdown-sticker",
        flags = {},
        animation = Sprites.empty_pictures(),
        duration_in_ticks = 3 * 60,
        target_movement_modifier = 0.33,
        vehicle_speed_modifier = 0.33,
    },
    {
        type = "sticker",
        name = "5-010-slowdown-sticker",
        flags = {},
        animation = Sprites.empty_pictures(),
        duration_in_ticks = 5 * 60,
        target_movement_modifier = 0.1,
        vehicle_speed_modifier = 0.1,
    }
})
