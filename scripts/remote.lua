---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 2/8/2023 9:02 PM
---
require("util")
local ErmConfig = require("__enemyracemanager__/lib/global_config")
local CustomAttacks = require("__erm_toss__/scripts/custom_attacks")

local RemoteAPI = {}

function RemoteAPI.milestones_preset_addons()
    --local boss_level = ErmConfig.BOSS_LEVELS
    local preset = {
        ["erm_toss"] = {
            required_mods = {"erm_toss"},
            milestones = {
                {type="group", name="Kills"},
                {type="kill", name="enemy_erm_toss--nexus--2",  quantity=1},
                {type="kill", name="enemy_erm_toss--nexus--3",  quantity=1},
                {type="kill", name="enemy_erm_toss--nexus--4",  quantity=1},
                {type="kill", name="enemy_erm_toss--nexus--5",  quantity=1, next="x10"},
            }
        },
    }

    --preset["erm_toss_boss"] = {
    --    required_mods = {"erm_toss"},
    --    milestones = {
    --        {type="group", name="ERM Boss Kills"},
    --        {type="kill", name="enemy_erm_toss--warpgate--"..boss_level[1],  quantity=1},
    --        {type="kill", name="enemy_erm_toss--warpgate--"..boss_level[2],  quantity=1},
    --        {type="kill", name="enemy_erm_toss--warpgate--"..boss_level[3],  quantity=1},
    --        {type="kill", name="enemy_erm_toss--warpgate--"..boss_level[4],  quantity=1},
    --        {type="kill", name="enemy_erm_toss--warpgate--"..boss_level[5],  quantity=1},
    --    }
    --}

    return preset
end

function RemoteAPI.print_global()
    helpers.write_file("erm_toss/erm-global.json",helpers.table_to_json(util.copy(storage)))
end

function RemoteAPI.register_new_enemy_race()
    return MOD_NAME
end

function RemoteAPI.refresh_custom_attack_cache()
    CustomAttacks.get_race_settings(MOD_NAME, true)
end

function RemoteAPI.interplanetary_attack_ignore_planets()
    return {'aiur'}
end

return RemoteAPI
