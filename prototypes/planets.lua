---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 10/26/2024 7:20 PM
---
if not feature_flags.space_travel then
    return
end

local effects = require("__core__.lualib.surface-render-parameter-effects")
local asteroid_triggers = require("__erm_libs__.prototypes.asteroid_triggers")
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
local procession_graphic_catalogue_types = require("__base__/prototypes/planet/procession-graphic-catalogue-types")

-- potential space warzone :P
--local new_foundation = util.table.deepcopy(data.raw['tile']['space-platform-foundation'])
--new_foundation['name'] = 'space-platform-foundation-t3'
--new_foundation['autoplace'] = {probability_expression = 'expression_in_range_base(-10, 0.7, 11, 11) + noise_layer_noise(19)'}

local aiur_mapgen =
    {
        starting_area = 1.5,
        aux_climate_control = false,
        moisture_climate_control = false,
        property_expression_names = { -- Warning: anything set here overrides any selections made in the map setup screen so the options do nothing.
            --cliff_elevation = "cliff_elevation_nauvis",
            --cliffiness = "cliffiness_nauvis",
            --elevation = "elevation_island"
        },
        cliff_settings = {
            name = "cliff",
            control = "nauvis_cliff",
            cliff_smoothing = 0
        },
        autoplace_controls = {
            ["iron-ore"] = {},
            ["copper-ore"] = {},
            ["stone"] = {},
            ["coal"] = {},
            ["water"] = {},
            ["trees"] = {},
            [AUTOCONTROL_NAME] = {},
            ["rocks"] = {},
            ["nauvis_cliff"] = {}
        },
        autoplace_settings = {
            ["tile"] = {
                settings = {
                    ["grass-1"] = {},
                    ["grass-2"] = {},
                    ["grass-3"] = {},
                    ["grass-4"] = {},
                    ["water"] = {},
                    ["deepwater"] = {}
                }
            },
            ["decorative"] = {
                settings = {
                    ["green-hairy-grass"] = {},
                    ["green-carpet-grass"] = {},
                    ["green-small-grass"] = {},
                    ["green-asterisk"] = {},
                    ["green-asterisk-mini"] = {},
                    ["red-asterisk"] = {},
                    ["dark-mud-decal"] = {},
                    ["light-mud-decal"] = {},
                    ["cracked-mud-decal"] = {},
                    ["green-carpet-grass"] = {},
                    ["green-hairy-grass"] = {},
                    ["green-pita"] = {},
                    ["red-pita"] = {},
                    ["green-croton"] = {},
                    ["red-croton"] = {},
                    ["green-pita-mini"] = {},
                    ["garballo-mini-dry"] = {},
                    ["garballo"] = {},
                    ["green-bush-mini"] = {},
                    ["medium-rock"] = {},
                    ["small-rock"] = {},
                    ["tiny-rock"] = {},
                    ["medium-sand-rock"] = {},
                    ["small-sand-rock"] = {},
                }
            },
            ["entity"] = {
                settings = {
                    ["iron-ore"] = {},
                    ["copper-ore"] = {},
                    ["stone"] = {},
                    ["coal"] = {},
                    ["big-sand-rock"] = {},
                    ["huge-rock"] = {},
                    ["big-rock"] = {},
                }
            }
        },
        lightning_properties = {
            lightnings_per_chunk_per_tick = 1 / (30 * 60), --cca once per chunk every 30 seconds
            search_radius = 16.0,
            lightning_types = { "enemy_erm_toss--lightning" },
            priority_rules = {
                {
                    type = "id",
                    string = "lightning-collector",
                    priority_bonus = 10000
                },
                {
                    type = "prototype",
                    string = "lightning-attractor",
                    priority_bonus = 1000
                },
                {
                    type = "prototype",
                    string = "pipe",
                    priority_bonus = 1
                },
                {
                    type = "prototype",
                    string = "pump",
                    priority_bonus = 1
                },
                {
                    type = "prototype",
                    string = "offshore-pump",
                    priority_bonus = 1
                },
                {
                    type = "prototype",
                    string = "electric-pole",
                    priority_bonus = 10
                },
                {
                    type = "prototype",
                    string = "power-switch",
                    priority_bonus = 10
                },
                {
                    type = "prototype",
                    string = "logistic-robot",
                    priority_bonus = 100
                },
                {
                    type = "prototype",
                    string = "construction-robot",
                    priority_bonus = 100
                },
                {
                    type = "impact-soundset",
                    string = "metal",
                    priority_bonus = 1
                }
            },
            exemption_rules = {
                {
                    type = "prototype",
                    string = "rail-support",
                },
                {
                    type = "prototype",
                    string = "legacy-straight-rail",
                },
                {
                    type = "prototype",
                    string = "legacy-curved-rail",
                },
                {
                    type = "prototype",
                    string = "straight-rail",
                },
                {
                    type = "prototype",
                    string = "curved-rail-a",
                },
                {
                    type = "prototype",
                    string = "curved-rail-b",
                },
                {
                    type = "prototype",
                    string = "half-diagonal-rail",
                },
                {
                    type = "prototype",
                    string = "rail-ramp",
                },
                {
                    type = "prototype",
                    string = "elevated-straight-rail",
                },
                {
                    type = "prototype",
                    string = "elevated-curved-rail-a",
                },
                {
                    type = "prototype",
                    string = "elevated-curved-rail-b",
                },
                {
                    type = "prototype",
                    string = "elevated-half-diagonal-rail",
                },
                {
                    type = "prototype",
                    string = "rail-signal",
                },
                {
                    type = "prototype",
                    string = "rail-chain-signal",
                },
                {
                    type = "prototype",
                    string = "locomotive",
                },
                {
                    type = "prototype",
                    string = "artillery-wagon",
                },
                {
                    type = "prototype",
                    string = "cargo-wagon",
                },
                {
                    type = "prototype",
                    string = "fluid-wagon",
                },
                {
                    type = "prototype",
                    string = "land-mine",
                },
                {
                    type = "prototype",
                    string = "wall",
                },
                {
                    type = "prototype",
                    string = "tree",
                },
                {
                    type = "countAsRockForFilteredDeconstruction",
                    string = "true",
                },
            }
        },
    }


