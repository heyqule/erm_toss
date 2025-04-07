---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/21/2020 7:32 PM
---
require("__base__/prototypes/entity/spawner-animation")
local AnimationDB = require("__erm_libs__/prototypes/animation_db")

data:extend({
    {
        type = "corpse",
        name = "protoss--small-base-corpse",
        flags = { "placeable-neutral", "not-on-map" },
        icon = "__erm_toss_hd_assets__/graphics/entity/icons/buildings/advisor.png",
        icon_size = 64,
        collision_box = { { -2, -2 }, { 2, 2 } },
        selection_box = { { -2, -2 }, { 2, 2 } },
        selectable_in_game = false,
        dying_speed = 0.04,
        time_before_removed = minute * settings.startup["enemyracemanager-enemy-corpse-time"].value,
        subgroup = "corpses",
        order = "c[corpse]-c[small-toss-base-corpse]",
        final_render_layer = "remnants",
        animation = AnimationDB.get_single_animation("death","small_rubble","explosion")
    },
    {
        type = "corpse",
        name = "protoss--large-base-corpse",
        flags = { "placeable-neutral",  "not-on-map" },
        icon = "__erm_toss_hd_assets__/graphics/entity/icons/buildings/advisor.png",
        icon_size = 64,
        collision_box = { { -2, -2 }, { 2, 2 } },
        selection_box = { { -2, -2 }, { 2, 2 } },
        selectable_in_game = false,
        dying_speed = 0.04,
        time_before_removed = minute * settings.startup["enemyracemanager-enemy-corpse-time"].value,
        subgroup = "corpses",
        order = "c[corpse]-c[large-toss-base-corpse]",
        final_render_layer = "remnants",
        animation = AnimationDB.get_single_animation("death","large_rubble","explosion"),
    },
    {
        type = "explosion",
        name = "protoss--large-building-explosion",
        icon = "__erm_toss_hd_assets__/graphics/entity/icons/buildings/advisor.png",
        icon_size = 64,
        subgroup = "explosions",
        flags = { "not-on-map" },
        hidden = true,
        order = "toss-explosions",
        render_layer = "explosion",
        animations = AnimationDB.get_layered_animations("death","large_building","explosion")
    },
    {
        type = "explosion",
        name = "protoss--small-building-explosion",
        icon = "__erm_toss_hd_assets__/graphics/entity/icons/buildings/advisor.png",
        icon_size = 64,
        subgroup = "explosions",
        flags = { "not-on-map" },
        hidden = true,
        order = "toss-explosions",
        render_layer = "explosion",
        animations = AnimationDB.get_layered_animations("death","small_building","explosion")
    },
    {
        type = "explosion",
        name = "protoss--darkarchon-explosion",
        icon = "__erm_toss_hd_assets__/graphics/entity/icons/buildings/advisor.png",
        icon_size = 64,
        subgroup = "explosions",
        flags = { "not-on-map" },
        hidden = true,
        order = "toss-explosions",
        render_layer = "explosion",
        animations = AnimationDB.get_layered_animations("death","darkarchon","explosion")
    }
});