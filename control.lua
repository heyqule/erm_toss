--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/20/2020
-- Time: 5:04 PM
-- To change this template use File | Settings | File Templates.
--

local Game = require('__stdlib__/stdlib/game')
local ErmForceHelper = require('__enemyracemanager__/lib/helper/force_helper')
local ErmRaceSettingsHelper = require('__enemyracemanager__/lib/helper/race_settings_helper')
local ErmConfig = require('__enemyracemanager__/lib/global_config')

local Event = require('__stdlib__/stdlib/event/event')
local String = require('__stdlib__/stdlib/utils/string')
local CustomAttacks = require('__erm_toss__/scripts/custom_attacks')

require('__erm_toss__/global')
-- Constants


local createRace = function()
    local force = game.forces[FORCE_NAME]
    if not force then
        force = game.create_force(FORCE_NAME)
    end

    force.ai_controllable = true;
    force.disable_research()
    force.friendly_fire = false;

    if settings.startup['enemyracemanager-free-for-all'].value then
        ErmForceHelper.set_friends(game, FORCE_NAME, false)
    else
        ErmForceHelper.set_friends(game, FORCE_NAME, true)
    end

    ErmForceHelper.set_neutral_force(game, FORCE_NAME)
end

local addRaceSettings = function()
    local race_settings = remote.call('enemyracemanager', 'get_race', MOD_NAME)
    if race_settings == nil then
        race_settings = {}
    end

    race_settings.race =  race_settings.race or MOD_NAME
    race_settings.label = {'gui.label-erm_toss'}
    race_settings.level =  race_settings.level or 1
    race_settings.tier =  race_settings.tier or 1
    race_settings.evolution_point =  race_settings.evolution_point or 0
    race_settings.evolution_base_point =  race_settings.evolution_base_point or 0
    race_settings.attack_meter = race_settings.attack_meter or 0
    race_settings.attack_meter_total = race_settings.attack_meter_total or 0
    race_settings.next_attack_threshold = race_settings.next_attack_threshold or 0

    race_settings.units = {
        { 'zealot', 'dragoon' },
        { 'scout', 'corsair', 'probe', 'shuttle', 'darktemplar' },
        { 'templar', 'archon', 'darkarchon', 'carrier', 'arbiter', 'reaver' },
    }
    race_settings.turrets = {
        { 'cannon', 'acid-cannon' },
        { 'shield_battery'},
        {},
    }
    race_settings.command_centers = {
        { 'nexus' },
        {},
        {}
    }
    race_settings.support_structures = {
        { 'pylon', 'gateway', 'forge' },
        { 'cybernetics_core', 'stargate', 'citadel_adun', 'robotics_facility' },
        { 'templar_archive', 'fleet_beacon', 'arbiter_tribunal','robotics_support_bay' },
    }
    race_settings.flying_units = {
        {'scout'},
        {'corsair'},
        {'carrier','arbiter'}
    }
    race_settings.timed_units = {
        interceptor=true,
        scarab=true
    }
    race_settings.dropship = 'shuttle'
    race_settings.droppable_units = {
        {{ 'dragoon' },{1}},
        {{ 'dragoon', 'darktemplar' },{3,1}},
        {{ 'dragoon', 'darktemplar', 'templar', 'archon', 'darkarchon', 'reaver'},{9,6,2,1,1,1}},
    }
    race_settings.construction_buildings = {
        {{ 'cannon_shortrange'},{1}},
        {{ 'cannon_shortrange', 'shield_battery'},{5,1}},
        {{ 'cannon_shortrange', 'pylon', 'shield_battery'},{5,2,1}},
    }
    race_settings.featured_groups = {
        -- Unit list, spawn ratio, unit attack point cost
        {{'zealot', 'dragoon'}, {6, 3}, 25},
        {{'zealot', 'archon'}, {6, 3}, 35},
        {{'zealot', 'dragoon', 'archon', 'reaver'}, {4, 3, 2, 1}, 30},
        {{'dragoon','templar', 'archon', 'darkarchon'}, {5, 1, 1, 1}, 40},
        {{'darktemplar','templar','archon'}, {4, 1, 2}, 50},
        {{'zealot','dragoon','darktemplar','templar','archon','darkarchon'}, {5,5,2,1,2,1}, 25},
        {{'zealot','dragoon','darktemplar','templar','archon','darkarchon', 'reaver'}, {5,5,3,2,2,1,1}, 25},
    }
    race_settings.featured_flying_groups = {
        {{'scout', 'corsair'}, {1, 1}, 60},
        {{'scout', 'carrier'}, {7, 1}, 75},
        {{'corsair', 'arbiter'}, {5, 1}, 75},
        {{'scout', 'corsair', 'carrier', 'arbiter'}, {3,3,1,1}, 75},
        {{'scout', 'carrier', 'shuttle'}, {5, 1, 1}, 75}
    }

    race_settings.boss_building = 'warpgate'
    race_settings.pathing_unit = 'zealot'
    race_settings.colliding_unit = 'archon'
    race_settings.boss_tier = race_settings.boss_tier or 1
    race_settings.boss_kill_count = race_settings.boss_kill_count or 0

    if game.active_mods['Krastorio2'] then
        race_settings.enable_k2_creep = settings.startup['erm_toss-k2-creep'].value
    end

    ErmRaceSettingsHelper.process_unit_spawn_rate_cache(race_settings)

    remote.call('enemyracemanager', 'register_race', race_settings)

    CustomAttacks.get_race_settings(MOD_NAME, true)
end

Event.on_init(function(event)
    createRace()
    addRaceSettings()
end)

Event.on_load(function(event)
end)

Event.on_configuration_changed(function(event)
    createRace()
    addRaceSettings()
end)

local attack_functions =
{
    [PROBE_ATTACK] = function(args)
        CustomAttacks.process_probe(args)
    end,
    [SHUTTLE_ATTACK] = function(args)
        CustomAttacks.process_shuttle(args)
    end,
    [CARRIER_ATTACK] = function(args)
        CustomAttacks.process_carrier(args)
    end,
    [REAVER_ATTACK] = function(args)
        CustomAttacks.process_reaver(args)
    end,
    [SELF_DESTRUCT_ATTACK] = function(args)
        CustomAttacks.process_self_destruct(args)
    end,
    [TIME_TO_LIVE_DIED] = function(args)
        CustomAttacks.process_time_to_live_unit_died(args)
    end,
    [TIME_TO_LIVE_CREATED] = function(args)
        CustomAttacks.process_time_to_live_unit_created(args)
    end,
    [BOSS_SPAWN_ATTACK] = function(args)
        CustomAttacks.process_boss_units(args)
    end,
    [UNITS_SPAWN_ATTACK] = function(args)
        CustomAttacks.process_batch_units(args)
    end,
    [ARBITER_UNITS_SPAWN_ATTACK] = function(args)
        CustomAttacks.process_batch_units(args, 1)
    end
}
Event.register(defines.events.on_script_trigger_effect, function(event)
    if  attack_functions[event.effect_id] and
            CustomAttacks.valid(event, MOD_NAME)
    then
        attack_functions[event.effect_id](event)
    end
end)

Event.on_nth_tick(901, function(event)
    CustomAttacks.clear_time_to_live_units(event)
end)

local ErmBossAttack = require('scripts/boss_attacks')
remote.add_interface("erm_toss_boss_attacks", {
    get_attack_data = ErmBossAttack.get_attack_data,
})

local RemoteApi = require('scripts/remote')
remote.add_interface("erm_toss", RemoteApi)

