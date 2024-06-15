#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

//Msp classnames
GVAR(classnames) = createHashMap;

//reportEnemiesInterval 0 - reportEnemiesRange 1 - contestedRadiusMax 2 - contestedRadiusMin 3 - contestedCheckInterval 4 - reportEnemiesEnabled 5
GVAR(contestValues) = createHashMapFromArray [[west,[0,0,0,0,0,false]],[east,[0,0,0,0,0,false]],[resistance,[0,0,0,0,0,false]],[civilian,[0,0,0,0,0,false]]];
GVAR(contestHandles) = createHashMap;
GVAR(contestCheckRunning) = createHashMapFromArray FALSES_FOR_SIDES;

[
    QGVAR(enable),
    "CHECKBOX",
    [localize "STR_tunres_MSP_CBA_Enable", localize "STR_tunres_MSP_CBA_tooltip_Enable"],
    localize "STR_tunres_MSP_CBA_Category_main",
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowCheckTicketsMSP),
    "CHECKBOX",
    [localize "STR_tunres_MSP_CBA_allowCheckTicketsMSP", localize "STR_tunres_Respawn_CBA_tooltip_CheckTickets"],
    localize "STR_tunres_MSP_CBA_Category_main",
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesEnabledWest),
    "CHECKBOX",
    [(localize "STR_tunres_MSP_CBA_reportEnemiesEnabled") + " West", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesEnabled"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedWest"],
    true,
    1,
    {
        params ["_value"];
        private _array = GVAR(contestValues) get west;
        _array set [5, _value];
        GVAR(contestValues) set [west, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesEnabledEast),
    "CHECKBOX",
    [(localize "STR_tunres_MSP_CBA_reportEnemiesEnabled") + " East", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesEnabled"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedEast"],
    true,
    1,
    {
        params ["_value"];
        private _array = GVAR(contestValues) get east;
        _array set [5, _value];
        GVAR(contestValues) set [east, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesEnabledResistance),
    "CHECKBOX",
    [(localize "STR_tunres_MSP_CBA_reportEnemiesEnabled") + " Resistance", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesEnabled"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedResistance"],
    true,
    1,
    {
        params ["_value"];
        private _array = GVAR(contestValues) get resistance;
        _array set [5, _value];
        GVAR(contestValues) set [resistance, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesEnabledCivilian),
    "CHECKBOX",
    [(localize "STR_tunres_MSP_CBA_reportEnemiesEnabled" + " Civilian"), localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesEnabled"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedCivilian"],
    true,
    1,
    {
        params ["_value"];
        private _array = GVAR(contestValues) get civilian;
        _array set [5, _value];
        GVAR(contestValues) set [civilian, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesIntervalWest),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_reportEnemiesIntervala") + " West", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesInterval"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedWest"],
    [1, 600, 60, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesIntervalWest) = _value;
        private _array = GVAR(contestValues) get west;
        _array set [0, _value];
        GVAR(contestValues) set [west, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesIntervalEast),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_reportEnemiesIntervala") + " East", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesInterval"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedEast"],
    [1, 600, 60, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesIntervalEast) = _value;
        private _array = GVAR(contestValues) get east;
        _array set [0, _value];
        GVAR(contestValues) set [east, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesIntervalResistance),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_reportEnemiesIntervala") + " Resistance", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesInterval"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedResistance"],
    [1, 600, 60, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesIntervalResistance) = _value;
        private _array = GVAR(contestValues) get resistance;
        _array set [0, _value];
        GVAR(contestValues) set [resistance, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesIntervalCivilian),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_reportEnemiesIntervala") + " Civilian", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesInterval"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedCivilian"],
    [1, 600, 60, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesIntervalCivilian) = _value;
        private _array = GVAR(contestValues) get civilian;
        _array set [0, _value];
        GVAR(contestValues) set [civilian, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesRangeWest),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_reportEnemiesRange") + " West", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesRange"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedWest"],
    [0, 5000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesRangeWest) = _value;
        private _array = GVAR(contestValues) get west;
        _array set [1, _value];
        GVAR(contestValues) set [west, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesRangeEast),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_reportEnemiesRange") + " East", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesRange"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedEast"],
    [0, 5000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesRangeEast) = _value;
        private _array = GVAR(contestValues) get east;
        _array set [1, _value];
        GVAR(contestValues) set [east, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesRangeResistance),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_reportEnemiesRange") + " Resistance", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesRange"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedResistance"],
    [0, 5000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesRangeResistance) = _value;
        private _array = GVAR(contestValues) get resistance;
        _array set [1, _value];
        GVAR(contestValues) set [resistance, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesRangeCivilian),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_reportEnemiesRange") + " Civilian", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesRange"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedCivilian"],
    [0, 5000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesRangeCivilian) = _value;
        private _array = GVAR(contestValues) get civilian;
        _array set [1, _value];
        GVAR(contestValues) set [civilian, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMaxWest),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_contestedRadiusMax") + " West", localize "STR_tunres_MSP_CBA_tooltip_contested_max"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedWest"],
    [0, 3000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMaxWest) = _value;
        private _array = GVAR(contestValues) get west;
        _array set [2, _value];
        GVAR(contestValues) set [west, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMaxEast),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_contestedRadiusMax") + " East", localize "STR_tunres_MSP_CBA_tooltip_contested_max"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedEast"],
    [0, 3000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMaxEast) = _value;
        private _array = GVAR(contestValues) get east;
        _array set [2, _value];
        GVAR(contestValues) set [east, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMaxResistance),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_contestedRadiusMax") + " Resistance", localize "STR_tunres_MSP_CBA_tooltip_contested_max"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedResistance"],
    [0, 3000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMaxResistance) = _value;
        private _array = GVAR(contestValues) get resistance;
        _array set [2, _value];
        GVAR(contestValues) set [resistance, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMaxCivilian),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_contestedRadiusMax") + " Civilian", localize "STR_tunres_MSP_CBA_tooltip_contested_max"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedCivilian"],
    [0, 3000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMaxCivilian) = _value;
        private _array = GVAR(contestValues) get civilian;
        _array set [2, _value];
        GVAR(contestValues) set [civilian, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMinWest),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_contestedRadiusMin") + " West", localize "STR_tunres_MSP_CBA_tooltip_contested_min"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedWest"],
    [0, 3000, 200, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMinWest) = _value;
        private _array = GVAR(contestValues) get west;
        _array set [3, _value];
        GVAR(contestValues) set [west, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMinEast),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_contestedRadiusMin") + " East", localize "STR_tunres_MSP_CBA_tooltip_contested_min"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedEast"],
    [0, 3000, 200, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMinEast) = _value;
        private _array = GVAR(contestValues) get east;
        _array set [3, _value];
        GVAR(contestValues) set [east, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMinResistance),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_contestedRadiusMin") + " Resistance", localize "STR_tunres_MSP_CBA_tooltip_contested_min"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedResistance"],
    [0, 3000, 200, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMinResistance) = _value;
        private _array = GVAR(contestValues) get resistance;
        _array set [3, _value];
        GVAR(contestValues) set [resistance, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMinCivilian),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_contestedRadiusMin") + " Civilian", localize "STR_tunres_MSP_CBA_tooltip_contested_min"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedCivilian"],
    [0, 3000, 200, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMinCivilian) = _value;
        private _array = GVAR(contestValues) get civilian;
        _array set [3, _value];
        GVAR(contestValues) set [civilian, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedCheckIntervalWest),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_contestedCheckInterval") + " West", localize "STR_tunres_MSP_CBA_tooltip_contestedCheckInterval"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedWest"],
    [1, 600, 20, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedCheckIntervalWest) = _value;
        private _array = GVAR(contestValues) get west;
        _array set [4, _value];
        GVAR(contestValues) set [west, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedCheckIntervalEast),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_contestedCheckInterval") + " East", localize "STR_tunres_MSP_CBA_tooltip_contestedCheckInterval"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedEast"],
    [1, 600, 20, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedCheckIntervalEast) = _value;
        private _array = GVAR(contestValues) get east;
        _array set [4, _value];
        GVAR(contestValues) set [west, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedCheckIntervalResistance),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_contestedCheckInterval") + " Resistance", localize "STR_tunres_MSP_CBA_tooltip_contestedCheckInterval"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedResistance"],
    [1, 600, 20, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedCheckIntervalResistance) = _value;
        private _array = GVAR(contestValues) get resistance;
        _array set [4, _value];
        GVAR(contestValues) set [resistance, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedCheckIntervalCivilian),
    "SLIDER",
    [(localize "STR_tunres_MSP_CBA_contestedCheckInterval") + " Civilian", localize "STR_tunres_MSP_CBA_tooltip_contestedCheckInterval"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contestedCivilian"],
    [1, 600, 20, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedCheckIntervalCivilian) = _value;
        private _array = GVAR(contestValues) get civilian;
        _array set [4, _value];
        GVAR(contestValues) set [civilian, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(progresbarTimeSetup),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_setup_progresbar", localize "STR_tunres_MSP_CBA_tooltip_setup_ProgressBar"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_progres"],
    [0, 60, 5, 0],
    1,
    {
        params ["_value"];
        GVAR(progresbarTimeSetup) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(progresbarTimePack),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_pack_progresbar", localize "STR_tunres_MSP_CBA_tooltip_pack_progresbar"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_progres"],
    [0, 60, 5, 0],
    1,
    {
        params ["_value"];
        GVAR(progresbarTimePack) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnamesEast),
    "EDITBOX",
    [localize "STR_tunres_MSP_CBA_classname_east", localize "STR_tunres_MSP_CBA_tooltip_classname"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_classname"],
    "O_Truck_03_transport_F",
    1,
    {
        params ["_value"];
        GVAR(classnames) set [east , _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnamesWest),
    "EDITBOX",
    [localize "STR_tunres_MSP_CBA_classname_west", localize "STR_tunres_MSP_CBA_tooltip_classname"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_classname"],
    "B_Truck_01_transport_F",
    1,
    {
        params ["_value"];
        GVAR(classnames) set [west , _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnamesResistance),
    "EDITBOX",
    [localize "STR_tunres_MSP_CBA_classname_resistance", localize "STR_tunres_MSP_CBA_tooltip_classname"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_classname"],
    "I_Truck_02_transport_F",
    1,
    {
        params ["_value"];
        GVAR(classnames) set [resistance , _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnamesCivilian),
    "EDITBOX",
    [localize "STR_tunres_MSP_CBA_classname_civilian", localize "STR_tunres_MSP_CBA_tooltip_classname"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_classname"],
    "C_Truck_02_transport_F",
    1,
    {
        params ["_value"];
        GVAR(classnames) set [civilian , _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(setupNotification),
    "LIST",
    [localize "STR_tunres_MSP_CBA_whoGetsSetUpNotification", localize "STR_tunres_MSP_CBA_whoGetsSetUpNotification_Tooltip"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_notificationCategory"],
    [[0, 1], ["Group Leaders", "Side"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedNotification),
    "LIST",
    [localize "STR_tunres_MSP_CBA_whoGetsContestedNotification", localize "STR_tunres_MSP_CBA_whoGetsContestedNotification_Tooltip"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_notificationCategory"],
    [[0, 1], ["Group Leaders", "Side"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesNotification),
    "LIST",
    [localize "STR_tunres_MSP_CBA_whoGetsReportEnemiesNotification", localize "STR_tunres_MSP_CBA_whoGetsReportEnemies_Tooltip"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_notificationCategory"],
    [[0, 1], ["Group Leaders", "Side"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

ADDON = true;