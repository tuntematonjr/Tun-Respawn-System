#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

//Msp classnames
GVAR(classnames) = createHashMap;

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
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesEnabled),
    "CHECKBOX",
    [localize "STR_tunres_MSP_CBA_reportEnemiesEnabled", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesEnabled"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contested"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesInterval),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_reportEnemiesIntervala", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesInterval"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contested"],
    [1, 600, 30, 0],
    1,
    {
        params ["_value"];
        GVAR(reportEnemiesInterval) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesRange),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_reportEnemiesRange", localize "STR_tunres_MSP_CBA_tooltip_reportEnemiesRange"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contested"],
    [0, 5000, 500, 0],
    1,
    {
        params ["_value"];
        GVAR(reportEnemiesRange) = round _value;
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMax),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_contestedRadiusMax", localize "STR_tunres_MSP_CBA_tooltip_contested_max"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contested"],
    [0, 3000, 500, 0],
    1,
    {
        params ["_value"];
        GVAR(contestedRadiusMax) = round _value;
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMin),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_contestedRadiusMin", localize "STR_tunres_MSP_CBA_tooltip_contested_min"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contested"],
    [0, 3000, 200, 0],
    1,
    {
        params ["_value"];
        GVAR(contestedRadiusMin) = round _value;
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedCheckInterval),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_contestedCheckInterval", localize "STR_tunres_MSP_CBA_tooltip_contestedCheckInterval"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contested"],
    [1, 600, 30, 0],
    1,
    {
        params ["_value"];
        GVAR(contestedCheckInterval) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(progresbarTimeSetup),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_setup_progresbar", localize "STR_tunres_MSP_CBA_tooltip_setup_progresbar"],
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