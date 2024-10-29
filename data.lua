ErmToss = {}

require("__erm_toss__/global")

local ErmConfig = require("__enemyracemanager__/lib/global_config")

require "prototypes/projectiles"
require "prototypes/boss-projectiles"
require "prototypes/noise-functions"

data:extend(
        {
    {
        type = "ammo-category",
        name = "protoss-damage"
    }
})

-- This set of data is used for set up default autoplace calculation.
data.erm_registered_race = data.erm_registered_race or {}
data.erm_registered_race[MOD_NAME] = true
data.erm_spawn_specs = data.erm_spawn_specs or {}
table.insert(data.erm_spawn_specs, {
    mod_name=MOD_NAME,
    force_name=FORCE_NAME,
    moisture=2, -- 1 = Dry and 2 = Wet
    aux=1, -- -- 1 = red desert, 2 = sand
    elevation=3, --1,2,3 (1 low elevation, 2. medium, 3 high elavation)
    temperature=1, --1,2,3 (1 cold, 2. normal, 3 hot)
})

---
--- This set of data replace vanilla biters for the menu.  It may interfere with other mods that use vanilla biter.
---
data.erm_menu_replacement = data.erm_menu_replacement or {}
data.erm_menu_replacement[MOD_NAME] = {
    race = MOD_NAME,
    level = 3,
    ["unit"] = {
        ["small-biter"] = "zealot",
        ["small-spitter"] = "dragoon",
        ["medium-biter"] = "dragoon",
        ["medium-spitter"] = "archon",
        ["big-biter"] = "archon",
        ["big-spitter"] = "scout",
        ["behemoth-biter"] = "darktemplar",
        ["behemoth-spitter"] = "scout",
    },
    ["turret"] = {
        ["small-worm-turret"] = "cannon",
        ["medium-worm-turret"] = "cannon",
        ["big-worm-turret"] = "cannon",
        ["behemoth-worm-turret"] = "cannon",
    },
    ["turret-scale"] = 0.8,
    ["unit-spawner"] = {
        ["biter-spawner"] = "nexus",
        ["spitter-spawner"] = "gateway",
    },
    ["unit-spawner-scale"] = 0.8
}


require "prototypes.enemy.arbiter"
require "prototypes.enemy.zealot"
require "prototypes.enemy.dragoon"
require "prototypes.enemy.carrier"
require "prototypes.enemy.scout"
require "prototypes.enemy.corsair"
require "prototypes.enemy.darktemplar"
require "prototypes.enemy.templar"
require "prototypes.enemy.archon"
require "prototypes.enemy.darkarchon"
require "prototypes.enemy.probe"
require "prototypes.enemy.shuttle"
require "prototypes.enemy.interceptor"
require "prototypes.enemy.reaver"
require "prototypes.enemy.scarab"

require "prototypes.building.building_death"
require "prototypes.building.cannon"
require "prototypes.building.nexus"
require "prototypes.building.boss_warpgate"
require "prototypes.building.pylon"
require "prototypes.building.gateway"
require "prototypes.building.forge"
require "prototypes.building.cybernetics_core"
require "prototypes.building.citadel_adun"
require "prototypes.building.templar_archive"
require "prototypes.building.stargate"
require "prototypes.building.fleet_beacon"
require "prototypes.building.arbiter_tribunal"
require "prototypes.building.robotics_facility"
require "prototypes.building.robotics_support_bay"
require "prototypes.building.shield_battery"

local max_level = ErmConfig.MAX_LEVELS

for i = 1, max_level + ErmConfig.MAX_ELITE_LEVELS do
    ErmToss.make_arbiter(i)
    ErmToss.make_zealot(i)
    ErmToss.make_dragoon(i)
    ErmToss.make_carrier(i)
    ErmToss.make_scout(i)
    ErmToss.make_corsair(i)
    ErmToss.make_darktemplar(i)
    ErmToss.make_templar(i)
    ErmToss.make_archon(i)
    ErmToss.make_darkarchon(i)
    ErmToss.make_probe(i)
    ErmToss.make_shuttle(i)
    ErmToss.make_interceptor(i)
    ErmToss.make_reaver(i)
    ErmToss.make_scarab(i)
end

local boss_level = ErmConfig.BOSS_LEVELS

local boss_unit_ai = { destroy_when_commands_fail = true, allow_try_return_to_spawner = false }
local override_units = {"arbiter","zealot","dragoon","carrier","scout","corsair","darktemplar","templar","archon","probe","shuttle"}

for i = 1, #boss_level do
    local level = boss_level[i]
    ErmToss.make_arbiter(level)
    ErmToss.make_zealot(level)
    ErmToss.make_dragoon(level)
    ErmToss.make_carrier(level)
    ErmToss.make_scout(level)
    ErmToss.make_corsair(level)
    ErmToss.make_darktemplar(level)
    ErmToss.make_templar(level)
    ErmToss.make_archon(level)
    ErmToss.make_darkarchon(level)
    ErmToss.make_probe(level)
    ErmToss.make_shuttle(level)
    ErmToss.make_interceptor(level)
    ErmToss.make_reaver(level)
    ErmToss.make_scarab(level)

    ErmToss.make_boss_wrapgate(level, ErmConfig.BOSS_BUILDING_HITPOINT[i])

    for _, unit in pairs(override_units) do
        data.raw["unit"][MOD_NAME.."--"..unit.."--"..level]["ai_settings"] = boss_unit_ai
    end
end

for i = 1, max_level do
    ErmToss.make_cannon(i)
    ErmToss.make_nexus(i)
    ErmToss.make_pylon(i)
    ErmToss.make_gateway(i)
    ErmToss.make_forge(i)
    ErmToss.make_cybernetics_core(i)
    ErmToss.make_citadel_adun(i)
    ErmToss.make_templar_archive(i)
    ErmToss.make_stargate(i)
    ErmToss.make_fleet_beacon(i)
    ErmToss.make_arbiter_tribunal(i)
    ErmToss.make_robotics_facility(i)
    ErmToss.make_robotics_support_bay(i)
    ErmToss.make_shield_battery(i)
end

data.erm_land_scout = data.erm_land_scout or {}
data.erm_land_scout[MOD_NAME] = "zealot"

data.erm_aerial_scout = data.erm_aerial_scout or {}
data.erm_aerial_scout[MOD_NAME] = "scout"


require("prototypes.planets")
require("prototypes.update-teamcolour")