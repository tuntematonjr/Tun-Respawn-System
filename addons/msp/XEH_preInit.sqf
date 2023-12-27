#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[
    QGVAR(enable),
    "CHECKBOX",
    ["STR_tunres_MSP_CBA_Enable" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_Enable" call BIS_fnc_localize],
    "STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize,
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowCheckTicketsMSP),
    "CHECKBOX",
    ["STR_tunres_MSP_CBA_allowCheckTicketsMSP" call BIS_fnc_localize, "STR_tunres_Respawn_CBA_tooltip_CheckTickets" call BIS_fnc_localize],
    "STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize,
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(report_enemies),
    "CHECKBOX",
    ["STR_tunres_MSP_CBA_report_enemies" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_report_enemies" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_Category_contested" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(report_enemies_interval),
    "SLIDER",
    ["STR_tunres_MSP_CBA_report_enemies_intervala" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_report_enemies_interval" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_Category_contested" call BIS_fnc_localize],
    [1, 600, 30, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(report_enemies_range),
    "SLIDER",
    ["STR_tunres_MSP_CBA_report_enemies_range" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_report_enemies_range" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_Category_contested" call BIS_fnc_localize],
    [0, 5000, 500, 0],
    1,
    {},
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contested_radius_max),
    "SLIDER",
    ["STR_tunres_MSP_CBA_contested_radius_max" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_contested_max" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_Category_contested" call BIS_fnc_localize],
    [0, 5000, 500, 0],
    1,
    {},
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contested_radius_min),
    "SLIDER",
    ["STR_tunres_MSP_CBA_contested_radius_min" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_contested_min" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_Category_contested" call BIS_fnc_localize],
    [0, 5000, 200, 0],
    1,
    {},
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contested_check_interval),
    "SLIDER",
    ["STR_tunres_MSP_CBA_contested_check_interval" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_contested_check_interval" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_Category_contested" call BIS_fnc_localize],
    [1, 600, 30, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(progresbar_time_setup),
    "SLIDER",
    ["STR_tunres_MSP_CBA_setup_progresbar" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_setup_progresbar" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_Category_progres" call BIS_fnc_localize],
    [0, 60, 5, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(progresbar_time_pack),
    "SLIDER",
    ["STR_tunres_MSP_CBA_pack_progresbar" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_pack_progresbar" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_Category_progres" call BIS_fnc_localize],
    [0, 60, 5, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnames_east),
    "EDITBOX",
    ["STR_tunres_MSP_CBA_classname_east" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_classname" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_classname" call BIS_fnc_localize],
    "O_Truck_03_transport_F",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnames_west),
    "EDITBOX",
    ["STR_tunres_MSP_CBA_classname_west" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_classname" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_classname" call BIS_fnc_localize],
    "B_Truck_01_transport_F",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnames_resistance),
    "EDITBOX",
    ["STR_tunres_MSP_CBA_classname_resistance" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_classname" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_classname" call BIS_fnc_localize],
    "I_Truck_02_transport_F",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnames_civilian),
    "EDITBOX",
    ["STR_tunres_MSP_CBA_classname_civilian" call BIS_fnc_localize, "STR_tunres_MSP_CBA_tooltip_classname" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_classname" call BIS_fnc_localize],
    "C_Truck_02_transport_F",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(setupNotification),
    "LIST",
    ["STR_tunres_MSP_CBA_whoGetsSetUpNotification" call BIS_fnc_localize, "STR_tunres_MSP_CBA_whoGetsSetUpNotification_Tooltip" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_notificationCategory" call BIS_fnc_localize],
    [[0, 1], ["Group Leaders", "Side"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedNotification),
    "LIST",
    ["STR_tunres_MSP_CBA_whoGetsContestedNotification" call BIS_fnc_localize, "STR_tunres_MSP_CBA_whoGetsContestedNotification_Tooltip" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_notificationCategory" call BIS_fnc_localize],
    [[0, 1], ["Group Leaders", "Side"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesNotification),
    "LIST",
    ["STR_tunres_MSP_CBA_whoGetsReportEnemiesNotification" call BIS_fnc_localize, "STR_tunres_MSP_CBA_whoGetsReportEnemies_Tooltip" call BIS_fnc_localize],
    ["STR_tunres_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_tunres_MSP_CBA_notificationCategory" call BIS_fnc_localize],
    [[0, 1], ["Group Leaders", "Side"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

ADDON = true;