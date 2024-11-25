---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 10/28/2024 10:53 PM
---

data:extend{
    {
        type = "autoplace-control",
        name = AUTOCONTROL_NAME,
        order = AUTOCONTROL_NAME,
        category = "enemy",
        can_be_disabled = false
    },
    {
        type = "noise-expression",
        name = "erm_toss_base_intensity",
        -- biter placement stops increasing in "intensity" after 75 chunks (2400 tiles)
        expression = "clamp(distance, 0, 2400) / 325"
    },
    {
        type = "noise-expression",
        name = "erm_toss_base_radius",
        expression = "sqrt(var('control:"..AUTOCONTROL_NAME..":size')) * (15 + 4 * erm_toss_base_intensity)"
    },
    {
        type = "noise-expression",
        name = "erm_toss_base_frequency",
        -- bases_per_km2 = 10 + 3 * erm_toss_base_intensity
        expression = "(0.00001 + 0.000003 * erm_toss_base_intensity) * var('control:"..AUTOCONTROL_NAME..":frequency')"
    },
    {
        type = "noise-expression",
        name = "erm_toss_base_probability",
        expression = "spot_noise{x = x,\z
                             y = y,\z
                             density_expression = spot_quantity_expression * max(0, erm_toss_base_frequency),\z
                             spot_quantity_expression = spot_quantity_expression,\z
                             spot_radius_expression = spot_radius_expression,\z
                             spot_favorability_expression = 1,\z
                             seed0 = map_seed,\z
                             seed1 = 324893,\z
                             region_size = 512,\z
                             candidate_point_count = 100,\z
                             hard_region_target_quantity = 0,\z
                             basement_value = -1000,\z
                             maximum_spot_basement_radius = 128} + \z
                  (blob(1/8, 1) + blob(1/24, 1) + blob(1/64, 2) - 0.5) * spot_radius_expression / 150 * \z
                  (0.1 + 0.9 * clamp(distance / 3000, 0, 1)) - 0.3 + min(0, 20 / starting_area_radius * distance - 20)",
        local_expressions =
        {
            spot_radius_expression = "max(0, erm_toss_base_radius)",
            spot_quantity_expression = "pi/90 * spot_radius_expression ^ 3"
        },
        local_functions =
        {
            blob =
            {
                parameters = {"input_scale", "output_scale"},
                expression = "basis_noise{x = x, y = y, seed0 = map_seed, seed1 = 123, input_scale = input_scale, output_scale = output_scale}"
            }
        }
    },
    {
        type = "noise-function",
        name = "erm_toss_autoplace_base",
        parameters = {"distance_factor", "seed"},
        expression = "random_penalty{x = x + seed,\z
                                 y = y,\z
                                 source = min(erm_toss_base_probability * max(0, 1 + 0.002 * distance_factor * (-312 * distance_factor - starting_area_radius + distance)),\z
                                              0.25 + distance_factor * 0.05),\z
                                 amplitude = 0.1}"
    },
}