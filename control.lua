--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/20/2020
-- Time: 5:04 PM
-- To change this template use File | Settings | File Templates.
--

local Game = require('__stdlib__/stdlib/game')

ErmConfig =  require('__enemyracemanager__/lib/global_config')

local Event = require('__stdlib__/stdlib/event/event')
local String = require('__stdlib__/stdlib/utils/string')
local CustomAttacks = require('__erm_toss__/prototypes/custom_attacks')

require('__erm_toss__/global')
-- Constants


local createTossRace = function()
    local toss_force = game.forces[FORCE_NAME]
    if not toss_force then
        toss_force = game.create_force(FORCE_NAME)
    end

    toss_force.ai_controllable = true;
    toss_force.disable_research()
    toss_force.friendly_fire = false;
end

local addRaceSettings = function()
    if remote.call('enemy_race_manager','get_race', MOD_NAME) then
        return
    end
    local race_settings = {
        race = MOD_NAME,
        version = MOD_VERSION,
        level = 1, -- Race level
        tier = 1, -- Race tier
        evolution_point = 0,
        evolution_base_point = 0,
        angry_meter = 0, -- Build by killing their force (unit = 1, building = 10)
        send_attack_threshold = 2000, -- When threshold reach, sends attack to the base
        send_attack_threshold_deviation = 0.2,
        next_attack_threshold = 0, -- Used by system to calculate next move
        units = {
            {'zealot','dragoon'},
            {'scout','corsair','probe'},
            {'templar','darktemplar','archon','carrier','arbiter'},
        },
        current_units_tier = {},
        turrets = {
            {'cannon'},
            {},
            {},
        },
        current_turrets_tier = {},
        command_centers = {
            {'nexus'},
            {},
            {}
        },
        current_command_centers_tier = {},
        support_structures = {
            {'nexus', 'pylon', 'gateway', 'forge'},
            {'cybernetics_core', 'stargate', 'citadel_adun'},
            {'templar_archive','fleet_beacon','arbiter_tribunal'},
        },
        current_support_structures_tier = {},
    }

    race_settings.current_units_tier = race_settings.units[1]
    race_settings.current_turrets_tier = race_settings.turrets[1]
    race_settings.current_command_centers_tier = race_settings.command_centers[1]
    race_settings.current_support_structures_tier = race_settings.support_structures[1]

    remote.call('enemy_race_manager','register_race', race_settings)
end

Event.on_init(function(event)
    createTossRace()
    addRaceSettings()
end)

Event.on_load(function(event)
end)

Event.on_configuration_changed(function(event)
    createTossRace()
end)


Event.register(defines.events.on_script_trigger_effect, function (event)
    if not event.source_entity then
        return
    end

    if event.effect_id == PROBE_ATTACK then
        CustomAttacks.process_probe(event)
    end
end)



