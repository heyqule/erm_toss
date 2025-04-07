---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 10/29/2024 2:29 AM
---
require("__erm_toss__/global")

require("prototypes.update-teamcolour")

local MapGenFunctions = require('__erm_libs__/prototypes/map_gen')
-- Update RTS world
local mapgen = data.raw["map-gen-presets"]["default"]
mapgen["erm-rts-death-world"]["basic_settings"]["autoplace_controls"][AUTOCONTROL_NAME] = { frequency = "very-high", size = "very-big" }

if mapgen["death-world"] then
    mapgen["death-world"]["basic_settings"]["autoplace_controls"][AUTOCONTROL_NAME] = { frequency = "very-high", size = "very-big" }
end

if mapgen["erm-debug"] then
    mapgen["erm-debug"]["basic_settings"]["autoplace_controls"][AUTOCONTROL_NAME] = { frequency = 5, size = 5 }
end

local nauvis_planet = data.raw.planet.nauvis
local map_gen_settings = nauvis_planet.map_gen_settings
if map_gen_settings then
    local nauvis_autocontrols = map_gen_settings.autoplace_controls
    local nauvis_enemy_settings = settings.startup["enemyracemanager-nauvis-enemy"].value
    if nauvis_enemy_settings == MOD_NAME then
        MapGenFunctions.remove_enemy_autoplace_controls(nauvis_autocontrols)

        nauvis_autocontrols[AUTOCONTROL_NAME] = {}

        print('ERM_TOSS: Nauvis AutoControl:')
        print(serpent.block(data.raw.planet.nauvis.map_gen_settings.autoplace_controls))

    elseif nauvis_enemy_settings == NAUVIS_MIXED then
        nauvis_autocontrols[AUTOCONTROL_NAME] = {}

        print('ERM_TOSS: Nauvis AutoControl:')
        print(serpent.block(data.raw.planet.nauvis.map_gen_settings.autoplace_controls))
    end
end


if mods["space-age"] and 
   settings.startup["enemy_erm_toss-on_fulgora"] and 
   settings.startup["enemy_erm_toss-on_fulgora"].value 
then
    local fulgora = data.raw.planet.fulgora
    local map_gen_settings = fulgora.map_gen_settings

    if map_gen_settings then
        map_gen_settings.autoplace_controls[AUTOCONTROL_NAME] = {}
    end

    data.raw["lightning-attractor"]["fulgoran-ruin-attractor"].alert_when_damaged = false
    --- replace lightning
    if settings.startup["enemy_erm_toss-lightning_on_fulgora"].value then
        fulgora.lightning_properties.lightning_types = {"enemy_erm_toss--fulgora-lightning"}
    end
end