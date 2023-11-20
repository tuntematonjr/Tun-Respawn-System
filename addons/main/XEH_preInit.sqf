#include "script_component.hpp"
#include "XEH_prep.sqf"


//Main settings
[
    QEGVAR(respawn,enable), // Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX", // Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
    ["STR_Tun_Respawn_CBA_Enable" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_tooltip_Enable" call BIS_fnc_localize], // Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    "STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, // Extra properties of the setting depending of _settingType.
    1, // 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <ARRAY>
    {}, // Script to execute when setting is changed. (optional) <CODE>
    true //Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,killJIP),
    "CHECKBOX",
    ["Kill JIP", "STR_Tun_Respawn_CBA_tooltip_killjip" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,killJIP_time),
    "SLIDER",
    ["Kill JIP Time", "STR_Tun_Respawn_CBA_tooltip_killjip_time" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    [1, 300, 20, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,respawn_type),
    "LIST",
    ["Respawn Type", "STR_Tun_Respawn_CBA_tooltip_respawntypes" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    [[localize "STR_Tun_Respawn_Type_Default", localize "STR_Tun_Respawn_Type_Sidetickets", localize "STR_Tun_Respawn_Type_Playertickets"], [localize "STR_Tun_Respawn_Type_Default", localize "STR_Tun_Respawn_Type_Sidetickets", localize "STR_Tun_Respawn_Type_Playertickets"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,gearscriptType),
    "LIST",
    ["Gearscript type", "STR_Tun_Respawn_CBA_tooltip_gearscript" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    [["SQF Gearscript", "Potato Tool", "Save gear"], ["SQF Gearscript", "Potato Tool", "Save gear"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,forced_respawn),
    "CHECKBOX",
    ["Only Forced Waves", "STR_Tun_Respawn_CBA_tooltip_forceRespawn" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,delayed_respawn),
    "SLIDER",
    ["Delayed respawn", "STR_Tun_Respawn_CBA_tooltip_delayed_respawn" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    [0, 100, 0, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,waiting_area_range),
    "SLIDER",
    ["Waiting Area Range", "STR_Tun_Respawn_CBA_tooltip_waiting_area_range" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_generic" call BIS_fnc_localize],
    [30, 300, 100, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Wave times
[
    QEGVAR(respawn,time_west),
    "SLIDER",
    ["West", "STR_Tun_Respawn_CBA_tooltip_time" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_time" call BIS_fnc_localize],
    [1, 60, 15, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,time_east),
    "SLIDER",
    ["East", "STR_Tun_Respawn_CBA_tooltip_time" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_time" call BIS_fnc_localize],
    [1, 60, 15, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,time_guer),
    "SLIDER",
    ["Resistance", "STR_Tun_Respawn_CBA_tooltip_time" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_time" call BIS_fnc_localize],
    [1, 60, 15, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,time_civ),
    "SLIDER",
    ["Civilian", "STR_Tun_Respawn_CBA_tooltip_time" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_time" call BIS_fnc_localize],
    [1, 60, 15, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Spectator camera modes
[
    QEGVAR(respawn,spectate_Cameramode_1st),
    "CHECKBOX",
    ["1st", "STR_Tun_Respawn_CBA_tooltip_specta_modes" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_spectate_cameramode" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,spectate_Cameramode_3th),
    "CHECKBOX",
    ["3th", "STR_Tun_Respawn_CBA_tooltip_specta_modes" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_spectate_cameramode" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,spectate_Cameramode_free),
    "CHECKBOX",
    ["Free", "STR_Tun_Respawn_CBA_tooltip_specta_modes" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_spectate_cameramode" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Ticket count
[
    QEGVAR(respawn,tickets_west),
    "SLIDER",
    ["West", "STR_Tun_Respawn_CBA_tooltip_ticket" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_ticketcount" call BIS_fnc_localize],
    [0, 1000, 0, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,tickets_east),
    "SLIDER",
    ["East", "STR_Tun_Respawn_CBA_tooltip_ticket" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_ticketcount" call BIS_fnc_localize],
    [0, 1000, 0, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,tickets_guer),
    "SLIDER",
    ["Resistance", "STR_Tun_Respawn_CBA_tooltip_ticket" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_ticketcount" call BIS_fnc_localize],
    [0, 1000, 0, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,tickets_civ),
    "SLIDER",
    ["Civilian", "STR_Tun_Respawn_CBA_tooltip_ticket" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_ticketcount" call BIS_fnc_localize],
    [0, 1000, 0, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,allowCheckTicketsBase),
    "CHECKBOX",
    ["Main base", "STR_Tun_Respawn_CBA_tooltip_CheckTickets" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_checkTickets" call BIS_fnc_localize],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

//Briefing notes
[
    QEGVAR(respawn,briefingEnable),
    "CHECKBOX",
    ["STR_Tun_Respawn_CBA_Briefing_Enable" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_tooltip" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,briefingEnableShowRespawnType),
    "CHECKBOX",
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowRespawType" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowRespawType_tooltip" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,briefingEnableShowTickets),
    "CHECKBOX",
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowTickets" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowTickets_tooltip" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,briefingEnableShowTime),
    "CHECKBOX",
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowTime" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowTime_tooltip" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,briefingEnableShowOtherSidesDataWest),
    "CHECKBOX",
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_West" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,briefingEnableShowOtherSidesDataEast),
    "CHECKBOX",
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_East" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,briefingEnableShowOtherSidesDataResistance),
    "CHECKBOX",
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_Resistance" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(respawn,briefingEnableShowOtherSidesDataCivilian),
    "CHECKBOX",
    ["STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_Civilian" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Briefing_Enable_ShowOtherSidesData_tooltip" call BIS_fnc_localize],
    ["STR_Tun_Respawn_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_Category_Briefing" call BIS_fnc_localize],
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

////////////////////
/////////MSP////////
////////////////////
[
    QEGVAR(msp,enable),
    "CHECKBOX",
    ["STR_Tun_MSP_CBA_Enable" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_Enable" call BIS_fnc_localize],
    "STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize,
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,allowCheckTicketsMSP),
    "CHECKBOX",
    ["STR_Tun_MSP_CBA_allowCheckTicketsMSP" call BIS_fnc_localize, "STR_Tun_Respawn_CBA_tooltip_CheckTickets" call BIS_fnc_localize],
    "STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize,
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,report_enemies),
    "CHECKBOX",
    ["STR_Tun_MSP_CBA_report_enemies" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_report_enemies" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_contested" call BIS_fnc_localize],
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,report_enemies_interval),
    "SLIDER",
    ["STR_Tun_MSP_CBA_report_enemies_intervala" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_report_enemies_interval" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_contested" call BIS_fnc_localize],
    [1, 600, 30, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,report_enemies_range),
    "SLIDER",
    ["STR_Tun_MSP_CBA_report_enemies_range" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_report_enemies_range" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_contested" call BIS_fnc_localize],
    [0, 5000, 500, 0],
    1,
    {},
    false
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,contested_radius_max),
    "SLIDER",
    ["STR_Tun_MSP_CBA_contested_radius_max" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_contested_max" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_contested" call BIS_fnc_localize],
    [0, 5000, 500, 0],
    1,
    {},
    false
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,contested_radius_min),
    "SLIDER",
    ["STR_Tun_MSP_CBA_contested_radius_min" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_contested_min" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_contested" call BIS_fnc_localize],
    [0, 5000, 200, 0],
    1,
    {},
    false
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,contested_check_interval),
    "SLIDER",
    ["STR_Tun_MSP_CBA_contested_check_interval" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_contested_check_interval" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_contested" call BIS_fnc_localize],
    [1, 600, 30, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,progresbar_time_setup),
    "SLIDER",
    ["STR_Tun_MSP_CBA_setup_progresbar" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_setup_progresbar" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_progres" call BIS_fnc_localize],
    [0, 60, 5, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,progresbar_time_pack),
    "SLIDER",
    ["STR_Tun_MSP_CBA_pack_progresbar" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_pack_progresbar" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_Category_progres" call BIS_fnc_localize],
    [0, 60, 5, 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,clasnames_east),
    "EDITBOX",
    ["STR_Tun_MSP_CBA_classname_east" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_classname" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_classname" call BIS_fnc_localize],
    "O_Truck_03_transport_F",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,clasnames_west),
    "EDITBOX",
    ["STR_Tun_MSP_CBA_classname_west" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_classname" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_classname" call BIS_fnc_localize],
    "B_Truck_01_transport_F",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,clasnames_resistance),
    "EDITBOX",
    ["STR_Tun_MSP_CBA_classname_resistance" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_classname" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_classname" call BIS_fnc_localize],
    "I_Truck_02_transport_F",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,clasnames_civilian),
    "EDITBOX",
    ["STR_Tun_MSP_CBA_classname_civilian" call BIS_fnc_localize, "STR_Tun_MSP_CBA_tooltip_classname" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_classname" call BIS_fnc_localize],
    "C_Truck_02_transport_F",
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,setupNotification),
    "LIST",
    ["STR_Tun_MSP_CBA_whoGetsSetUpNotification" call BIS_fnc_localize, "STR_Tun_MSP_CBA_whoGetsSetUpNotification_Tooltip" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_notificationCategory" call BIS_fnc_localize],
    [[0, 1], ["Group Leaders", "Side"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,contestedNotification),
    "LIST",
    ["STR_Tun_MSP_CBA_whoGetsContestedNotification" call BIS_fnc_localize, "STR_Tun_MSP_CBA_whoGetsContestedNotification_Tooltip" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_notificationCategory" call BIS_fnc_localize],
    [[0, 1], ["Group Leaders", "Side"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QEGVAR(msp,reportEnemiesNotification),
    "LIST",
    ["STR_Tun_MSP_CBA_whoGetsReportEnemiesNotification" call BIS_fnc_localize, "STR_Tun_MSP_CBA_whoGetsReportEnemies_Tooltip" call BIS_fnc_localize],
    ["STR_Tun_MSP_CBA_Category_main" call BIS_fnc_localize, "STR_Tun_MSP_CBA_notificationCategory" call BIS_fnc_localize],
    [[0, 1], ["Group Leaders", "Side"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

GVAR(cbaSettingsDone) = true;