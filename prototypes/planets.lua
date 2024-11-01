---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 10/26/2024 7:20 PM
---
if feature_flags.space_travel then

local effects = require("__core__.lualib.surface-render-parameter-effects")
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
local procession_graphic_catalogue_types = require("__base__/prototypes/planet/procession-graphic-catalogue-types")

    -- space warzone :P
    --local new_foundation = util.table.deepcopy(data.raw['tile']['space-platform-foundation'])
    --new_foundation['name'] = 'space-platform-foundation-t3'
    --new_foundation['autoplace'] = {probability_expression = 'expression_in_range_base(-10, 0.7, 11, 11) + noise_layer_noise(19)'}

    local aiur_mapgen = function()
        return
        {
            aux_climate_control = true,
            moisture_climate_control = true,
            property_expression_names =
            { -- Warning: anything set here overrides any selections made in the map setup screen so the options do nothing.
                --cliff_elevation = "cliff_elevation_nauvis",
                --cliffiness = "cliffiness_nauvis",
                --elevation = "elevation_island"
            },
            cliff_settings =
            {
                name = "cliff",
                control = "nauvis_cliff",
                cliff_smoothing = 0
            },
            autoplace_controls =
            {
                ["iron-ore"] = {},
                ["copper-ore"] = {},
                ["stone"] = {},
                ["coal"] = {},
                ["water"] = {},
                ["trees"] = {},
                ["erm_toss_enemy_base"] = {},
                ["rocks"] = {},
                ["nauvis_cliff"] = {}
            },
            autoplace_settings =
            {
                ["tile"] =
                {
                    settings =
                    {
                        ["grass-1"] = {},
                        ["grass-2"] = {},
                        ["grass-3"] = {},
                        ["grass-4"] = {},
                        ["sand-1"] = {},
                        ["water"] = {},
                        ["deepwater"] = {}
                    }
                },
                ["decorative"] =
                {
                    settings =
                    {
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
                ["entity"] =
                {
                    settings =
                    {
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
            lightning_properties =
            {
                lightnings_per_chunk_per_tick = 1 / (30 * 60), --cca once per chunk every 30 seconds
                search_radius = 16.0,
                lightning_types = {"erm_toss--lightning"},
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
        }
    end

    --- Aiur intense lighting lore lol
    local lightning = util.table.deepcopy(data.raw['lightning']['lightning'])
    lightning.name = 'erm_toss--lightning'
    lightning.damage = 250
    lightning.energy = "2000MJ"

    data:extend({
        lightning,
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
            --subgroup = "planets", subgroup planets doesn't exist in base, so do we hide this somehow?
            map_seed_offset = 0,
            map_gen_settings = aiur_mapgen(),
            pollutant_type = "pollution",
            solar_power_in_space = 300,
            planet_procession_set =
            {
                arrival = {"default-b"},
                departure = {"default-rocket-a"}
            },
            surface_properties =
            {
                ["day-night-cycle"] = 7 * minute
            },
            surface_render_parameters =
            {
                clouds = effects.default_clouds_effect_properties()
            },
            persistent_ambient_sounds =
            {
                base_ambience = { filename = "__base__/sound/world/world_base_wind.ogg", volume = 0.3 },
                wind = { filename = "__base__/sound/wind/wind.ogg", volume = 0.8 },
                crossfade =
                {
                    order = { "wind", "base_ambience" },
                    curve_type = "cosine",
                    from = { control = 0.35, volume_percentage = 0.0 },
                    to = { control = 2, volume_percentage = 100.0 }
                }
            },
            procession_graphic_catalogue =
            {
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
            name = "aiur-nauvis",
            subgroup = "planet-connections",
            from = "aiur",
            to = "nauvis",
            order = "aiur-nauvis",
            length = 30000,
            asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_fulgora)
        },
        {
            type = "space-connection",
            name = "aiur-fulgora",
            subgroup = "planet-connections",
            from = "aiur",
            to = "fulgora",
            order = "aiur-fulgora",
            length = 15000,
            asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_fulgora)
        },
        --- unlock tech
        {
            type = "technology",
            name = "planet-discovery-char",
            icons = util.technology_icon_constant_planet("__base__/graphics/icons/nauvis.png"),
            icon_size = 256,
            essential = true,
            effects =
            {
                {
                    type = "unlock-space-location",
                    space_location = "aiur",
                    use_icon_overlay_constant = true
                },
            },
            prerequisites = {"space-platform-thruster", "landfill"},
            unit =
            {
                count = 1000,
                ingredients =
                {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"space-science-pack", 1}
                },
                time = 60
            }
        },
    })

end