----- Add medium asteroid that spawn units
local oxide_name = MOD_NAME.."--medium-energized-oxide-asteroid"
local protoss_spawning_oxide_asteroid = util.table.deepcopy(data.raw['asteroid']['medium-oxide-asteroid'])
protoss_spawning_oxide_asteroid["name"] = oxide_name

local carbonic_name = MOD_NAME.."--medium-energized-carbonic-asteroid"
local protoss_spawning_carbonic_asteroid = util.table.deepcopy(data.raw['asteroid']['medium-carbonic-asteroid'])
protoss_spawning_carbonic_asteroid["name"]  = carbonic_name

local metallic_name = MOD_NAME.."--medium-energized-metallic-asteroid"
local protoss_spawning_metallic_asteroid = util.table.deepcopy(data.raw['asteroid']['medium-metallic-asteroid'])
protoss_spawning_metallic_asteroid["name"]  = metallic_name

local new_asteroids = {
    [oxide_name] = protoss_spawning_metallic_asteroid,
    [carbonic_name] = protoss_spawning_carbonic_asteroid,
    [metallic_name] = protoss_spawning_oxide_asteroid,
}

local astreroid_data = {
    [metallic_name] = {
        scout = { [4] = 0.25, [5] = 0.05},
        interceptor = { [4] = 0.5, [5] = 0.1},
    },
    [carbonic_name] = {
        carrier = { [4] = 0.1, [5] = 0.02},
        interceptor = { [4] = 0.5, [5] = 0.1},
    },
    [oxide_name] = {
        corsair = { [4] = 0.25, [5] = 0.05},
        shuttle = { [4] = 0.1, [5] = 0.02},
    }
}
for key, a_data in pairs(astreroid_data) do
    for unit_name, spawn_data in pairs(a_data) do
        for tier, chance in pairs(spawn_data) do
            asteroid_triggers.add_unit_to_asteroid(new_asteroids[key], MOD_NAME, unit_name, tier, chance)
        end
    end
end

data:extend({
    --- Asteroid that spawn units
    protoss_spawning_oxide_asteroid,
    protoss_spawning_carbonic_asteroid,
    protoss_spawning_metallic_asteroid,
})

