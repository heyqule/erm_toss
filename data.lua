ErmToss = {}

require('__erm_toss__/global')

local ErmConfig = require('__enemyracemanager__/lib/global_config')

require 'prototypes/projectiles'
require "prototypes/boss-projectiles"

data:extend(
        {
    {
        type = "ammo-category",
        name = "protoss-damage"
    }
})

require "prototypes.enemy.arbiter"
require "prototypes.enemy.zealot"
require "prototypes.enemy.dragoon"
require "prototypes.enemy.carrier"
require "prototypes.enemy.scout"
require "prototypes.enemy.corsair"
require "prototypes.enemy.darktemplar"
require "prototypes.enemy.templar"
require "prototypes.enemy.archon"
require "prototypes.enemy.probe"
require "prototypes.enemy.shuttle"

require "prototypes.building.building_death"
require "prototypes.building.cannon"
require "prototypes.building.nexus"
require "prototypes.building.boss_nexus"
require "prototypes.building.pylon"
require "prototypes.building.gateway"
require "prototypes.building.forge"
require "prototypes.building.cybernetics_core"
require "prototypes.building.citadel_adun"
require "prototypes.building.templar_archive"
require "prototypes.building.stargate"
require "prototypes.building.fleet_beacon"
require "prototypes.building.arbiter_tribunal"

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
    ErmToss.make_probe(i)
    ErmToss.make_shuttle(i)
end

local boss_level = ErmConfig.BOSS_LEVELS

local boss_unit_ai = { destroy_when_commands_fail = true, allow_try_return_to_spawner = false }
local override_units = {'arbiter','zealot','dragoon','carrier','scout','corsair','darktemplar','templar','archon','probe','shuttle'}

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
    ErmToss.make_probe(level)
    ErmToss.make_shuttle(level)

    ErmToss.make_boss_nexus(level, ErmConfig.BOSS_BUILDING_HITPOINT[i])

    for _, unit in pairs(override_units) do
        print(MOD_NAME..'/'..unit..'/'..level)
        data.raw['unit'][MOD_NAME..'/'..unit..'/'..level]['ai_settings'] = boss_unit_ai
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
end





