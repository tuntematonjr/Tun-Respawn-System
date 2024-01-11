#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

private _waitingRespawnEmptyArray= [[west,[]],[east,[]],[resistance,[]],[civilian,[]]];
private _waitTimesPreArray = [[west,0],[east,0],[resistance,0],[civilian,0]];
private _emptyFalseArray = [[west,false],[east,false],[resistance,false],[civilian,false]];
private _emptyTrueArray = [[west,true],[east,true],[resistance,true],[civilian,true]];
//Remaining time for wave.

GVAR(nextWaveTimes) = createHashMapFromArray _waitTimesPreArray;

//Respawn wave lenght times
GVAR(waveLenghtTimes) = createHashMap;

//Respawn waiting area unit arrays
GVAR(waitingRespawnList) = createHashMapFromArray _waitingRespawnEmptyArray;
GVAR(waitingRespawnDelayedList) = createHashMapFromArray _waitingRespawnEmptyArray;

//Total respawn count (log stuff)
GVAR(totalRespawnCount) = createHashMapFromArray _waitTimesPreArray;

//Allow respawn for each side
GVAR(allowRespawn) = createHashMapFromArray _emptyTrueArray;

GVAR(disconnected_players) = createHashMapFromArray _waitingRespawnEmptyArray;
GVAR(timerRunning) = createHashMapFromArray _emptyFalseArray;
ISNILS(GVAR(teleportPoints),[]);

//allowed sides to spectate !WIP! Currentlu forced all
ISNILS(GVAR(spectate_west),true);
ISNILS(GVAR(spectate_east),true);
ISNILS(GVAR(spectate_independent),true);
ISNILS(GVAR(spectate_civilian),true);

ISNILS(GVAR(endRespawns),false);

GVAR(selfTPmenuOpenObj) = objNull;