local aiur_space_connection_asteroid_spawn_definition = {
    {
        asteroid = "metallic-asteroid-chunk",
        spawn_points = {
            {
                angle_when_stopped = 1,
                distance = 0.1,
                probability = 0.0125,
                speed = 0.016666666666666665
            },
            {
                angle_when_stopped = 1,
                distance = 0.9,
                probability = 0.0025,
                speed = 0.016666666666666665
            }
        },
        type = "asteroid-chunk"
    },
    {
        asteroid = "carbonic-asteroid-chunk",
        spawn_points = {
            {
                angle_when_stopped = 1,
                distance = 0.1,
                probability = 0.0083333333333333321,
                speed = 0.016666666666666665
            },
            {
                angle_when_stopped = 1,
                distance = 0.9,
                probability = 0.001875,
                speed = 0.016666666666666665
            }
        },
        type = "asteroid-chunk"
    },
    {
        asteroid = "oxide-asteroid-chunk",
        spawn_points = {
            {
                angle_when_stopped = 1,
                distance = 0.1,
                probability = 0.0041666666666666661,
                speed = 0.016666666666666665
            },
            {
                angle_when_stopped = 1,
                distance = 0.9,
                probability = 0.000625,
                speed = 0.016666666666666665
            }
        },
        type = "asteroid-chunk"
    },
    {
        asteroid = metallic_name,
        spawn_points = {
            {
                angle_when_stopped = 0.6,
                distance = 0.1,
                probability = 0,
                speed = 0.016666666666666665
            },
            {
                angle_when_stopped = 0.6,
                distance = 0.5,
                probability = 0.0075,
                speed = 0.016666666666666665
            },
            {
                angle_when_stopped = 0.6,
                distance = 0.9,
                probability = 0.0025,
                speed = 0.016666666666666665
            }
        }
    },
    {
        asteroid = carbonic_name,
        spawn_points = {
            {
                angle_when_stopped = 0.6,
                distance = 0.1,
                probability = 0,
                speed = 0.016666666666666665
            },
            {
                angle_when_stopped = 0.6,
                distance = 0.5,
                probability = 0.0053124999999999991,
                speed = 0.016666666666666665
            },
            {
                angle_when_stopped = 0.6,
                distance = 0.9,
                probability = 0.001875,
                speed = 0.016666666666666665
            }
        }
    },
    {
        asteroid = oxide_name,
        spawn_points = {
            {
                angle_when_stopped = 0.6,
                distance = 0.1,
                probability = 0,
                speed = 0.016666666666666665
            },
            {
                angle_when_stopped = 0.6,
                distance = 0.5,
                probability = 0.0021875,
                speed = 0.016666666666666665
            },
            {
                angle_when_stopped = 0.6,
                distance = 0.9,
                probability = 0.000625,
                speed = 0.016666666666666665
            }
        }
    }
}

local auir_space_asteroid_spawn_definition = {
    {
        asteroid = "metallic-asteroid-chunk",
        angle_when_stopped = 1,
        probability = 0.0025,
        speed = 0.016666666666666665,
        type = "asteroid-chunk"
    },
    {
        asteroid = "carbonic-asteroid-chunk",
        angle_when_stopped = 1,
        probability = 0.001875,
        speed = 0.016666666666666665,
        type = "asteroid-chunk"
    },
    {
        asteroid = "oxide-asteroid-chunk",
        angle_when_stopped = 1,
        probability = 0.000625,
        speed = 0.016666666666666665,
        type = "asteroid-chunk"
    },
    {
        asteroid = metallic_name,
        angle_when_stopped = 0.6,
        probability = 0.0025,
        speed = 0.016666666666666665,
    },
    {
        asteroid = carbonic_name,
        angle_when_stopped = 0.6,
        probability = 0.001875,
        speed = 0.016666666666666665
    },
    {
        asteroid = oxide_name,
        angle_when_stopped = 0.6,
        probability = 0.000625,
        speed = 0.016666666666666665
    }
}


--- Aiur's intense lighting lol
local aiur_lightning = util.table.deepcopy(data.raw['lightning']['lightning'])
aiur_lightning.name = 'enemy_erm_toss--aiur-lightning'
aiur_lightning.damage = 500
aiur_lightning.energy = "5000MJ"

