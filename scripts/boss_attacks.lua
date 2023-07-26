---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by heyqule.
--- DateTime: 8/28/2022 8:19 PM
---
local ErmBossAttackRemote = require('__enemyracemanager__/lib/boss_attack_data')
local ErmBossAttackProcessor = require('__enemyracemanager__/lib/boss_attack_processor')

ErmBossAttackRemote.basic_attacks =
{
    projectile_name = {'psystorm','stasis','cold-fire'},
    projectile_type = {
        ErmBossAttackProcessor.TYPE_PROJECTILE,
        ErmBossAttackProcessor.TYPE_PROJECTILE,
        ErmBossAttackProcessor.TYPE_PROJECTILE
    },
    projectile_chance = {25, 25, 100},
    projectile_count = {2, 2, 5},
    projectile_spread = {1, 1, 2},
    projectile_use_multiplier = {false, false, true},
    projectile_count_multiplier = {
        {},
        {},
        {1, 1, 1, 2, 3}
    },
    projectile_spread_multiplier = {
        {},
        {},
        {1, 1, 1, 1, 1}
    },
}

ErmBossAttackRemote.advanced_attacks =
{
    projectile_name = {'recall-'..UNITS_SPAWN_ATTACK, 'cold-star'},
    projectile_type = {
        ErmBossAttackProcessor.TYPE_PROJECTILE,
        ErmBossAttackProcessor.TYPE_PROJECTILE,
    },
    projectile_chance = {25, 100},
    projectile_count = {1, 2},
    projectile_spread = {1, 2},
    projectile_use_multiplier = {false},
    projectile_count_multiplier = {
        {},
    },
    projectile_spread_multiplier = {
        {},
    },
}

ErmBossAttackRemote.super_attacks =
{
    projectile_name = {'recall-'..BOSS_SPAWN_ATTACK},
    projectile_type = {
        ErmBossAttackProcessor.TYPE_PROJECTILE,
    },
    projectile_chance = {100},
    projectile_count = {1},
    projectile_spread = {1},
    projectile_use_multiplier = {false},
    projectile_count_multiplier = {
        {},
    },
    projectile_spread_multiplier = {
        {},
    },
}


ErmBossAttackRemote.despawn_attacks =
{
    projectile_name = {'recall-'..UNITS_SPAWN_ATTACK},
    projectile_type = {
        ErmBossAttackProcessor.TYPE_PROJECTILE,
    },
    projectile_chance = {100},
    projectile_count = {1},
    projectile_spread = {8},
    projectile_use_multiplier = {false},
    projectile_count_multiplier = {
        {},
    },
    projectile_spread_multiplier = {
        {},
    },
}

return ErmBossAttackRemote