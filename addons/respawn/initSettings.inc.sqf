[
    QGVAR(enable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [LSTRING(CBA_Enable), LSTRING(CBA_tooltip_Enable)], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    LSTRING(CBA_Category_main), // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QGVAR(killJIP),
    "CHECKBOX",
    ["Kill JIP", LSTRING(CBA_tooltip_killjip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_generic)],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(killJipTime),
    "TIME",
    ["Kill JIP Time", LSTRING(CBA_tooltip_killJipTime)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_generic)],
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
    ["Respawn Type", LSTRING(CBA_tooltip_respawntypes)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_generic)],
    [[0, 1, 2], [LSTRING(Type_Default), LSTRING(Type_Sidetickets), LSTRING(Type_Playertickets)], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(gearscriptType),
    "LIST",
    ["Gearscript type", LSTRING(CBA_tooltip_gearscript)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_generic)],
    [[0, 1, 2, 3], ["SQF Gearscript", "Potato Tool", "Save gear", "None"], 2],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(forcedRespawn),
    "CHECKBOX",
    ["Only Forced Waves", LSTRING(CBA_tooltip_forceRespawn)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_generic)],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(delayedRespawn),
    "TIME",
    ["Delayed respawn", LSTRING(CBA_tooltip_delayedRespawn)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_generic)],
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
    ["Waiting Area Range", LSTRING(CBA_tooltip_waitingAreaRange)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_generic)],
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
    "TIME",
    ["West", LSTRING(CBA_tooltip_time)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_time)],
    [10, 60*60, 15*60, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialWaveTimeWest) = _value;
        GVAR(waveLenghtTimesHash) set [west, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(initialWaveTimeEast),
    "TIME",
    ["East", LSTRING(CBA_tooltip_time)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_time)],
    [10, 60*60, 15*60, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialWaveTimeEast) = _value;
        GVAR(waveLenghtTimesHash) set [east, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(initialWaveTimeResistance),
    "TIME",
    ["Resistance", LSTRING(CBA_tooltip_time)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_time)],
    [10, 60*60, 15*60, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialWaveTimeResistance) = _value;
        GVAR(waveLenghtTimesHash) set [resistance, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(initialWaveTimeCivilian),
    "TIME",
    ["Civilian", LSTRING(CBA_tooltip_time)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_time)],
    [10, 60*60, 15*60, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialWaveTimeCivilian) = _value;
        GVAR(waveLenghtTimesHash) set [civilian, _value];
    },
    true
] call CBA_Settings_fnc_init;

//Spectator camera modes
[
    QGVAR(spectateCameramode1st),
    "CHECKBOX",
    ["1st", LSTRING(CBA_tooltip_specta_modes)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_cameramode)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateCameraModes) pushBackUnique MODE_FPS;
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(spectateCameramode3th),
    "CHECKBOX",
    ["3th", LSTRING(CBA_tooltip_specta_modes)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_cameramode)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateCameraModes) pushBackUnique MODE_FOLLOW;
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(spectateCameramodeFree),
    "CHECKBOX",
    ["Free", LSTRING(CBA_tooltip_specta_modes)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_cameramode)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            GVAR(allowedSpectateCameraModes) pushBackUnique MODE_FREE;
        };
    },
    true
] call CBA_Settings_fnc_init;

//allow spectate west
[
    QGVAR(allowWestSpectateEast),
    "CHECKBOX",
    ["East", LSTRING(CBA_Category_spectate_sidesTooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_sidesWest)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            private _values = GVAR(allowedSpectateSidesHash) get west;
            _values pushBackUnique east;
            GVAR(allowedSpectateSidesHash) set [west, _values];
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowWestSpectateResistance),
    "CHECKBOX",
    ["Resistance", LSTRING(CBA_Category_spectate_sidesTooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_sidesWest)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            private _values = GVAR(allowedSpectateSidesHash) get west;
            _values pushBackUnique resistance;
            GVAR(allowedSpectateSidesHash) set [west, _values];
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowWestSpectateCivilian),
    "CHECKBOX",
    ["Civilian", LSTRING(CBA_Category_spectate_sidesTooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_sidesWest)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            private _values = GVAR(allowedSpectateSidesHash) get west;
            _values pushBackUnique civilian;
            GVAR(allowedSpectateSidesHash) set [west, _values];
        };
    },
    true
] call CBA_Settings_fnc_init;

//allow spectate east
[
    QGVAR(allowEastSpectateWest),
    "CHECKBOX",
    ["West", LSTRING(CBA_Category_spectate_sidesTooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_sidesEast)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            private _values = GVAR(allowedSpectateSidesHash) get east;
            _values pushBackUnique west;
            GVAR(allowedSpectateSidesHash) set [east, _values];
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowEastSpectateResistance),
    "CHECKBOX",
    ["Resistance", LSTRING(CBA_Category_spectate_sidesTooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_sidesEast)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            private _values = GVAR(allowedSpectateSidesHash) get east;
            _values pushBackUnique resistance;
            GVAR(allowedSpectateSidesHash) set [east, _values];
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowEastSpectateCivilian),
    "CHECKBOX",
    ["Civilian", LSTRING(CBA_Category_spectate_sidesTooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_sidesEast)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            private _values = GVAR(allowedSpectateSidesHash) get east;
            _values pushBackUnique civilian;
            GVAR(allowedSpectateSidesHash) set [east, _values];
        };
    },
    true
] call CBA_Settings_fnc_init;