[
    QGVAR(enable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_tunres_Respawn_CBA_Enable" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_tooltip_Enable" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(killJIP),
    "CHECKBOX",
    ["Kill JIP", "STR_tunres_Respawn_CBA_tooltip_killjip" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(killJIP_time),
    "SLIDER",
    ["Kill JIP Time", "STR_tunres_Respawn_CBA_tooltip_killjip_time" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    [1, 300, 20, 0],
    1,
    {
        params ["_value"];
        GVAR(killJIP_time) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(respawn_type),
    "LIST",
    ["Respawn Type", "STR_tunres_Respawn_CBA_tooltip_respawntypes" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    [[localize "STR_tunres_Respawn_Type_Default", localize "STR_tunres_Respawn_Type_Sidetickets", localize "STR_tunres_Respawn_Type_Playertickets"], [localize "STR_tunres_Respawn_Type_Default", localize "STR_tunres_Respawn_Type_Sidetickets", localize "STR_tunres_Respawn_Type_Playertickets"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(gearscriptType),
    "LIST",
    ["Gearscript type", "STR_tunres_Respawn_CBA_tooltip_gearscript" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    [["SQF Gearscript", "Potato Tool", "Save gear"], ["SQF Gearscript", "Potato Tool", "Save gear"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(forced_respawn),
    "CHECKBOX",
    ["Only Forced Waves", "STR_tunres_Respawn_CBA_tooltip_forceRespawn" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(delayed_respawn),
    "SLIDER",
    ["Delayed respawn", "STR_tunres_Respawn_CBA_tooltip_delayed_respawn" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    [0, 100, 0, 0],
    1,
    {
        params ["_value"];
        GVAR(delayed_respawn) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(waiting_area_range),
    "SLIDER",
    ["Waiting Area Range", "STR_tunres_Respawn_CBA_tooltip_waiting_area_range" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    [30, 300, 100, 0],
    1,
    {
        params ["_value"];
        GVAR(waiting_area_range) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

//Wave times
[
    QGVAR(time_west),
    "SLIDER",
    ["West", "STR_tunres_Respawn_CBA_tooltip_time" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_time" call BIS_fnc_localize],
    [1, 60, 15, 0],
    1,
    {
        params ["_value"];
        GVAR(waveLenghtTimes) set [west, round _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(time_east),
    "SLIDER",
    ["East", "STR_tunres_Respawn_CBA_tooltip_time" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_time" call BIS_fnc_localize],
    [1, 60, 15, 0],
    1,
    {
        params ["_value"];
        GVAR(waveLenghtTimes) set [east, round _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(time_guer),
    "SLIDER",
    ["Resistance", "STR_tunres_Respawn_CBA_tooltip_time" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_time" call BIS_fnc_localize],
    [1, 60, 15, 0],
    1,
    {
        params ["_value"];
        GVAR(waveLenghtTimes) set [resistance, round _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(time_civ),
    "SLIDER",
    ["Civilian", "STR_tunres_Respawn_CBA_tooltip_time" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_time" call BIS_fnc_localize],
    [1, 60, 15, 0],
    1,
    {
        params ["_value"];
        GVAR(waveLenghtTimes) set [civilian, round _value];
    },
    true
] call CBA_Settings_fnc_init;

//Spectator camera modes
[
    QGVAR(spectate_Cameramode_1st),
    "CHECKBOX",
    ["1st", "STR_tunres_Respawn_CBA_tooltip_specta_modes" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_spectate_cameramode" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(spectate_Cameramode_3th),
    "CHECKBOX",
    ["3th", "STR_tunres_Respawn_CBA_tooltip_specta_modes" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_spectate_cameramode" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(spectate_Cameramode_free),
    "CHECKBOX",
    ["Free", "STR_tunres_Respawn_CBA_tooltip_specta_modes" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_spectate_cameramode" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Ticket count
[
    QGVAR(tickets_west),
    "SLIDER",
    ["West", "STR_tunres_Respawn_CBA_tooltip_ticket" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_ticketcount" call BIS_fnc_localize],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        GVAR(tickets_west) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(tickets_east),
    "SLIDER",
    ["East", "STR_tunres_Respawn_CBA_tooltip_ticket" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_ticketcount" call BIS_fnc_localize],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        GVAR(tickets_east) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(tickets_guer),
    "SLIDER",
    ["Resistance", "STR_tunres_Respawn_CBA_tooltip_ticket" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_ticketcount" call BIS_fnc_localize],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        GVAR(tickets_guer) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(tickets_civ),
    "SLIDER",
    ["Civilian", "STR_tunres_Respawn_CBA_tooltip_ticket" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_ticketcount" call BIS_fnc_localize],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        GVAR(tickets_civ) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowCheckTicketsBase),
    "CHECKBOX",
    ["Main base", "STR_tunres_Respawn_CBA_tooltip_CheckTickets" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_checkTickets" call BIS_fnc_localize],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Briefing notes
[
    QGVAR(briefingEnable),
    "CHECKBOX",
    ["STR_tunres_Respawn_CBA_Briefing_Enable" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Briefing_Enable_tooltip" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowRespawnType),
    "CHECKBOX",
    ["STR_tunres_Respawn_CBA_Briefing_Enable_ShowRespawType" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Briefing_Enable_ShowRespawType_tooltip" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowTickets),
    "CHECKBOX",
    ["STR_tunres_Respawn_CBA_Briefing_Enable_ShowTickets" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Briefing_Enable_ShowTickets_tooltip" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowTime),
    "CHECKBOX",
    ["STR_tunres_Respawn_CBA_Briefing_Enable_ShowTime" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Briefing_Enable_ShowTime_tooltip" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataWest),
    "CHECKBOX",
    ["STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_West" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataEast),
    "CHECKBOX",
    ["STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_East" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataResistance),
    "CHECKBOX",
    ["STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_Resistance" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataCivilian),
    "CHECKBOX",
    ["STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_Civilian" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip" call BIS_fnc_localize],
    ["STR_tunres_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

ADDON = true;