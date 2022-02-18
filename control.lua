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
local CustomAttacks = require('__erm_toss__/prototypes/custom_attacks')

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
end

local addRaceSettings = function()
    local race_settings = remote.call('enemy_race_manager', 'get_race', MOD_NAME)
    if race_settings == nil then
        race_settings = {}
    end

    race_settings.race =  race_settings.race or MOD_NAME
    race_settings.version =  race_settings.version or MOD_VERSION
    race_settings.level =  race_settings.level or 1
    race_settings.tier =  race_settings.tier or 1
    race_settings.evolution_point =  race_settings.evolution_point or 0
    race_settings.evolution_base_point =  race_settings.evolution_base_point or 0
    race_settings.attack_meter = race_settings.attack_meter or 0
    race_settings.attack_meter_total = race_settings.attack_meter_total or 0
    race_settings.next_attack_threshold = race_settings.next_attack_threshold or 0

    race_settings.units = {
        { 'zealot', 'dragoon' },
        { 'scout', 'corsair', 'probe', 'shuttle' },
        { 'templar', 'darktemplar', 'archon', 'carrier', 'arbiter' },
    }
    race_settings.turrets = {
        { 'cannon', 'acid-cannon' },
        {},
        {},
    }
    race_settings.command_centers = {
        { 'nexus' },
        {},
        {}
    }
    race_settings.support_structures = {
        { 'pylon', 'gateway', 'forge' },
        { 'cybernetics_core', 'stargate', 'citadel_adun' },
        { 'templar_archive', 'fleet_beacon', 'arbiter_tribunal' },
    }
    race_settings.flying_units = {
        {'scout'}, -- Fast unit that uses in rapid target attack group
        {'corsair'},
        {'carrier','arbiter'}
    }
    race_settings.dropship = 'shuttle'

    remote.call('enemy_race_manager', 'register_race', race_settings)

    Event.dispatch({
        name = Event.get_event_name(ErmConfig.RACE_SETTING_UPDATE), affected_race = MOD_NAME })
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
    end
}
Event.register(defines.events.on_script_trigger_effect, function(event)
    if  attack_functions[event.effect_id] and
            CustomAttacks.valid(event, MOD_NAME)
    then
        attack_functions[event.effect_id](event)
    end
end)


---
--- Modify Race Settings for existing game
---
Event.register(Event.generate_event_name(ErmConfig.RACE_SETTING_UPDATE), function(event)
    local race_setting = remote.call('enemy_race_manager', 'get_race', MOD_NAME)
    if (event.affected_race == MOD_NAME) and race_setting then
        if race_setting.version < MOD_VERSION then
            if race_setting.version < 101 then
                ErmRaceSettingsHelper.remove_structure_from_tier(race_setting, 1, 'nexus')
                ErmRaceSettingsHelper.add_turret_to_tier(race_setting, 1, 'acid-cannon')
            end

            if race_setting.version < 102 then
                race_setting.angry_meter = nil
                race_setting.send_attack_threshold = nil
                race_setting.send_attack_threshold_deviation = nil
                race_setting.attack_meter = 0

                race_setting.flying_units = {
                    {'scout'}, -- Fast unit that uses in rapid target attack group
                    {'corsair'},
                    {'carrier','arbiter'}
                }
                race_setting.dropship = 'shuttle'
                ErmRaceSettingsHelper.add_unit_to_tier(race_setting, 2, 'shuttle')
            end

            race_setting.version = MOD_VERSION
        end
        remote.call('enemy_race_manager', 'update_race_setting', race_setting)
    end
end)



