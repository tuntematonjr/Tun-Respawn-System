#include "script_component.hpp"
#include "XEH_prep.sqf"



if (isServer) then {
    missionNamespace setVariable [QGVAR(contested_east), false, true];
    missionNamespace setVariable [QGVAR(contested_west), false, true];
    missionNamespace setVariable [QGVAR(contested_guer), false, true];
    missionNamespace setVariable [QGVAR(contested_civ), false, true];

    missionNamespace setVariable [QGVAR(status_east), false, true];
    missionNamespace setVariable [QGVAR(status_west), false, true];
    missionNamespace setVariable [QGVAR(status_guer), false, true];
    missionNamespace setVariable [QGVAR(status_civ), false, true];

    missionNamespace setVariable [QGVAR(vehicle_east), objNull, true];
    missionNamespace setVariable [QGVAR(vehicle_west), objNull, true];
    missionNamespace setVariable [QGVAR(vehicle_guer), objNull, true];
    missionNamespace setVariable [QGVAR(vehicle_civ), objNull, true];

    missionNamespace setVariable [QGVAR(eastFriendlyCount), 0, true];
    missionNamespace setVariable [QGVAR(eastEnemyCount), 0, true];
    missionNamespace setVariable [QGVAR(eastEnemyCountMin), 0, true];

    missionNamespace setVariable [QGVAR(westFriendlyCount), 0, true];
    missionNamespace setVariable [QGVAR(westEnemyCount), 0, true];
    missionNamespace setVariable [QGVAR(westEnemyCountMin), 0, true];

    missionNamespace setVariable [QGVAR(guerFriendlyCount), 0, true];
    missionNamespace setVariable [QGVAR(guerEnemyCount), 0, true];
    missionNamespace setVariable [QGVAR(guerEnemyCountMin), 0, true];

    missionNamespace setVariable [QGVAR(civFriendlyCount), 0, true];
    missionNamespace setVariable [QGVAR(civEnemyCount), 0, true];
    missionNamespace setVariable [QGVAR(civEnemyCountMin), 0, true];

};


[
    QGVAR(enable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_Enable", localize "STR_Tun_MSP_CBA_tooltip_Enable"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    localize "STR_Tun_MSP_CBA_Category_main", // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(report_enemies), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_report_enemies", localize "STR_Tun_MSP_CBA_tooltip_report_enemies"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_MSP_CBA_Category_main", localize "STR_Tun_MSP_CBA_Category_contested"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    true, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(report_enemies_interval), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_report_enemies_intervala", localize "STR_Tun_MSP_CBA_tooltip_report_enemies_interval"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_MSP_CBA_Category_main", localize "STR_Tun_MSP_CBA_Category_contested"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 600, 30, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(report_enemies_range), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_report_enemies_range", localize "STR_Tun_MSP_CBA_tooltip_report_enemies_range"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_MSP_CBA_Category_main", localize "STR_Tun_MSP_CBA_Category_contested"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 5000, 500, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    false //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(contested_radius_max), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_contested_radius_max", localize "STR_Tun_MSP_CBA_tooltip_contested_max"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_MSP_CBA_Category_main", localize "STR_Tun_MSP_CBA_Category_contested"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 5000, 500, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    false //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(contested_radius_min), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_contested_radius_min", localize "STR_Tun_MSP_CBA_tooltip_contested_min"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_MSP_CBA_Category_main", localize "STR_Tun_MSP_CBA_Category_contested"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 5000, 200, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    false //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(contested_check_interval), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_contested_check_interval", localize "STR_Tun_MSP_CBA_tooltip_contested_check_interval"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_MSP_CBA_Category_main", localize "STR_Tun_MSP_CBA_Category_contested"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [1, 600, 30, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(progresbar_time_setup), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_setup_progresbar", localize "STR_Tun_MSP_CBA_tooltip_setup_progresbar"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_MSP_CBA_Category_main", localize "STR_Tun_MSP_CBA_Category_progres"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 60, 5, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(progresbar_time_pack), // Unique setting name. Matches resulting variable name <STRING>
    "SLIDER", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_pack_progresbar", localize "STR_Tun_MSP_CBA_tooltip_pack_progresbar"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_MSP_CBA_Category_main", localize "STR_Tun_MSP_CBA_Category_progres"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    [0, 60, 5, 0], // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(clasnames_east), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_classname_east", localize "STR_Tun_MSP_CBA_tooltip_classname"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_MSP_CBA_Category_main", localize "STR_Tun_MSP_CBA_classname"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "O_Truck_03_transport_F", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(clasnames_west), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_classname_west", localize "STR_Tun_MSP_CBA_tooltip_classname"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_MSP_CBA_Category_main", localize "STR_Tun_MSP_CBA_classname"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "B_Truck_01_transport_F", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(clasnames_resistance), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_classname_resistance", localize "STR_Tun_MSP_CBA_tooltip_classname"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_MSP_CBA_Category_main", localize "STR_Tun_MSP_CBA_classname"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "I_Truck_02_transport_F", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;


[
    QGVAR(clasnames_civilian), // Unique setting name. Matches resulting variable name <STRING>
    "EDITBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    [localize "STR_Tun_MSP_CBA_classname_civilian", localize "STR_Tun_MSP_CBA_tooltip_classname"], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [localize "STR_Tun_MSP_CBA_Category_main", localize "STR_Tun_MSP_CBA_classname"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    "C_Truck_02_transport_F", // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;