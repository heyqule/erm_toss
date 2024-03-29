--
-- Created by IntelliJ IDEA.
-- User: heyqule
-- Date: 01/09/2020
-- Time: 1:04 AM
-- To change this template use File | Settings | File Templates.
--
local TossSound = {}

function TossSound.enemy_death(name, volume)
    return {
        filename = "__erm_toss__/sound/enemies/" .. name .. "/death.ogg",
        volume = volume
    }
end

function TossSound.ball_attack(volume)
    return {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/ball_attack_shared.ogg",
        volume = volume
    }
end

function TossSound.scout_attack_missile(volume)
    return {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/scout/scout_attack_missile.ogg",
        volume = volume
    }
end

function TossSound.scout_attack_pulse(volume)
    return {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/scout/scout_attack_pulse.ogg",
        volume = volume
    }
end

function TossSound.interceptor_attack(volume)
    return {
        audible_distance_modifier = 0.3,
        filename = "__erm_toss__/sound/enemies/carrier/interceptor.ogg",
        volume = volume
    }
end

function TossSound.interceptor_projectile(volume)
    return {
        audible_distance_modifier = 0.3,
        filename = "__erm_toss__/sound/enemies/interceptor/interceptor_projectile.ogg",
        volume = volume
    }
end

function TossSound.corsair_attack(volume)
    return {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/corsair/attack.ogg",
        volume = volume
    }
end

function TossSound.darktemplar_attack(volume)
    return {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/darktemplar/attack.ogg",
        volume = volume
    }
end

function TossSound.templar_attack(volume)
    return {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/templar/attack.ogg",
        volume = volume
    }
end

function TossSound.archon_attack(volume)
    return {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/archon/attack.ogg",
        volume = volume
    }
end

function TossSound.darkarchon_attack(volume)
    return {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/darkarchon/attack.ogg",
        volume = volume
    }
end

function TossSound.probe_attack(volume)
    return {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/probe/attack.ogg",
        volume = volume
    }
end

function TossSound.zealot_attack(volume)
    return
    {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/zealot/attack.ogg",
        volume = volume
    }
end

function TossSound.scarab_attack(volume)
    return
    {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/scarab/attack.ogg",
        volume = volume
    }
end

function TossSound.reaver_attack(volume)
    return
    {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/reaver/attack.ogg",
        volume = volume
    }
end

function TossSound.shuttle_drop(volume)
    return
    {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/enemies/shuttle/shuttle_drop.ogg",
        volume = volume
    }
end

function TossSound.building_dying_sound(volume)
    return {
        filename = "__erm_toss__/sound/buildings/explode_building.ogg",
        volume = volume
    }
end

function TossSound.shield_battery_ability(volume)
    return {
        audible_distance_modifier = 0.5,
        filename = "__erm_toss__/sound/buildings/shield_battery_ability.ogg",
        volume = volume
    }
end

function TossSound.shield_battery_idle(volume)
    return {
        audible_distance_modifier = 0.5,
        sound = {
            {
                filename = "__erm_toss__/sound/buildings/shield_battery.ogg",
                volume = volume
            },
        },
        probability = 1 / (15 * 60),
        max_sounds_per_type = 3,
    }
end

function TossSound.cannon_idle(volume)
    return {
        audible_distance_modifier = 0.5,
        sound = {
            {
                filename = "__erm_toss__/sound/buildings/cannon.ogg",
                volume = volume
            },
        },
        probability = 1 / (15 * 60),
        max_sounds_per_type = 3,
    }
end

function TossSound.building_working_sound(name, volume)
    return
    {
        audible_distance_modifier = 1,
        max_sounds_per_type = 3,
        sound = {
            filename = "__erm_toss__/sound/buildings/" .. name .. ".ogg",
            volume = volume
        },
        probability = 1 / (15 * 60)
    }
end

return TossSound
