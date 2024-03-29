require 'global'

table.insert(data.raw["string-setting"]["enemyracemanager-2way-group-enemy-positive"].allowed_values, MOD_NAME)
table.insert(data.raw["string-setting"]["enemyracemanager-2way-group-enemy-negative"].allowed_values, MOD_NAME)

table.insert(data.raw["string-setting"]["enemyracemanager-4way-top-left"].allowed_values, MOD_NAME)
table.insert(data.raw["string-setting"]["enemyracemanager-4way-top-right"].allowed_values, MOD_NAME)
table.insert(data.raw["string-setting"]["enemyracemanager-4way-bottom-right"].allowed_values, MOD_NAME)
table.insert(data.raw["string-setting"]["enemyracemanager-4way-bottom-left"].allowed_values, MOD_NAME)

table.insert(data.raw["string-setting"]["enemyracemanager-menu-replacement-race"].allowed_values, MOD_NAME)
data.raw["string-setting"]["enemyracemanager-menu-replacement-race"].default_value = MOD_NAME

if mods['Krastorio2'] then
    data:extend {
        {
            type = "bool-setting",
            name = "erm_toss-k2-creep",
            description = "erm_toss-k2-creep",
            setting_type = "startup",
            default_value = true,
            order = "erm_toss-120",
        },
    }
end

if mods['erm_toss_hd'] then
    data:extend {
        {
            type = "bool-setting",
            name = "erm_toss-team_color_enable",
            description = "erm_toss-team_color_enable",
            setting_type = "startup",
            default_value = true,
            order = "erm_toss-110",
        },
        {
            type = "color-setting",
            name = "erm_toss-team_color",
            description = "erm_toss-team_color",
            setting_type = "startup",
            default_value = PROTOSS_TEAM_COLOR,
            order = "erm_toss-111",
        },
        {
            type = "int-setting",
            name = "erm_toss-team_blend_mode",
            description = "erm_toss-team_blend_mode",
            setting_type = "startup",
            default_value = 3,
            order = "erm_toss-112",
            allowed_values = { 1,2,3,4,5,6 },
        },
        {
            type = "bool-setting",
            name = "erm_toss-team_color_preserve_gloss",
            description = "erm_toss-team_color_preserve_gloss",
            setting_type = "startup",
            default_value = false,
            order = "erm_toss-113",
        },
        {
            type = "bool-setting",
            name = "erm_toss-enable_floor_decals",
            description = "erm_toss-enable_floor_decals",
            setting_type = "startup",
            default_value = true,
            order = "erm_toss-115",
        },
    }
end
