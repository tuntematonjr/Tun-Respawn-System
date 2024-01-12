#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

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
    QGVAR(report_enemies),
    "CHECKBOX",
    [localize "STR_tunres_MSP_CBA_report_enemies", localize "STR_tunres_MSP_CBA_tooltip_report_enemies"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contested"],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(report_enemies_interval),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_report_enemies_intervala", localize "STR_tunres_MSP_CBA_tooltip_report_enemies_interval"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contested"],
    [1, 600, 30, 0],
    1,
    {
        params ["_value"];
        GVAR(report_enemies_interval) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(report_enemies_range),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_report_enemies_range", localize "STR_tunres_MSP_CBA_tooltip_report_enemies_range"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contested"],
    [0, 5000, 500, 0],
    1,
    {
        params ["_value"];
        GVAR(report_enemies_range) = round _value;
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contested_radius_max),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_contested_radius_max", localize "STR_tunres_MSP_CBA_tooltip_contested_max"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contested"],
    [0, 3000, 500, 0],
    1,
    {
        params ["_value"];
        GVAR(contested_radius_max) = round _value;
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contested_radius_min),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_contested_radius_min", localize "STR_tunres_MSP_CBA_tooltip_contested_min"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contested"],
    [0, 3000, 200, 0],
    1,
    {
        params ["_value"];
        GVAR(contested_radius_min) = round _value;
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contested_check_interval),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_contested_check_interval", localize "STR_tunres_MSP_CBA_tooltip_contested_check_interval"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_contested"],
    [1, 600, 30, 0],
    1,
    {
        params ["_value"];
        GVAR(contested_check_interval) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(progresbar_time_setup),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_setup_progresbar", localize "STR_tunres_MSP_CBA_tooltip_setup_progresbar"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_progres"],
    [0, 60, 5, 0],
    1,
    {
        params ["_value"];
        GVAR(progresbar_time_setup) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(progresbar_time_pack),
    "SLIDER",
    [localize "STR_tunres_MSP_CBA_pack_progresbar", localize "STR_tunres_MSP_CBA_tooltip_pack_progresbar"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_Category_progres"],
    [0, 60, 5, 0],
    1,
    {
        params ["_value"];
        GVAR(progresbar_time_pack) = round _value;
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnames_east),
    "EDITBOX",
    [localize "STR_tunres_MSP_CBA_classname_east", localize "STR_tunres_MSP_CBA_tooltip_classname"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_classname"],
    "O_Truck_03_transport_F",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnames_west),
    "EDITBOX",
    [localize "STR_tunres_MSP_CBA_classname_west", localize "STR_tunres_MSP_CBA_tooltip_classname"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_classname"],
    "B_Truck_01_transport_F",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnames_resistance),
    "EDITBOX",
    [localize "STR_tunres_MSP_CBA_classname_resistance", localize "STR_tunres_MSP_CBA_tooltip_classname"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_classname"],
    "I_Truck_02_transport_F",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnames_civilian),
    "EDITBOX",
    [localize "STR_tunres_MSP_CBA_classname_civilian", localize "STR_tunres_MSP_CBA_tooltip_classname"],
    [localize "STR_tunres_MSP_CBA_Category_main", localize "STR_tunres_MSP_CBA_classname"],
    "C_Truck_02_transport_F",
    1,
    {},
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