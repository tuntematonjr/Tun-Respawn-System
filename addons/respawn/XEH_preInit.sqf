#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;


//cba_missiontime time when next wave happens.
GVAR(nextWaveTimes) = createHashMapFromArray ZEROS_FOR_SIDES;

//Respawn wave lenght times
GVAR(waveLenghtTimes) = createHashMap;

//Tickets
GVAR(tickets) = createHashMap;

//Waiting area stuff
GVAR(waitingArea) = createHashMap;

//Which side has respawn system started
GVAR(enabledSides) = createHashMapFromArray FALSES_FOR_SIDES;

//Allow respawn for each side
GVAR(allowRespawn) = createHashMapFromArray TRUES_FOR_SIDES;

GVAR(timerRunning) = createHashMapFromArray FALSES_FOR_SIDES;
ISNILS(GVAR(teleportPoints),[]);

//allowed sides to spectate 
GVAR(allowedSpectateSidesWest) = [west];
GVAR(allowedSpectateSidesEast) = [east];
GVAR(allowedSpectateSidesResistance) = [resistance];
GVAR(allowedSpectateSidesCivilian) = [civilian];

//flag poles [mainbase,waitingrea]
GVAR(flagPoles) = createHashMapFromArray [[west,[objNull,objNull]],[east,[objNull,objNull]],[resistance,[objNull,objNull]],[civilian,[objNull,objNull]]];





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
    QGVAR(killJipTime),
    "SLIDER",
    ["Kill JIP Time", localize "STR_tunres_Respawn_CBA_tooltip_killJipTime"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
    [1, 300, 20, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(killJipTime) = _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(respawnType),
    "LIST",
    ["Respawn Type", localize "STR_tunres_Respawn_CBA_tooltip_respawntypes"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
    [[0, 1, 2], [localize "STR_tunres_Respawn_Type_Default", localize "STR_tunres_Respawn_Type_Sidetickets", localize "STR_tunres_Respawn_Type_Playertickets"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(gearscriptType),
    "LIST",
    ["Gearscript type", localize "STR_tunres_Respawn_CBA_tooltip_gearscript"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
    [[0, 1, 2, 3], ["SQF Gearscript", "Potato Tool", "Save gear", "None"], 2],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(forcedRespawn),
    "CHECKBOX",
    ["Only Forced Waves", localize "STR_tunres_Respawn_CBA_tooltip_forceRespawn"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(delayedRespawn),
    "SLIDER",
    ["Delayed respawn", localize "STR_tunres_Respawn_CBA_tooltip_delayedRespawn"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
    [0, 100, 0, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(delayedRespawn) = _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(waitingAreaRange),
    "SLIDER",
    ["Waiting Area Range", localize "STR_tunres_Respawn_CBA_tooltip_waitingAreaRange"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_generic"],
    [30, 300, 100, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(waitingAreaRange) = _value;
    },
    true
] call CBA_Settings_fnc_init;

//Wave times
[
    QGVAR(initialWaveTimeWest),
    "SLIDER",
    ["West", localize "STR_tunres_Respawn_CBA_tooltip_time"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_time"],
    [1, 60, 15, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialWaveTimeWest) = _value;
        GVAR(waveLenghtTimes) set [west, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(initialWaveTimeEast),
    "SLIDER",
    ["East", localize "STR_tunres_Respawn_CBA_tooltip_time"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_time"],
    [1, 60, 15, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialWaveTimeEast) = _value;
        GVAR(waveLenghtTimes) set [east, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(initialWaveTimeResistance),
    "SLIDER",
    ["Resistance", localize "STR_tunres_Respawn_CBA_tooltip_time"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_time"],
    [1, 60, 15, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialWaveTimeResistance) = _value;
        GVAR(waveLenghtTimes) set [resistance, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(initialWaveTimeCivilian),
    "SLIDER",
    ["Civilian", localize "STR_tunres_Respawn_CBA_tooltip_time"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_time"],
    [1, 60, 15, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialWaveTimeCivilian) = _value;
        GVAR(waveLenghtTimes) set [civilian, _value];
    },
    true
] call CBA_Settings_fnc_init;

//Spectator camera modes
[
    QGVAR(spectateCameramode1st),
    "CHECKBOX",
    ["1st", localize "STR_tunres_Respawn_CBA_tooltip_specta_modes"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_cameramode"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(spectateCameramode3th),
    "CHECKBOX",
    ["3th", localize "STR_tunres_Respawn_CBA_tooltip_specta_modes"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_cameramode"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(spectateCameramodeFree),
    "CHECKBOX",
    ["Free", localize "STR_tunres_Respawn_CBA_tooltip_specta_modes"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_cameramode"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//allow spectate west
[
    QGVAR(allowWestSpectateEast),
    "CHECKBOX",
    ["East", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesTooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesWest"],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateSidesWest) pushBack east;
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowWestSpectateResistance),
    "CHECKBOX",
    ["Resistance", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesTooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesWest"],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateSidesWest) pushBack resistance;
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowWestSpectateCivilian),
    "CHECKBOX",
    ["Civilian", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesTooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesWest"],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateSidesWest) pushBack civilian;
        };
    },
    true
] call CBA_Settings_fnc_init;

//allow spectate east
[
    QGVAR(allowEastSpectateWest),
    "CHECKBOX",
    ["West", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesTooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesEast"],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateSidesEast) pushBack west;
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowEastSpectateResistance),
    "CHECKBOX",
    ["Resistance", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesTooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesEast"],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateSidesEast) pushBack resistance;
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowEastSpectateCivilian),
    "CHECKBOX",
    ["Civilian", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesTooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesEast"],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateSidesEast) pushBack civilian;
        };
    },
    true
] call CBA_Settings_fnc_init;

//allow spectate resistance
[
    QGVAR(allowResistanceSpectateWest),
    "CHECKBOX",
    ["West", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesTooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesResistance"],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateSidesResistance) pushBack west;
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowResistanceSpectateEast),
    "CHECKBOX",
    ["East", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesTooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesResistance"],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateSidesResistance) pushBack east;
        };
    },
    true
] call CBA_Settings_fnc_init;


[
    QGVAR(allowResistanceSpectateCivilian),
    "CHECKBOX",
    ["Civilian", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesTooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesResistance"],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateSidesResistance) pushBack civilian;
        };
    },
    true
] call CBA_Settings_fnc_init;

//allow spectate civilians
[
    QGVAR(allowCivilianSpectateWest),
    "CHECKBOX",
    ["West", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesTooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesCivilian"],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateSidesCivilian) pushBack west;
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowCivilianSpectateEast),
    "CHECKBOX",
    ["East", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesTooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesCivilian"],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateSidesCivilian) pushBack east;
        };
    },
    true
] call CBA_Settings_fnc_init;


[
    QGVAR(allowCivilianSpectateResistance),
    "CHECKBOX",
    ["Resistance", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesTooltip"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_spectate_sidesCivilian"],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateSidesCivilian) pushBack resistance;
        };
    },
    true
] call CBA_Settings_fnc_init;

//Ticket count
[
    QGVAR(initialTicketsWest),
    "SLIDER",
    ["West", localize "STR_tunres_Respawn_CBA_tooltip_ticket"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_ticketcount"],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialTicketsWest) = _value;
        GVAR(tickets) set [west, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(initialTicketsEast),
    "SLIDER",
    ["East", localize "STR_tunres_Respawn_CBA_tooltip_ticket"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_ticketcount"],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialTicketsEast) = _value;
        GVAR(tickets) set [east, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(initialTicketsResistance),
    "SLIDER",
    ["Resistance", localize "STR_tunres_Respawn_CBA_tooltip_ticket"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_ticketcount"],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialTicketsResistance) = _value;
        GVAR(tickets) set [resistance, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(initialTicketsCivilian),
    "SLIDER",
    ["Civilian", localize "STR_tunres_Respawn_CBA_tooltip_ticket"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_ticketcount"],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialTicketsCivilian) = _value;
        GVAR(tickets) set [civilian, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowCheckTicketsBase),
    "CHECKBOX",
    ["Main base", localize "STR_tunres_Respawn_CBA_tooltip_CheckTickets"],
    [localize "STR_tunres_Respawn_CBA_Category_main", localize "STR_tunres_Respawn_CBA_Category_checkTickets"],
    true,
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