//allow spectate resistance
[
    QGVAR(allowResistanceSpectateWest),
    "CHECKBOX",
    ["West", LSTRING(CBA_Category_spectate_sidesTooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_sidesResistance)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            private _values = GVAR(allowedSpectateSidesHash) get resistance;
            _values pushBackUnique west;
            GVAR(allowedSpectateSidesHash) set [resistance, _values];
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowResistanceSpectateEast),
    "CHECKBOX",
    ["East", LSTRING(CBA_Category_spectate_sidesTooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_sidesResistance)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            private _values = GVAR(allowedSpectateSidesHash) get resistance;
            _values pushBackUnique east;
            GVAR(allowedSpectateSidesHash) set [resistance, _values];
        };
    },
    true
] call CBA_Settings_fnc_init;


[
    QGVAR(allowResistanceSpectateCivilian),
    "CHECKBOX",
    ["Civilian", LSTRING(CBA_Category_spectate_sidesTooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_sidesResistance)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            private _values = GVAR(allowedSpectateSidesHash) get resistance;
            _values pushBackUnique civilian;
            GVAR(allowedSpectateSidesHash) set [resistance, _values];
        };
    },
    true
] call CBA_Settings_fnc_init;

//allow spectate civilians
[
    QGVAR(allowCivilianSpectateWest),
    "CHECKBOX",
    ["West", LSTRING(CBA_Category_spectate_sidesTooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_sidesCivilian)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            private _values = GVAR(allowedSpectateSidesHash) get civilian;
            _values pushBackUnique west;
            GVAR(allowedSpectateSidesHash) set [civilian, _values];
        };
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowCivilianSpectateEast),
    "CHECKBOX",
    ["East", LSTRING(CBA_Category_spectate_sidesTooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_sidesCivilian)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            private _values = GVAR(allowedSpectateSidesHash) get civilian;
            _values pushBackUnique east;
            GVAR(allowedSpectateSidesHash) set [civilian, _values];
        };
    },
    true
] call CBA_Settings_fnc_init;


[
    QGVAR(allowCivilianSpectateResistance),
    "CHECKBOX",
    ["Resistance", LSTRING(CBA_Category_spectate_sidesTooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_spectate_sidesCivilian)],
    true,
    1,
    {
        params ["_value"];
        if (_value) then {
            private _values = GVAR(allowedSpectateSidesHash) get civilian;
            _values pushBackUnique resistance;
            GVAR(allowedSpectateSidesHash) set [civilian, _values];
        };
    },
    true
] call CBA_Settings_fnc_init;

//Ticket count
[
    QGVAR(initialTicketsWest),
    "SLIDER",
    ["West", LSTRING(CBA_tooltip_ticket)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_ticketcount)],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialTicketsWest) = _value;
        GVAR(ticketsHash) set [west, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(initialTicketsEast),
    "SLIDER",
    ["East", LSTRING(CBA_tooltip_ticket)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_ticketcount)],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialTicketsEast) = _value;
        GVAR(ticketsHash) set [east, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(initialTicketsResistance),
    "SLIDER",
    ["Resistance", LSTRING(CBA_tooltip_ticket)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_ticketcount)],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialTicketsResistance) = _value;
        GVAR(ticketsHash) set [resistance, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(initialTicketsCivilian),
    "SLIDER",
    ["Civilian", LSTRING(CBA_tooltip_ticket)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_ticketcount)],
    [0, 1000, 0, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(initialTicketsCivilian) = _value;
        GVAR(ticketsHash) set [civilian, _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowCheckTicketsBase),
    "CHECKBOX",
    ["Main base", LSTRING(CBA_tooltip_CheckTickets)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_checkTickets)],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Briefing notes
[
    QGVAR(briefingEnable),
    "CHECKBOX",
    [LSTRING(CBA_Briefing_Enable), LSTRING(CBA_Briefing_Enable_tooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_Briefing)],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowRespawnType),
    "CHECKBOX",
    [LSTRING(CBA_Briefing_Enable_ShowRespawType), LSTRING(CBA_Briefing_Enable_ShowRespawType_tooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_Briefing)],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowTickets),
    "CHECKBOX",
    [LSTRING(CBA_Briefing_Enable_ShowTickets), LSTRING(CBA_Briefing_Enable_ShowTickets_tooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_Briefing)],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowTime),
    "CHECKBOX",
    [LSTRING(CBA_Briefing_Enable_ShowTime), LSTRING(CBA_Briefing_Enable_ShowTime_tooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_Briefing)],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataWest),
    "CHECKBOX",
    [LSTRING(CBA_Briefing_Enable_ShowOtherSidesData_West), LSTRING(CBA_Briefing_Enable_ShowOtherSidesData_tooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_Briefing)],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataEast),
    "CHECKBOX",
    [LSTRING(CBA_Briefing_Enable_ShowOtherSidesData_East), LSTRING(CBA_Briefing_Enable_ShowOtherSidesData_tooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_Briefing)],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataResistance),
    "CHECKBOX",
    [LSTRING(CBA_Briefing_Enable_ShowOtherSidesData_Resistance), LSTRING(CBA_Briefing_Enable_ShowOtherSidesData_tooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_Briefing)],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(briefingEnableShowOtherSidesDataCivilian),
    "CHECKBOX",
    [LSTRING(CBA_Briefing_Enable_ShowOtherSidesData_Civilian), LSTRING(CBA_Briefing_Enable_ShowOtherSidesData_tooltip)],
    [LSTRING(CBA_Category_main), LSTRING(CBA_Category_Briefing)],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;