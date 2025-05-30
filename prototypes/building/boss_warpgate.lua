---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 12/21/2020 4:42 PM
---



local ERM_UnitHelper = require("__enemyracemanager__/lib/rig/unit_helper")
local GlobalConfig = require("__enemyracemanager__/lib/global_config")
local ERM_DebugHelper = require("__enemyracemanager__/lib/debug_helper")
local ERM_Config = require("__enemyracemanager__/lib/global_config")
local TossSound = require("__erm_toss_hd_assets__/sound")


local AnimationDB = require("__erm_libs__/prototypes/animation_db")
local Creep = require("prototypes.creep")
local enemy_autoplace = require("__enemyracemanager__/prototypes/enemy-autoplace")
local name = "warpgate"

-- Hitpoints

local hitpoint = 1500
local max_hitpoint_multiplier = settings.startup["enemyracemanager-max-hitpoint-multipliers"].value


-- Handles acid and poison resistance
local base_acid_resistance = 0
local incremental_acid_resistance = 50
-- Handles physical resistance
local base_physical_resistance = 0
local incremental_physical_resistance = 60
-- Handles fire and explosive resistance
local base_fire_resistance = 10
local incremental_fire_resistance = 45
-- Handles laser and electric resistance
local base_electric_resistance = 10
local incremental_electric_resistance = 45
-- Handles cold resistance
local base_cold_resistance = 10
local incremental_cold_resistance = 40


local pollution_absorption_absolute = 200
local spawning_cooldown = {780, 480}
local spawning_radius = 10
local max_count_of_owned_units = 20
local max_friends_around_to_spawn = 15
local spawn_table = function(level)
    local res = {}
    --Tire 1
    res[1] = { MOD_NAME.."--zealot--" .. level, { { 0.0, 0.7 }, { 0.2, 0.7 }, { 0.4, 0.6 }, { 0.6, 0.3 }, { 0.8, 0.2 }, { 1.0, 0.05 } } }
    res[2] = { MOD_NAME.."--dragoon--" .. level, { { 0.0, 0.3 }, { 0.2, 0.3 }, { 0.4, 0.4 }, { 0.6, 0.3 }, { 0.8, 0.2 }, { 1.0, 0.05 } } }
    --Tire 2
    res[3] = { MOD_NAME.."--scout--" .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.1 }, { 0.8, 0.2 }, { 1.0, 0.1 } } }
    res[4] = { MOD_NAME.."--corsair--" .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.1 }, { 0.8, 0.1 }, { 1.0, 0.1 } } }
    res[5] = { MOD_NAME.."--probe--" .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.1 }, { 0.8, 0.1 }, { 1.0, 0.1 } } }
    res[6] = { MOD_NAME.."--shuttle--" .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.1 }, { 0.8, 0.1 }, { 1.0, 0.1 } } }
    --Tire 3
    res[7] = { MOD_NAME.."--templar--" .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, { 1.0, 0.1 } } }
    res[8] = { MOD_NAME.."--darktemplar--" .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.1 }, { 1.0, 0.1 } } }
    res[9] = { MOD_NAME.."--archon--" .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, { 1.0, 0.1 } } }
    res[10] = { MOD_NAME.."--carrier--" .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, { 1.0, 0.05 } } }
    res[11] = { MOD_NAME.."--arbiter--" .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, { 1.0, 0.05 } } }
    res[12] = { MOD_NAME.."--reaver--" .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, { 1.0, 0.05 } } }
    res[13] = { MOD_NAME.."--darkarchon--" .. level, { { 0.0, 0.0 }, { 0.2, 0.0 }, { 0.4, 0.0 }, { 0.6, 0.0 }, { 0.8, 0.0 }, { 1.0, 0.05 } } }
    return res
end

local collision_box = { { -4, -4 }, { 4, 4 } }
local map_generator_bounding_box = { { -5, -5 }, { 5, 5 } }
local selection_box = { { -4, -4 }, { 4, 4 } }

function ErmToss.make_boss_wrapgate(level, hitpoint)
    level = level or 1

    data:extend({
        {
            type = "unit-spawner",
            name = MOD_NAME .. "--" .. name .. "--" .. level,
            localised_name = { "entity-name." .. MOD_NAME .. "--" .. name, GlobalConfig.QUALITY_MAPPING[level] },
            icon = "__erm_toss_hd_assets__/graphics/entity/icons/buildings/advisor.png",
            icon_size = 64,
            flags = { "placeable-player", "placeable-enemy" },
            max_health = hitpoint,
            order = MOD_NAME .. "--building--" .. name .. "--".. level,
            subgroup = "enemies",
            working_sound = TossSound.building_working_sound("nexus", 1),
            dying_sound = TossSound.building_dying_sound(1),
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
            healing_per_tick = 0,
            collision_box = collision_box,
            map_generator_bounding_box = map_generator_bounding_box,
            selection_box = selection_box,
    absorptions_per_second = { pollution = { absolute = pollution_absorption_absolute, proportional = 0.01 } },
            corpse = "protoss--large-base-corpse",
            dying_explosion = "protoss--large-building-explosion",
            max_count_of_owned_units = max_count_of_owned_units,
            max_friends_around_to_spawn = max_friends_around_to_spawn,
            map_color = ERM_UnitHelper.format_map_color(settings.startup["enemy_erm_toss-map-color"].value),
                        graphics_set = {
                animations = AnimationDB.get_layered_animations("buildings", name, "run")
            },
            result_units = spawn_table(ERM_Config.MAX_LEVELS),
            -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
            spawning_cooldown = spawning_cooldown,
            spawning_radius = spawning_radius,
            spawning_spacing = 3,
            max_spawn_shift = 0,
            max_richness_for_spawn_shift = 100,
            -- distance_factor used to be 1, but Twinsen says:
            -- "The number or spitter spwners should be roughly equal to the number of biter spawners(regardless of difficulty)."
            -- (2018-12-07)
            autoplace = nil,
            call_for_help_radius = 50,
            spawn_decorations_on_expansion = true,
            spawn_decoration = Creep.getSpawnerCreep(),
            dying_trigger_effect = {
                {
                    type = "script",
                    effect_id = TRIGGER_BOSS_DIES,
                }
            }
        }
    })
end