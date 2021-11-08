---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/21/2020 7:32 PM
---
require('__base__/prototypes/entity/spawner-animation')

data:extend({
    {
        type = "corpse",
        name = "toss-small-base-corpse",
        flags = { "placeable-neutral", "not-on-map" },
        icon = "__erm_toss__/graphics/entity/icons/buildings/advisor.png",
        icon_size = 64,
        collision_box = { { -2, -2 }, { 2, 2 } },
        selection_box = { { -2, -2 }, { 2, 2 } },
        selectable_in_game = false,
        dying_speed = 0.04,
        time_before_removed = defines.time.minute * settings.startup["enemyracemanager-enemy-corpse-time"].value,
        subgroup = "corpses",
        order = "c[corpse]-c[small-toss-base-corpse]",
        final_render_layer = "remnants",
        animation = {
            {
                filename = "__erm_toss__/graphics/entity/buildings/small_rubble.png",
                variation_count = 1,
                width = 96,
                height = 96,
                frame_count = 1,
                direction_count = 1,
                scale = 2
            }
        },
        ground_path = spawner_integration()
    },
    {
        type = "corpse",
        name = "toss-large-base-corpse",
        flags = { "placeable-neutral",  "not-on-map" },
        icon = "__erm_toss__/graphics/entity/icons/buildings/advisor.png",
        icon_size = 64,
        collision_box = { { -2, -2 }, { 2, 2 } },
        selection_box = { { -2, -2 }, { 2, 2 } },
        selectable_in_game = false,
        dying_speed = 0.04,
        time_before_removed = defines.time.minute * settings.startup["enemyracemanager-enemy-corpse-time"].value,
        subgroup = "corpses",
        order = "c[corpse]-c[large-toss-base-corpse]",
        final_render_layer = "remnants",
        animation = {
            {
                filename = "__erm_toss__/graphics/entity/buildings/large_rubble.png",
                width = 128,
                height = 128,
                variation_count = 1,
                frame_count = 1,
                direction_count = 1,
                scale = 2
            }
        },
        ground_path = spawner_integration()
    },
    {
        type = "explosion",
        name = "toss-large-building-explosion",
        icon = "__erm_toss__/graphics/entity/icons/buildings/advisor.png",
        icon_size = 64,
        subgroup = 'explosions',
        flags = { "not-on-map", "hidden" },
        order = "toss-explosions",
        render_layer = "explosion",
        animations = {
            filename = "__erm_toss__/graphics/entity/buildings/building_explode.png",
            width = 160,
            height = 160,
            frame_count = 15,
            animation_speed = 0.25,
            direction_count = 1,
            scale = 2,
            draw_as_glow = true,
        }
    },
    {
        type = "explosion",
        name = "toss-small-building-explosion",
        icon = "__erm_toss__/graphics/entity/icons/buildings/advisor.png",
        icon_size = 64,
        subgroup = 'explosions',
        flags = { "not-on-map", "hidden" },
        order = "toss-explosions",
        render_layer = "explosion",
        animations = {
            filename = "__erm_toss__/graphics/entity/buildings/building_explode.png",
            width = 160,
            height = 160,
            frame_count = 15,
            animation_speed = 0.25,
            direction_count = 1,
            scale = 1.25,
            draw_as_glow = true,
        }
    }
});