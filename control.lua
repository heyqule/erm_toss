--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 12/20/2020
-- Time: 5:04 PM
-- To change this template use File | Settings | File Templates.
--
local String = require("__erm_libs__/stdlib/string")
local ForceHelper = require("__enemyracemanager__/lib/helper/force_helper")
local AttackGroupBeaconConstants = require("__enemyracemanager__/lib/attack_group_beacon_constants")

local CustomAttacks = require("__erm_toss__/scripts/custom_attacks")

require("__erm_toss__/global")
-- Constants
local using_lightning_units = script.active_mods['space-age']

local toss_on_fulgora = script.active_mods["space-age"] and
        settings.startup["enemy_erm_toss-on_fulgora"] and 
        settings.startup["enemy_erm_toss-on_fulgora"].value

local populations = {
    ["archon"] = 4,
    ["corsair"] = 2,
    ["arbiter"] = 3,
    ["dragoon"] = 1,
    ["zealot"] = 1,
    ["darktemplar"] = 2,
}

local refresh_army_data = function()
    -- Register Army Units
    for _, prototype in pairs(prototypes.get_entity_filtered({{filter = "type", type = "unit"}})) do
        local nameToken = String.split(prototype.name, "--")
        if nameToken[1] == MOD_NAME and nameToken[2] == 'controllable' and populations[nameToken[3]] then
            remote.call("enemyracemanager","army_units_register", prototype.name, populations[nameToken[3]]);
        end
    end

    -- Register Auto Deployers
    for _, prototype in pairs(prototypes.get_entity_filtered({{filter = "type", type = "assembling-machine"}})) do
        local nameToken = String.split(prototype.name, "--")
        if nameToken[1] == MOD_NAME and nameToken[2] == 'controllable' then
            remote.call("enemyracemanager","army_deployer_register", prototype.name);
        end
    end
end

local createRace = function()
    local force = game.forces[FORCE_NAME]
    if not force then
        force = game.create_force(FORCE_NAME)
    end

    force.ai_controllable = true;
    force.disable_research()
    force.friendly_fire = true;

    if settings.startup["enemyracemanager-free-for-all"].value then
        ForceHelper.set_friends(game, FORCE_NAME, false)
    else
        ForceHelper.set_friends(game, FORCE_NAME, true)
    end

    ForceHelper.set_neutral_force(game, FORCE_NAME)

    --- store units created by demolisher for additional evil processing. :)
    storage.lightning_units = storage.lightning_units or {}
    --- Queue for cleanup.
    storage.backlog_lightning_units = storage.backlog_lightning_units or {}

    --- for guerrilla tactic processing
    storage.guerrilla_distances = storage.guerrilla_distances or {}


    if script.active_mods['rso-mod'] then
        remote.call("RSO", "ignoreSurface", "aiur")
    end
end

