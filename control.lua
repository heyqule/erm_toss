--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/20/2020
-- Time: 5:04 PM
-- To change this template use File | Settings | File Templates.
--

local Game = require('__stdlib__/stdlib/game')
local ForceHelper = require('__enemyracemanager__/lib/helper/force_helper')
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

    ForceHelper.set_friends(game, FORCE_NAME)
end

local addRaceSettings = function()
    if remote.call('enemy_race_manager', 'get_race', MOD_NAME) then
        return
    end
    local race_settings = {
        race = MOD_NAME,
        version = MOD_VERSION,
        level = 1, -- Race level
        tier = 1, -- Race tier
        evolution_point = 0, -- For internal use
        evolution_base_point = 0, -- For internal use
        angry_meter = 0, -- Build by killing their force (Spawner = 20, turrets = 10)
        send_attack_threshold = 2000, -- When threshold reach, sends attack to the base
        send_attack_threshold_deviation = 0.2,
        next_attack_threshold = 0, -- Used by system to calculate next move
        units = {
            { 'zealot', 'dragoon' },
            { 'scout', 'corsair', 'probe' },
            { 'templar', 'darktemplar', 'archon', 'carrier', 'arbiter' },
        },
        current_units_tier = {},
        turrets = {
            { 'cannon', 'acid-cannon' },
            {},
            {},
        },
        current_turrets_tier = {},
        command_centers = {
            { 'nexus' },
            {},
            {}
        },
        current_command_centers_tier = {},
        support_structures = {
            { 'pylon', 'gateway', 'forge' },
            { 'cybernetics_core', 'stargate', 'citadel_adun' },
            { 'templar_archive', 'fleet_beacon', 'arbiter_tribunal' },
        },
        current_support_structures_tier = {},
    }

    race_settings.current_units_tier = race_settings.units[1]
    race_settings.current_turrets_tier = race_settings.turrets[1]
    race_settings.current_command_centers_tier = race_settings.command_centers[1]
    race_settings.current_support_structures_tier = race_settings.support_structures[1]

    remote.call('enemy_race_manager', 'register_race', race_settings)
end

Event.on_init(function(event)
    createRace()
    addRaceSettings()
end)

Event.on_load(function(event)
end)

Event.on_configuration_changed(function(event)
    createRace()
    -- Mod Compatibility Upgrade for race settings
    Event.dispatch({
        name = Event.get_event_name(ErmConfig.RACE_SETTING_UPDATE), affected_race = MOD_NAME })
end)

Event.register(defines.events.on_script_trigger_effect, function(event)
    if not event.source_entity then
        return
    end

    if event.effect_id == PROBE_ATTACK then
        CustomAttacks.process_probe(event)
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
                ErmRaceSettingsHelper.remove_structure_to_tier(race_setting, 1, 'nexus')
                ErmRaceSettingsHelper.add_turrets_to_tier(race_setting, 1, 'acid-cannon')
            end

            race_setting.version = MOD_VERSION
        end
        remote.call('enemy_race_manager', 'update_race_setting', race_setting)
    end
end)