local aiur_unit_probabilities = {
    [MOD_NAME.."--zealot--1"] = 0.02,
    [MOD_NAME.."--dragoon--1"] = 0.01,
    [MOD_NAME.."--darktemplar--1"] = 0.005,
    [MOD_NAME.."--invis_darktemplar--1"] = 0.003,
}

for key, prop in pairs(aiur_unit_probabilities) do
    table.insert(aiur_lightning.strike_effect.action_delivery.target_effects,
            {
                type = "nested-result",
                probability = prop,
                action = {
                    type = "direct",
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            {
                                type = "create-entity",
                                entity_name = key,
                                offset_deviation = {{-8, -8}, {8, 8}},
                                offsets = {
                                    {0, 0}
                                },
                                trigger_created_entity = true,
                                find_non_colliding_position = true,
                                non_colliding_search_radius = 8,
                                non_colliding_search_precision = 2,
                            },
                            {
                                type = "create-explosion",
                                entity_name = MOD_NAME.."--recall-80",
                            }
                        }
                    }
                }
            }
    )
end




local fulgora_lightning_replacement = util.table.deepcopy(data.raw['lightning']['lightning'])
fulgora_lightning_replacement.name = 'enemy_erm_toss--fulgora-lightning'
local fulgora_unit_probabilities = {
    [MOD_NAME.."--zealot--1"] = 0.005,
    [MOD_NAME.."--dragoon--1"] = 0.002,
    [MOD_NAME.."--darktemplar--1"] = 0.001,
    [MOD_NAME.."--invis_darktemplar--1"] = 0.001,
}
for key, prop in pairs(fulgora_unit_probabilities) do
    table.insert(fulgora_lightning_replacement.strike_effect.action_delivery.target_effects,
        {
            type = "nested-result",
            probability = prop,
            action = {
                type = "direct",
                action_delivery = {
                    type = "instant",
                    target_effects = {
                        {
                            type = "create-entity",
                            entity_name = key,
                            offset_deviation = {{-8, -8}, {8, 8}},
                            offsets = {
                                {0,0}
                            },
                            trigger_created_entity = true,
                            find_non_colliding_position = true,
                            non_colliding_search_radius = 8,
                            non_colliding_search_precision = 2,
                        },
                        {
                            type = "create-explosion",
                            entity_name = MOD_NAME.."--recall-80",
                        }
                    }
                }
            }
        }
    )
