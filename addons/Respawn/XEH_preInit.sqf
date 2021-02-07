#include "script_component.hpp"
#include "XEH_prep.sqf"

//Remaining time for wave.
ISNILS(GVAR(wait_time_west),0);
ISNILS(GVAR(wait_time_east),0);
ISNILS(GVAR(wait_time_guer),0);
ISNILS(GVAR(wait_time_civ),0);

ISNILS(GVAR(allow_respawn_west),true);
ISNILS(GVAR(allow_respawn_east),true);
ISNILS(GVAR(allow_respawn_guer),true);
ISNILS(GVAR(allow_respawn_civ),true);

ISNILS(GVAR(disconnected_players),[]);

ISNILS(GVAR(timer_running),[]);
ISNILS(GVAR(teleportPoints),[]);

//allowed sides to spectate !WIP!
/*ISNILS(GVAR(spectate_west),true);
ISNILS(GVAR(spectate_east),true);
ISNILS(GVAR(spectate_independent),true);
ISNILS(GVAR(spectate_civilian),true);*/


//Main settings
[
    QGVAR(enable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_Respawn_CBA_Enable", localize "STR_Tun_Respawn_CBA_tooltip_Enable"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
   localize "STR_Tun_Respawn_CBA_Category_main", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(killJIP), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Kill JIP", localize "STR_Tun_Respawn_CBA_tooltip_killjip"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_generic"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(killJIP_time), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Kill JIP Time", localize "STR_Tun_Respawn_CBA_tooltip_killjip_time"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_generic"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 300, 20, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(respawn_type), // Unique setting name. Matches resulting variable name <STRING>
    "LIST", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Respawn Type", localize "STR_Tun_Respawn_CBA_tooltip_respawntypes"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_generic"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [["default", "Sidetickets"], ["default", "Sidetickets"], 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(use_gearscript), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Use Gearscript", localize "STR_Tun_Respawn_CBA_tooltip_gearscript"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_generic"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(forced_respawn), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Only Forced Waves", localize "STR_Tun_Respawn_CBA_tooltip_forceRespawn"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_generic"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(delayed_respawn), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Delayed respawn", localize "STR_Tun_Respawn_CBA_tooltip_delayed_respawn"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_generic"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 100, 0, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(waiting_area_range), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Waiting Area Range", localize "STR_Tun_Respawn_CBA_tooltip_waiting_area_range"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_generic"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [30, 300, 100, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


//Wave times
[
    QGVAR(time_west), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["West", localize "STR_Tun_Respawn_CBA_tooltip_time"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_time"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 60, 15, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(time_east), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["East", localize "STR_Tun_Respawn_CBA_tooltip_time"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_time"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 60, 15, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(time_guer), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Resistance", localize "STR_Tun_Respawn_CBA_tooltip_time"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_time"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 60, 15, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(time_civ), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Civilian", localize "STR_Tun_Respawn_CBA_tooltip_time"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_time"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 60, 15, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

//Spectator camera modes
[
    QGVAR(spectate_Cameramode_1st), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["1st", localize "STR_Tun_Respawn_CBA_tooltip_specta_modes"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_spectate_cameramode"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(spectate_Cameramode_3th), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["3th", localize "STR_Tun_Respawn_CBA_tooltip_specta_modes"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_spectate_cameramode"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(spectate_Cameramode_free), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Free", localize "STR_Tun_Respawn_CBA_tooltip_specta_modes"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_spectate_cameramode"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


//Ticket count
[
    QGVAR(tickets_west), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["West", localize "STR_Tun_Respawn_CBA_tooltip_ticket"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_ticketcount"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 1000, 0, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(tickets_east), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["East", localize "STR_Tun_Respawn_CBA_tooltip_ticket"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_ticketcount"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 1000, 0, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(tickets_guer), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Resistance", localize "STR_Tun_Respawn_CBA_tooltip_ticket"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_ticketcount"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 1000, 0, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(tickets_civ), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Civilian", localize "STR_Tun_Respawn_CBA_tooltip_ticket"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_Respawn_CBA_Category_main", localize "STR_Tun_Respawn_CBA_Category_ticketcount"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 1000, 0, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;