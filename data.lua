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
        name = "erm-protoss-damage"
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

require "prototypes.enemy.arbiter"
require "prototypes.enemy.zealot"
require "prototypes.enemy.dragoon"
require "prototypes.enemy.carrier"
require "prototypes.enemy.scout"
require "prototypes.enemy.corsair"
require "prototypes.enemy.darktemplar"
require "prototypes.enemy.invis_darktemplar"
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
require "prototypes.building.boss_pylon"
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

for i = 1, max_level do
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
    ErmToss.make_invis_darktemplar(i)
end


if mods["space-age"] and mods['quality'] then
    ---
    --- Register unit with boss levels.
    --- Replace its AI with boss AI
    ---
    require "prototypes/boss-projectiles"
    local max_boss_tier = ErmConfig.BOSS_MAX_TIERS

    local boss_unit_ai = { destroy_when_commands_fail = true, allow_try_return_to_spawner = false }
    local override_units = {"arbiter","zealot","dragoon","carrier","scout",
                            "corsair","reaver","darkarchon","darktemplar","templar",
                            "archon","probe","shuttle","scarab","interceptor","invis_darktemplar"
    }

    local level = ErmConfig.BOSS_UNIT_TIER
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
    ErmToss.make_invis_darktemplar(level)
    for _, unit in pairs(override_units) do
        data.raw["unit"][MOD_NAME.."--"..unit.."--"..level]["ai_settings"] = boss_unit_ai
    end

    --- Define boss prototypes data
    local boss_data = {}

    --- FINAL_HP = base * 10 (evolution mulitplier) * quality multiplier
    --- @see prototype/extend-quality.lua for quality level details
    --- appox 20mil, 35mil, 50mil, 75mil, 100mil
    boss_data.nexus_hp = {2200000, 3000000, 350000, 4200000, 4250000}
    boss_data.pylon_hp = {10000, 15000, 20000, 25000, 30000}
    --- for spawner's spawning_cooldown
    boss_data.nexus_spawn_timer = {
        {900,900},
        {840,840},
        {750,750},
        {660,660},
        {600,600},
    }

    boss_data.pylon_spawn_timer = {
        {900,900},
        {840,840},
        {780,780},
        {720,720},
        {660,660}
    }
    --- for spawner's max_count_of_owned_units
    boss_data.nexus_units_count = {15, 20, 25, 30, 35}
    boss_data.pylon_units_count = {4, 6, 8, 12, 16}

    for i = 1, max_boss_tier do
        ErmToss.make_boss_wrapgate(i, boss_data)
        ErmToss.make_boss_pylon(i, boss_data)
    end

    --- Boss general attack data
    --- @see script/boss_attack.lua for attack definitions and pattern.
    data.extend({
        {
            type = 'mod-data',
            name = MOD_NAME..'--boss-attack-data',
            data_type = MOD_NAME..'.boss_data',
            data = {
                --- Max assist spawner
                max_buildable_unit_spawner = {5, 6, 8, 10, 12},
                --- Phase_change, Ulitmate, Special, Assist, Heavy, Basic
                defense_attacks={1000000, 2500000, 250000, 100000, 50000, 20000},
                --- max defense attacks per heartbeat.
                max_attacks_per_heartbeat={3,4,4,5,5},
                --- Idle attack (in ticks)
                idle_attack_interval = {90 * second, 85 * second, 60 * second, 53 * second, 45 * second}
            }
        },
    })

    --- Boss reward data
    data.extend({
        {
            type = 'mod-data',
            name = MOD_NAME..'--boss-reward-data',
            data_type = MOD_NAME..'.boss_reward_data',
            data = {
                reward_data = {
                    "char_geyser",
                    "char_mineral_2",
                    "char_mineral",
                    "uranium-238",
                    "sulfuric-acid-barrel",
                    "plastic-bar",
                    "sulfur",
                    "steel-plate",
                    "solid-fuel",
                    "piercing-rounds-magazine",
                    "stone-wall",
                    "light-oil-barrel",
                    "petroleum-gas-barrel",
                    "copper-plate",
                    "iron-plate",
                    "stone-brick",
                    "crude-oil-barrel",
                    "iron-gear-wheel",
                    "iron-stick",
                    "electronic-circuit",
                    "coal",
                    "concrete",
                    "explosives",
                    "battery",
                    "nutrients",
                    "express-transport-belt",
                    "turbo-transport-belt",
                }
            }
        },
    })

    if DEBUG then
        --- For debug
        data.raw['mod-data'][MOD_NAME..'--boss-attack-data'].data.idle_attack_interval = {5 * second, 5 * second, 5 * second, 5 * second, 5 * second,}
    end

    data.extend({
        {
            type = "kill-achievement",
            name = MOD_NAME.."--death-start",
            to_kill = "enemy_erm_zerg--boss_overmind--1",
            amount = 1,
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/zergling.png",
            icon_size = 64,
            allow_without_fight = false,
            order = "z["..MOD_NAME.."]--01-death-start"
        },
        {
            type = "kill-achievement",
            name = MOD_NAME.."--rally-the-char",
            to_kill = "enemy_erm_zerg--boss_overmind--3",
            amount = 1,
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/overlord.png",
            icon_size = 64,
            allow_without_fight = false,
            order = "z["..MOD_NAME.."]--02-rally-the-char"
        },
        {
            type = "kill-achievement",
            name = MOD_NAME.."--planet-fall",
            to_kill = "enemy_erm_zerg--boss_overmind--5",
            amount = 1,
            icon = "__erm_zerg_hd_assets__/graphics/entity/icons/units/ultralisk.png",
            icon_size = 64,
            allow_without_fight = false,
            order = "z["..MOD_NAME.."]--03-planet-fall"
        },
    })
end

-- Achievements
-- T1 For Aiur!
-- T3 The Depleting Shadow
-- T5 Master Control

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

require "prototypes.tips_and_tricks.prototypes"
require "prototypes.economy"
require "prototypes.planets"