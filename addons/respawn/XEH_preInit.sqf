#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

private _waitingRespawnEmptyArray= [[west,[]],[east,[]],[resistance,[]],[civilian,[]]];
private _waitTimesPreArray = [[west,0],[east,0],[resistance,0],[civilian,0]];
private _emptyFalseArray = [[west,false],[east,false],[resistance,false],[civilian,false]];
private _emptyTrueArray = [[west,true],[east,true],[resistance,true],[civilian,true]];
//cba_missiontime time when next wave happens.
GVAR(nextWaveTimes) = createHashMapFromArray _waitTimesPreArray;

//Respawn wave lenght times
GVAR(waveLenghtTimes) = createHashMap;

//Tickets
GVAR(tickets) = createHashMap;

//Waiting area stuff
GVAR(waitingArea) = createHashMap;

//Which side has respawn system started
GVAR(enabledSides) = createHashMapFromArray _emptyFalseArray;

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
    [localize "STR_tunres_Respawn_CBA_Enable", localize "STR_tunres_Respawn_CBA_tooltip_Enable"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    localize "STR_tunres_Respawn_CBA_Category_main", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(killJIP),
    "CHECKBOX",
    ["Kill JIP", localize "STR_tunres_Respawn_CBA_tooltip_killjip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(killJIP_time),
    "SLIDER",
    ["Kill JIP Time", localize "STR_tunres_Respawn_CBA_tooltip_killjip_time"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
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
    ["Respawn Type", localize "STR_tunres_Respawn_CBA_tooltip_respawntypes"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
    [[localize "STR_tunres_Respawn_Type_Default", localize "STR_tunres_Respawn_Type_Sidetickets", localize "STR_tunres_Respawn_Type_Playertickets"], [localize "STR_tunres_Respawn_Type_Default", localize "STR_tunres_Respawn_Type_Sidetickets", localize "STR_tunres_Respawn_Type_Playertickets"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(gearscriptType),
    "LIST",
    ["Gearscript type", localize "STR_tunres_Respawn_CBA_tooltip_gearscript"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
    [["SQF Gearscript", "Potato Tool", "Save gear"], ["SQF Gearscript", "Potato Tool", "Save gear"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(forced_respawn),
    "CHECKBOX",
    ["Only Forced Waves", localize "STR_tunres_Respawn_CBA_tooltip_forceRespawn"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(delayed_respawn),
    "SLIDER",
    ["Delayed respawn", localize "STR_tunres_Respawn_CBA_tooltip_delayed_respawn"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
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
    ["Waiting Area Range", localize "STR_tunres_Respawn_CBA_tooltip_waiting_area_range"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
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
    ["West", localize "STR_tunres_Respawn_CBA_tooltip_time"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_time"],
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
    ["East", localize "STR_tunres_Respawn_CBA_tooltip_time"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_time"],
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
    ["Resistance", localize "STR_tunres_Respawn_CBA_tooltip_time"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_time"],
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
    ["Civilian", localize "STR_tunres_Respawn_CBA_tooltip_time"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_time"],
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
    ["1st", localize "STR_tunres_Respawn_CBA_tooltip_specta_modes"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_cameramode"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(spectate_Cameramode_3th),
    "CHECKBOX",
    ["3th", localize "STR_tunres_Respawn_CBA_tooltip_specta_modes"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_cameramode"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(spectate_Cameramode_free),
    "CHECKBOX",
    ["Free", localize "STR_tunres_Respawn_CBA_tooltip_specta_modes"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_cameramode"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Ticket count
[
    QGVAR(tickets_west),
    "SLIDER",
    ["West", localize "STR_tunres_Respawn_CBA_tooltip_ticket"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_ticketcount"],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        GVAR(tickets) set [west, round _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(tickets_east),
    "SLIDER",
    ["East", localize "STR_tunres_Respawn_CBA_tooltip_ticket"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_ticketcount"],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        GVAR(tickets) set [east, round _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(tickets_guer),
    "SLIDER",
    ["Resistance", localize "STR_tunres_Respawn_CBA_tooltip_ticket"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_ticketcount"],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        GVAR(tickets) set [resistance, round _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(tickets_civ),
    "SLIDER",
    ["Civilian", localize "STR_tunres_Respawn_CBA_tooltip_ticket"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_ticketcount"],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        GVAR(tickets) set [civilian, round _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowCheckTicketsBase),
    "CHECKBOX",
    ["Main base", localize "STR_tunres_Respawn_CBA_tooltip_CheckTickets"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_checkTickets"],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Briefing notes
[
    QGVAR(briefingEnable),
    "CHECKBOX",
    [localize "STR_tunres_Respawn_CBA_Briefing_Enable", localize "STR_tunres_Respawn_CBA_Briefing_Enable_tooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_Briefing"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowRespawnType),
    "CHECKBOX",
    [localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowRespawType", localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowRespawType_tooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_Briefing"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowTickets),
    "CHECKBOX",
    [localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowTickets", localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowTickets_tooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_Briefing"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowTime),
    "CHECKBOX",
    [localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowTime", localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowTime_tooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_Briefing"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataWest),
    "CHECKBOX",
    [localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_West", localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_Briefing"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataEast),
    "CHECKBOX",
    [localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_East", localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_Briefing"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataResistance),
    "CHECKBOX",
    [localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_Resistance", localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_Briefing"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataCivilian),
    "CHECKBOX",
    [localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_Civilian", localize "STR_tunres_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_Briefing"],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

ADDON = true;