#include "script_component.hpp"
#include "XEH_prep.sqf"

//Remaining time for wave.
ISNILS(GVAR(wait_time_west),0);
ISNILS(GVAR(wait_time_east),0);
ISNILS(GVAR(wait_time_guer),0);
ISNILS(GVAR(wait_time_civ),0);

ISNILS(GVAR(totalRespawnCountWest),0);
ISNILS(GVAR(totalRespawnCountEast),0);
ISNILS(GVAR(totalRespawnCountGuer),0);
ISNILS(GVAR(totalRespawnCountCiv),0);

ISNILS(GVAR(allow_respawn_west),true);
ISNILS(GVAR(allow_respawn_east),true);
ISNILS(GVAR(allow_respawn_guer),true);
ISNILS(GVAR(allow_respawn_civ),true);

ISNILS(GVAR(waitingRespawnWest),[]);
ISNILS(GVAR(waitingRespawnEast),[]);
ISNILS(GVAR(waitingRespawnGuer),[]);
ISNILS(GVAR(waitingRespawnCiv),[]);

ISNILS(GVAR(waitingRespawnDelayedWest),[]);
ISNILS(GVAR(waitingRespawnDelayedEast),[]);
ISNILS(GVAR(waitingRespawnDelayedGuer),[]);
ISNILS(GVAR(waitingRespawnDelayedCiv),[]);

ISNILS(GVAR(disconnected_players),[]);

ISNILS(GVAR(timer_running),[]);
ISNILS(GVAR(teleportPoints),[]);

//allowed sides to spectate !WIP! Currentlu forced all
ISNILS(GVAR(spectate_west),true);
ISNILS(GVAR(spectate_east),true);
ISNILS(GVAR(spectate_independent),true);
ISNILS(GVAR(spectate_civilian),true);

ISNILS(GVAR(endRespawns),false);

//Main settings
[
    QGVAR(enable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_Respawn_CBA_Enable" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_tooltip_Enable" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(killJIP), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Kill JIP", "STR_Tun_Respawn_CBA_tooltip_killjip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(killJIP_time), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Kill JIP Time", "STR_Tun_Respawn_CBA_tooltip_killjip_time" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 300, 20, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(respawn_type), // Unique setting name. Matches resulting variable name <STRING>
    "LIST", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Respawn Type", "STR_Tun_Respawn_CBA_tooltip_respawntypes" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [["default", "Sidetickets"], ["default", "Sidetickets"], 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(gearscriptType), // Unique setting name. Matches resulting variable name <STRING>
    "LIST", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Gearscript type", "STR_Tun_Respawn_CBA_tooltip_gearscript" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [["SQF Gearscript", "Potato Tool", "Save gear"], ["SQF Gearscript", "Potato Tool", "Save gear"], 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(forced_respawn), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Only Forced Waves", "STR_Tun_Respawn_CBA_tooltip_forceRespawn" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(delayed_respawn), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Delayed respawn", "STR_Tun_Respawn_CBA_tooltip_delayed_respawn" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 100, 0, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(waiting_area_range), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Waiting Area Range", "STR_Tun_Respawn_CBA_tooltip_waiting_area_range" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [30, 300, 100, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


//Wave times
[
    QGVAR(time_west), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["West", "STR_Tun_Respawn_CBA_tooltip_time" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_time" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 60, 15, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(time_east), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["East", "STR_Tun_Respawn_CBA_tooltip_time" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_time" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 60, 15, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(time_guer), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Resistance", "STR_Tun_Respawn_CBA_tooltip_time" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_time" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 60, 15, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(time_civ), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Civilian", "STR_Tun_Respawn_CBA_tooltip_time" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_time" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 60, 15, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

//Spectator camera modes
[
    QGVAR(spectate_Cameramode_1st), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["1st", "STR_Tun_Respawn_CBA_tooltip_specta_modes" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_spectate_cameramode" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(spectate_Cameramode_3th), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["3th", "STR_Tun_Respawn_CBA_tooltip_specta_modes" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_spectate_cameramode" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(spectate_Cameramode_free), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Free", "STR_Tun_Respawn_CBA_tooltip_specta_modes" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_spectate_cameramode" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


//Ticket count
[
    QGVAR(tickets_west), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["West", "STR_Tun_Respawn_CBA_tooltip_ticket" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_ticketcount" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 1000, 0, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(tickets_east), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["East", "STR_Tun_Respawn_CBA_tooltip_ticket" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_ticketcount" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 1000, 0, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(tickets_guer), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Resistance", "STR_Tun_Respawn_CBA_tooltip_ticket" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_ticketcount" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 1000, 0, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(tickets_civ), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Civilian", "STR_Tun_Respawn_CBA_tooltip_ticket" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_ticketcount" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 1000, 0, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(allowCheckTicketsBase), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["Main base", "STR_Tun_Respawn_CBA_tooltip_CheckTickets" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_checkTickets" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


//Briefing notes
[
    QGVAR(briefingEnable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_Respawn_CBA_Briefing_Enable" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowRespawnType), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowRespawType" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowRespawType_tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowTickets), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowTickets" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowTickets_tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowTime), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowTime" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowTime_tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;



[
    QGVAR(briefingEnableShowOtherSidesDataWest), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_West" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataEast), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_East" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataResistance), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_Resistance" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataCivilian), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_Civilian" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;