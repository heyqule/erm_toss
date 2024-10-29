---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 7/17/2023 9:39 PM
---
---
local Creep = {}

function Creep.getSpawnerCreep()
    if settings.startup['erm_toss-enable_floor_decals'].value then
        return {
            {
                decorative = 'tosscreep-decal',
                spawn_min = 1,
                spawn_max = 2,
                spawn_min_radius = 0,
                spawn_max_radius = 2
            },
            {
                decorative = 'tosscreep-decal',
                spawn_min = 3,
                spawn_max = 5,
                spawn_min_radius = 2,
                spawn_max_radius = 7
            }
        }
    end

    return nil
end

return Creep