end
data:extend({
    aiur_lightning,
    fulgora_lightning_replacement,
    --- Planet
    {
        type = "planet",
        name = "aiur",
        icon = "__base__/graphics/icons/nauvis.png",
        starmap_icon = "__base__/graphics/icons/starmap-planet-nauvis.png",
        starmap_icon_size = 512,
        gravity_pull = 10,
        distance = 20,
        orientation = 0.45,
        magnitude = 1,
        order = "a[aiur]",
        subgroup = "planets",
        map_seed_offset = 100000,
        map_gen_settings = aiur_mapgen,
        pollutant_type = "pollution",
        solar_power_in_space = 300,
        planet_procession_set = {
            arrival = { "default-b" },
            departure = { "default-rocket-a" }
        },
        surface_properties = {
            ["day-night-cycle"] = 8 * minute
        },
        surface_render_parameters = {
            clouds = effects.default_clouds_effect_properties()
        },
        asteroid_spawn_influence = 1,
        asteroid_spawn_definitions = auir_space_asteroid_spawn_definition,
        persistent_ambient_sounds = {
            base_ambience = { filename = "__base__/sound/world/world_base_wind.ogg", volume = 0.3 },
            wind = { filename = "__base__/sound/wind/wind.ogg", volume = 0.8 },
            crossfade = {
                order = { "wind", "base_ambience" },
                curve_type = "cosine",
                from = { control = 0.35, volume_percentage = 0.0 },
                to = { control = 2, volume_percentage = 100.0 }
            },
            semi_persistent =
            {
                {
                    sound = {variations = sound_variations("__space-age__/sound/world/semi-persistent/wind-gust", 6, 0.4)},
                    delay_mean_seconds = 10,
                    delay_variance_seconds = 5
                },
                {
                    sound =
                    {
                        filename = "__space-age__/sound/world/weather/rain.ogg", volume = 0.25,
                        advanced_volume_control = {fades = {fade_in = {curve_type = "cosine", from = {control = 0.2, volume_percentage = 0.6}, to = {1.2, 100.0 }}}}
                    }
                },
                {
                    sound =
                    {
                        variations = sound_variations("__space-age__/sound/world/semi-persistent/night-birds", 14, 0.4),
                        advanced_volume_control =
                        {
                            fades = {fade_in = {curve_type = "cosine", from = {control = 0.5, volume_percentage = 0.0}, to = {1.5, 100.0}}},
                            darkness_threshold = 0.85
                        }
                    },
                    delay_mean_seconds = 10,
                    delay_variance_seconds = 5
                }
            },
        },
        ---- Rain
        player_effects =
        { -- TODO: replace with shader & find a way to have rain appear and disappear with weather system.
            type = "cluster",
            cluster_count = 10,
            distance = 8,
            distance_deviation = 8,
            action_delivery =
            {
                type = "instant",
                source_effects =
                {
                    type = "create-trivial-smoke",
                    smoke_name = "gleba-raindrops",
                    speed = {-0.05, 0.5},
                    initial_height = 1,
                    speed_multiplier = 2,
                    speed_multiplier_deviation = 0.05,
                    starting_frame = 2,
                    starting_frame_deviation = 2,
                    offset_deviation = {{-96, -56}, {96, 40}},
                    speed_from_center = 0.01,
                    speed_from_center_deviation = 0.02
                }
            }
        },
        ticks_between_player_effects = 1,
        ---- Lighting
        lightning_properties =
        {
            lightnings_per_chunk_per_tick = 1 / (30 * 60), --cca once per chunk half minute (600 ticks)
            search_radius = 8.0,
            lightning_types = {"enemy_erm_toss--aiur-lightning"},
            priority_rules =
            {
                {
                    type = "id",
                    string = "lightning-collector",
                    priority_bonus = 10000
                },
                {
                    type = "prototype",
                    string = "lightning-attractor",
                    priority_bonus = 1000
                },
                {
                    type = "prototype",
                    string = "pipe",
                    priority_bonus = 1
                },
                {
                    type = "prototype",
                    string = "pump",
                    priority_bonus = 1
                },
                {
                    type = "prototype",
                    string = "offshore-pump",
                    priority_bonus = 1
                },
                {
                    type = "prototype",
                    string = "electric-pole",
                    priority_bonus = 10
                },
                {
                    type = "prototype",
                    string = "power-switch",
                    priority_bonus = 10
                },
                {
                    type = "prototype",
                    string = "logistic-robot",
                    priority_bonus = 100
                },
                {
                    type = "prototype",
                    string = "construction-robot",
                    priority_bonus = 100
                },
                {
                    type = "impact-soundset",
                    string = "metal",
                    priority_bonus = 1
                }
            },
            exemption_rules =
            {
                {
                    type = "prototype",
                    string = "rail-support",
                },
                {
                    type = "prototype",
                    string = "legacy-straight-rail",
                },
                {
                    type = "prototype",
                    string = "legacy-curved-rail",
                },
                {
                    type = "prototype",
                    string = "straight-rail",
                },
                {
                    type = "prototype",
                    string = "curved-rail-a",
                },
                {
                    type = "prototype",
                    string = "curved-rail-b",
                },
                {
                    type = "prototype",
                    string = "half-diagonal-rail",
                },
                {
                    type = "prototype",
                    string = "rail-ramp",
                },
                {
                    type = "prototype",
                    string = "elevated-straight-rail",
                },
                {
                    type = "prototype",
                    string = "elevated-curved-rail-a",
                },
                {
                    type = "prototype",
                    string = "elevated-curved-rail-b",
                },
                {
                    type = "prototype",
                    string = "elevated-half-diagonal-rail",
                },
                {
                    type = "prototype",
                    string = "rail-signal",
                },
                {
                    type = "prototype",
                    string = "rail-chain-signal",
                },
                {
                    type = "prototype",
                    string = "locomotive",
                },
                {
                    type = "prototype",
                    string = "artillery-wagon",
                },
                {
                    type = "prototype",
                    string = "cargo-wagon",
                },
                {
                    type = "prototype",
                    string = "fluid-wagon",
                },
                {
                    type = "prototype",
                    string = "land-mine",
                },
                {
                    type = "prototype",
                    string = "wall",
                },
                {
                    type = "prototype",
                    string = "tree",
                },
                {
                    type = "countAsRockForFilteredDeconstruction",
                    string = "true",
                },
            }
        },
        procession_graphic_catalogue = {
            {
                index = procession_graphic_catalogue_types.planet_hatch_emission_in_1,
                sprite = util.sprite_load("__base__/graphics/entity/cargo-hubs/hatches/planet-lower-hatch-pod-emission-A",
                        {
                            priority = "medium",
                            draw_as_glow = true,
                            blend_mode = "additive",
                            scale = 0.5,
                            shift = util.by_pixel(-16, 96) --32 x ({0.5, -3.5} + {0, 0.5})
                        })
            },
            {
                index = procession_graphic_catalogue_types.planet_hatch_emission_in_2,
                sprite = util.sprite_load("__base__/graphics/entity/cargo-hubs/hatches/planet-lower-hatch-pod-emission-B",
                        {
                            priority = "medium",
                            draw_as_glow = true,
                            blend_mode = "additive",
                            scale = 0.5,
                            shift = util.by_pixel(-64, 96) --32 x ({2, -3.5} + {0, 0.5})
                        })
            },
            {
                index = procession_graphic_catalogue_types.planet_hatch_emission_in_3,
                sprite = util.sprite_load("__base__/graphics/entity/cargo-hubs/hatches/planet-lower-hatch-pod-emission-C",
                        {
                            priority = "medium",
                            draw_as_glow = true,
                            blend_mode = "additive",
                            scale = 0.5,
                            shift = util.by_pixel(-40, 64) --32 x ({1.25, -2.5} + {0, 0.5})
                        })
            }
        }
    },
    --- space connection
    {
        type = "space-connection",
        name = "nauvis-aiur",
        subgroup = "planet-connections",
        from = "nauvis",
        to = "aiur",
        order = "nauvis-aiur",
        length = 22500,
        asteroid_spawn_definitions = aiur_space_connection_asteroid_spawn_definition
    },
    {
        type = "space-connection",
        name = "fulgora-aiur",
        subgroup = "planet-connections",
        from = "fulgora",
        to = "aiur",
        order = "fulgora-aiur",
        length = 15000,
        asteroid_spawn_definitions = aiur_space_connection_asteroid_spawn_definition
    },
    --- unlock tech
    {
        type = "technology",
        name = "planet-discovery-aiur",
        icons = {
            {
                icon = "__base__/graphics/icons/nauvis.png",
                icon_size = 64,
            },
            {
                icon = "__core__/graphics/icons/technology/constants/constant-planet.png",
                icon_size = 128,
                scale = 0.5,
                shift = { 50, 50 }
            }
        },
        essential = false,
        effects = {
            {
                type = "unlock-space-location",
                space_location = "aiur",
                use_icon_overlay_constant = true
            },
        },
        prerequisites = { "space-platform-thruster", "landfill" },
        unit = {
            count = 1000,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "space-science-pack", 1 }
            },
            time = 60
        }
    },
})

if mods['alien-biomes'] then
    -- AB wipes autoplace spec from them and cause them to crash. Aiur won't get rock till they fix it. 
    local planet = data.raw.planet.aiur
    local map_gen = planet.map_gen_settings
    map_gen.autoplace_settings.decorative.settings['medium-rock'] = nil
    map_gen.autoplace_settings.decorative.settings['small-rock'] = nil
    map_gen.autoplace_settings.decorative.settings['tiny-rock'] = nil
    map_gen.autoplace_settings.decorative.settings['small-sand-rock'] = nil

    map_gen.autoplace_settings.decorative.settings['medium-sand-rock'] = nil
    map_gen.autoplace_settings.decorative.settings['sand-dune-decal'] = nil

    map_gen.autoplace_settings.entity.settings['huge-rock'] = nil
    map_gen.autoplace_settings.entity.settings['big-rock'] = nil
    map_gen.autoplace_settings.entity.settings['big-sand-rock'] = nil
    
    map_gen.autoplace_controls.rocks = nil
end