local addRaceSettings = function()
    local race_settings = remote.call("enemyracemanager", "get_race", MOD_NAME)
    if race_settings == nil then
        race_settings = {}
    end

    race_settings.race =  race_settings.race or MOD_NAME
    race_settings.label = {"gui.label-erm_toss"}
    race_settings.tier =  race_settings.tier or 1
    race_settings.is_primitive = race_settings.is_primitive or false
    race_settings.autoplace_name = race_settings.autoplace_name or AUTOCONTROL_NAME
    race_settings.attack_meter = race_settings.attack_meter or 0
    race_settings.attack_meter_total = race_settings.attack_meter_total or 0
    race_settings.last_attack_meter_total = race_settings.last_attack_meter_total or 0
    race_settings.next_attack_threshold = race_settings.next_attack_threshold or 0

    race_settings.units = {
        { "zealot", "dragoon" },
        { "scout", "corsair", "probe", "shuttle", "darktemplar" },
        { "templar", "archon", "darkarchon", "carrier", "arbiter", "reaver" },
    }
    race_settings.turrets = {
        { "cannon", "acid-cannon" },
        { "shield_battery"},
        {},
    }
    race_settings.command_centers = {
        { "nexus" },
        {},
        {}
    }
    race_settings.support_structures = {
        { "pylon", "gateway", "forge" },
        { "cybernetics_core", "stargate", "citadel_adun", "robotics_facility" },
        { "templar_archive", "fleet_beacon", "arbiter_tribunal","robotics_support_bay" },
    }
    race_settings.flying_units = {
        {"scout"},
        {"corsair"},
        {"carrier","arbiter"}
    }
    race_settings.timed_units = {
        interceptor=true,
        scarab=true
    }
    race_settings.builder = 'probe'
    race_settings.dropship = "shuttle"
    race_settings.droppable_units = {
        {{ "dragoon" },{1}},
        {{ "dragoon", "darktemplar", "invis_darktemplar" },{5,3,1}},
        {{ "dragoon", "darktemplar", "templar", "archon", "darkarchon", "reaver", "invis_darktemplar"},{9,6,2,1,1,1,1}},
    }
    race_settings.construction_buildings = {
        {{ "cannon_shortrange"},{1}},
        {{ "cannon_shortrange", "pylon"},{5,2}},
        {{ "cannon_shortrange", "pylon", "shield_battery_shortrange"},{5,2,1}},
    }
    race_settings.featured_groups = {
        -- Unit list, spawn ratio, unit attack point cost
        {{"zealot", "dragoon"}, {6, 3}, 25},
        {{"zealot", "archon"}, {6, 3}, 35},
        {{"zealot", "dragoon", "archon", "reaver"}, {4, 3, 2, 1}, 30},
        {{"dragoon","templar", "archon", "darkarchon"}, {5, 1, 1, 1}, 40},
        {{"darktemplar","templar","archon", "invis_darktemplar"}, {4, 1, 2, 1}, 50},
        {{"zealot","dragoon","darktemplar","templar","archon","darkarchon", "invis_darktemplar"}, {5,5,2,1,1,1,1}, 25},
        {{"zealot","dragoon","darktemplar","templar","archon","darkarchon", "reaver", "invis_darktemplar"}, {5,5,3,2,1,1,1,1}, 25},
        {{"zealot", "darktemplar", "invis_darktemplar"}, {2, 1, 1}, 50} -- 60 units per 3000 points group, since invisibility only apply to turrets.
    }
    race_settings.featured_flying_groups = {
        {{"scout", "corsair"}, {1, 1}, 60},
        {{"scout", "carrier"}, {7, 1}, 75},
        {{"corsair", "arbiter"}, {5, 1}, 75},
        {{"scout", "corsair", "carrier", "arbiter"}, {3,3,1,1}, 75},
        {{"scout", "carrier", "shuttle"}, {4, 1, 2}, 75},
        {{"shuttle", "scout"}, {1, 2}, 150},
        {{"arbiter", "scout"}, {1, 2}, 200}
    }

    race_settings.boss_building = "boss-warpgate"
    race_settings.pathing_unit = "zealot"
    race_settings.colliding_unit = "archon"
    race_settings.home_planet = "aiur"
    
    race_settings.interplanetary_attack_active = race_settings.interplanetary_attack_active or false
    
    race_settings.boss_tier = race_settings.boss_tier or 1
    race_settings.boss_kill_count = race_settings.boss_kill_count or 0

    race_settings.structure_killed_count_by_planet = race_settings.structure_killed_count_by_planet or {}
    race_settings.unit_killed_count_by_planet = race_settings.unit_killed_count_by_planet or {}


    remote.call("enemyracemanager", "register_race", race_settings)

    CustomAttacks.get_race_settings(MOD_NAME, true)
end

local update_world = function()
    --- Insert autoplace into existing fulgora surface
    local fulgora = game.surfaces["fulgora"]
    if fulgora and settings.startup["enemy_erm_toss-on_fulgora"] and settings.startup["enemy_erm_toss-on_fulgora"].value
    then
        --- =_= map_gen_settings write only support writing the whole block.
        local map_gen = fulgora.map_gen_settings
        map_gen.autoplace_controls[AUTOCONTROL_NAME] =
        fulgora.planet.prototype.map_gen_settings.autoplace_controls[AUTOCONTROL_NAME]
        fulgora.map_gen_settings = map_gen
    end
end

script.on_init(function(event)
    createRace()
    addRaceSettings()
    update_world()
    refresh_army_data()
end)

script.on_load(function(event)
end)

script.on_configuration_changed(function(event)
    createRace()
    addRaceSettings()
    update_world()
    refresh_army_data()
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
    end,
    [GUERRILLA_ATTACK] = function(args)
        CustomAttacks.process_guerrilla(args)
    end,
    [CRYSTAL_TRIGGER] = function(args)
        CustomAttacks.process_crystal(args)
    end
}
script.on_event(defines.events.on_script_trigger_effect, function(event)
    if  attack_functions[event.effect_id] and
            CustomAttacks.valid(event, MOD_NAME)
    then
        attack_functions[event.effect_id](event)
    end
end)

local is_compatible_lightning = {
    ["enemy_erm_toss--fulgora-lightning"] =  true,
    ["enemy_erm_toss--aiur-lightning"] =  true,
}

local beacon
local beacon_hit = 0

local on_trigger_created_entity_handlers = {
    ["lightning"] = function(entity, source)
        if is_compatible_lightning[source.name] then
            entity.force = FORCE_NAME
            local surface_name = entity.surface.name
            if storage.lightning_units[surface_name] == nil then
                storage.lightning_units[surface_name] = {}
            end

            storage.lightning_units[surface_name][entity.unit_number] = {
                entity = entity,
                tick = game.tick
            }
        end

        if entity.commandable then
            remote.call("enemyracemanager", "process_attack_position", {
                group = entity.commandable,
                distraction = defines.distraction.by_enemy,
            })
        end
    end
}

script.on_event(defines.events.on_trigger_created_entity, function(event)
    local entity = event.entity
    local source = event.source
    if source and entity.valid and on_trigger_created_entity_handlers[source.type] then
        on_trigger_created_entity_handlers[source.type](entity, source)
    end
end)


script.on_nth_tick(901, function(event)
    CustomAttacks.clear_time_to_live_units(event)

    if using_lightning_units then
        CustomAttacks.lightning_units_attack()
    end
end)

--- Spawn attack group periodically once evolution reach 10%
script.on_nth_tick(13 * minute + 13, function(event)
    local fulgora = game.surfaces['fulgora']
    if fulgora and toss_on_fulgora and CustomAttacks.can_spawn(40) then
        if game.forces[FORCE_NAME].get_evolution_factor(fulgora) < 0.1 then
            return
        end

        local has_entity =  fulgora.count_entities_filtered({type=AttackGroupBeaconConstants.ATTACKABLE_ENTITY_TYPES, limit = 1})
        if has_entity < 1 then
            return
        end

        if CustomAttacks.can_spawn(15) then
            remote.call("enemyracemanager", "generate_dropship_group", FORCE_NAME, 10, {surface=fulgora})
        elseif CustomAttacks.can_spawn(40) then
            remote.call("enemyracemanager", "generate_flying_group", FORCE_NAME, 20, {surface=fulgora})
        else
            remote.call("enemyracemanager", "generate_attack_group", FORCE_NAME, 50, {surface=fulgora})
        end
    end
end)

local ErmBossAttack = require("scripts/boss_attacks")
remote.add_interface("erm_toss_boss_attacks", {
    get_attack_data = ErmBossAttack.get_attack_data,
})

local RemoteApi = require("scripts/remote")
remote.add_interface("erm_toss", RemoteApi)

