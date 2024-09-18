[
    QGVAR(enable),
    "CHECKBOX",
    [LLSTRING(CBA_Enable), LLSTRING(CBA_tooltip_Enable)],
    LLSTRING(CBA_Category_main),
    false,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(allowCheckTicketsMSP),
    "CHECKBOX",
    [LLSTRING(CBA_allowCheckTicketsMSP), localize "STR_tunres_respawn_CBA_tooltip_CheckTickets"],
    LLSTRING(CBA_Category_main),
    true,
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesEnabledWest),
    "CHECKBOX",
    [(LLSTRING(CBA_reportEnemiesEnabled)) + " West", LLSTRING(CBA_tooltip_reportEnemiesEnabled)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedWest)],
    true,
    1,
    {
        params ["_value"];
        private _array = GVAR(contestValuesHash) get west;
        _array set [5, _value];
        GVAR(contestValuesHash) set [west, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesEnabledEast),
    "CHECKBOX",
    [(LLSTRING(CBA_reportEnemiesEnabled)) + " East", LLSTRING(CBA_tooltip_reportEnemiesEnabled)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedEast)],
    true,
    1,
    {
        params ["_value"];
        private _array = GVAR(contestValuesHash) get east;
        _array set [5, _value];
        GVAR(contestValuesHash) set [east, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesEnabledResistance),
    "CHECKBOX",
    [(LLSTRING(CBA_reportEnemiesEnabled)) + " Resistance", LLSTRING(CBA_tooltip_reportEnemiesEnabled)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedResistance)],
    true,
    1,
    {
        params ["_value"];
        private _array = GVAR(contestValuesHash) get resistance;
        _array set [5, _value];
        GVAR(contestValuesHash) set [resistance, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesEnabledCivilian),
    "CHECKBOX",
    [(LLSTRING(CBA_reportEnemiesEnabled) + " Civilian"), LLSTRING(CBA_tooltip_reportEnemiesEnabled)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedCivilian)],
    true,
    1,
    {
        params ["_value"];
        private _array = GVAR(contestValuesHash) get civilian;
        _array set [5, _value];
        GVAR(contestValuesHash) set [civilian, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesIntervalWest),
    "TIME",
    [(LLSTRING(CBA_reportEnemiesIntervala)) + " West", LLSTRING(CBA_tooltip_reportEnemiesInterval)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedWest)],
    [1, 600, 60, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesIntervalWest) = _value;
        private _array = GVAR(contestValuesHash) get west;
        _array set [0, _value];
        GVAR(contestValuesHash) set [west, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesIntervalEast),
    "TIME",
    [(LLSTRING(CBA_reportEnemiesIntervala)) + " East", LLSTRING(CBA_tooltip_reportEnemiesInterval)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedEast)],
    [1, 600, 60, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesIntervalEast) = _value;
        private _array = GVAR(contestValuesHash) get east;
        _array set [0, _value];
        GVAR(contestValuesHash) set [east, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesIntervalResistance),
    "TIME",
    [(LLSTRING(CBA_reportEnemiesIntervala)) + " Resistance", LLSTRING(CBA_tooltip_reportEnemiesInterval)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedResistance)],
    [1, 600, 60, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesIntervalResistance) = _value;
        private _array = GVAR(contestValuesHash) get resistance;
        _array set [0, _value];
        GVAR(contestValuesHash) set [resistance, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesIntervalCivilian),
    "TIME",
    [(LLSTRING(CBA_reportEnemiesIntervala)) + " Civilian", LLSTRING(CBA_tooltip_reportEnemiesInterval)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedCivilian)],
    [1, 600, 60, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        ok = _value;
        GVAR(reportEnemiesIntervalCivilian) = _value;
        private _array = GVAR(contestValuesHash) get civilian;
        _array set [0, _value];
        GVAR(contestValuesHash) set [civilian, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesRangeWest),
    "SLIDER",
    [(LLSTRING(CBA_reportEnemiesRange)) + " West", LLSTRING(CBA_tooltip_reportEnemiesRange)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedWest)],
    [0, 5000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesRangeWest) = _value;
        private _array = GVAR(contestValuesHash) get west;
        _array set [1, _value];
        GVAR(contestValuesHash) set [west, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesRangeEast),
    "SLIDER",
    [(LLSTRING(CBA_reportEnemiesRange)) + " East", LLSTRING(CBA_tooltip_reportEnemiesRange)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedEast)],
    [0, 5000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesRangeEast) = _value;
        private _array = GVAR(contestValuesHash) get east;
        _array set [1, _value];
        GVAR(contestValuesHash) set [east, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesRangeResistance),
    "SLIDER",
    [(LLSTRING(CBA_reportEnemiesRange)) + " Resistance", LLSTRING(CBA_tooltip_reportEnemiesRange)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedResistance)],
    [0, 5000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesRangeResistance) = _value;
        private _array = GVAR(contestValuesHash) get resistance;
        _array set [1, _value];
        GVAR(contestValuesHash) set [resistance, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesRangeCivilian),
    "SLIDER",
    [(LLSTRING(CBA_reportEnemiesRange)) + " Civilian", LLSTRING(CBA_tooltip_reportEnemiesRange)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedCivilian)],
    [0, 5000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(reportEnemiesRangeCivilian) = _value;
        private _array = GVAR(contestValuesHash) get civilian;
        _array set [1, _value];
        GVAR(contestValuesHash) set [civilian, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMaxWest),
    "SLIDER",
    [(LLSTRING(CBA_contestedRadiusMax)) + " West", LLSTRING(CBA_tooltip_contested_max)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedWest)],
    [0, 3000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMaxWest) = _value;
        private _array = GVAR(contestValuesHash) get west;
        _array set [2, _value];
        GVAR(contestValuesHash) set [west, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMaxEast),
    "SLIDER",
    [(LLSTRING(CBA_contestedRadiusMax)) + " East", LLSTRING(CBA_tooltip_contested_max)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedEast)],
    [0, 3000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMaxEast) = _value;
        private _array = GVAR(contestValuesHash) get east;
        _array set [2, _value];
        GVAR(contestValuesHash) set [east, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMaxResistance),
    "SLIDER",
    [(LLSTRING(CBA_contestedRadiusMax)) + " Resistance", LLSTRING(CBA_tooltip_contested_max)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedResistance)],
    [0, 3000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMaxResistance) = _value;
        private _array = GVAR(contestValuesHash) get resistance;
        _array set [2, _value];
        GVAR(contestValuesHash) set [resistance, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMaxCivilian),
    "SLIDER",
    [(LLSTRING(CBA_contestedRadiusMax)) + " Civilian", LLSTRING(CBA_tooltip_contested_max)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedCivilian)],
    [0, 3000, 500, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMaxCivilian) = _value;
        private _array = GVAR(contestValuesHash) get civilian;
        _array set [2, _value];
        GVAR(contestValuesHash) set [civilian, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMinWest),
    "SLIDER",
    [(LLSTRING(CBA_contestedRadiusMin)) + " West", LLSTRING(CBA_tooltip_contested_min)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedWest)],
    [0, 3000, 200, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMinWest) = _value;
        private _array = GVAR(contestValuesHash) get west;
        _array set [3, _value];
        GVAR(contestValuesHash) set [west, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMinEast),
    "SLIDER",
    [(LLSTRING(CBA_contestedRadiusMin)) + " East", LLSTRING(CBA_tooltip_contested_min)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedEast)],
    [0, 3000, 200, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMinEast) = _value;
        private _array = GVAR(contestValuesHash) get east;
        _array set [3, _value];
        GVAR(contestValuesHash) set [east, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMinResistance),
    "SLIDER",
    [(LLSTRING(CBA_contestedRadiusMin)) + " Resistance", LLSTRING(CBA_tooltip_contested_min)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedResistance)],
    [0, 3000, 200, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMinResistance) = _value;
        private _array = GVAR(contestValuesHash) get resistance;
        _array set [3, _value];
        GVAR(contestValuesHash) set [resistance, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedRadiusMinCivilian),
    "SLIDER",
    [(LLSTRING(CBA_contestedRadiusMin)) + " Civilian", LLSTRING(CBA_tooltip_contested_min)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedCivilian)],
    [0, 3000, 200, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedRadiusMinCivilian) = _value;
        private _array = GVAR(contestValuesHash) get civilian;
        _array set [3, _value];
        GVAR(contestValuesHash) set [civilian, _array];
    },
    false
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedCheckIntervalWest),
    "TIME",
    [(LLSTRING(CBA_contestedCheckInterval)) + " West", LLSTRING(CBA_tooltip_contestedCheckInterval)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedWest)],
    [1, 600, 20, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedCheckIntervalWest) = _value;
        private _array = GVAR(contestValuesHash) get west;
        _array set [4, _value];
        GVAR(contestValuesHash) set [west, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedCheckIntervalEast),
    "TIME",
    [(LLSTRING(CBA_contestedCheckInterval)) + " East", LLSTRING(CBA_tooltip_contestedCheckInterval)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedEast)],
    [1, 600, 20, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedCheckIntervalEast) = _value;
        private _array = GVAR(contestValuesHash) get east;
        _array set [4, _value];
        GVAR(contestValuesHash) set [west, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedCheckIntervalResistance),
    "TIME",
    [(LLSTRING(CBA_contestedCheckInterval)) + " Resistance", LLSTRING(CBA_tooltip_contestedCheckInterval)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedResistance)],
    [1, 600, 20, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedCheckIntervalResistance) = _value;
        private _array = GVAR(contestValuesHash) get resistance;
        _array set [4, _value];
        GVAR(contestValuesHash) set [resistance, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedCheckIntervalCivilian),
    "TIME",
    [(LLSTRING(CBA_contestedCheckInterval)) + " Civilian", LLSTRING(CBA_tooltip_contestedCheckInterval)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_contestedCivilian)],
    [1, 600, 20, 0],
    1,
    {
        params ["_value"];
        _value = round _value;
        GVAR(contestedCheckIntervalCivilian) = _value;
        private _array = GVAR(contestValuesHash) get civilian;
        _array set [4, _value];
        GVAR(contestValuesHash) set [civilian, _array];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(progresbarTimeSetup),
    "TIME",
    [LLSTRING(CBA_setup_progresbar), LLSTRING(CBA_tooltip_setup_ProgressBar)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_progres)],
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
    "TIME",
    [LLSTRING(CBA_pack_progresbar), LLSTRING(CBA_tooltip_pack_progresbar)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_Category_progres)],
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
    [LLSTRING(CBA_classname_east), LLSTRING(CBA_tooltip_classname)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_classname)],
    "O_Truck_03_transport_F",
    1,
    {
        params ["_value"];
        GVAR(classnamesHash) set [east , _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnamesWest),
    "EDITBOX",
    [LLSTRING(CBA_classname_west), LLSTRING(CBA_tooltip_classname)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_classname)],
    "B_Truck_01_transport_F",
    1,
    {
        params ["_value"];
        GVAR(classnamesHash) set [west , _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnamesResistance),
    "EDITBOX",
    [LLSTRING(CBA_classname_resistance), LLSTRING(CBA_tooltip_classname)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_classname)],
    "I_Truck_02_transport_F",
    1,
    {
        params ["_value"];
        GVAR(classnamesHash) set [resistance , _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(clasnamesCivilian),
    "EDITBOX",
    [LLSTRING(CBA_classname_civilian), LLSTRING(CBA_tooltip_classname)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_classname)],
    "C_Truck_02_transport_F",
    1,
    {
        params ["_value"];
        GVAR(classnamesHash) set [civilian , _value];
    },
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(setupNotification),
    "LIST",
    [LLSTRING(CBA_whoGetsSetUpNotification), LLSTRING(CBA_whoGetsSetUpNotification_Tooltip)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_notificationCategory)],
    [[0, 1], ["Group Leaders", "Side"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(contestedNotification),
    "LIST",
    [LLSTRING(CBA_whoGetsContestedNotification), LLSTRING(CBA_whoGetsContestedNotification_Tooltip)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_notificationCategory)],
    [[0, 1], ["Group Leaders", "Side"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;

[
    QGVAR(reportEnemiesNotification),
    "LIST",
    [LLSTRING(CBA_whoGetsReportEnemiesNotification), LLSTRING(CBA_whoGetsReportEnemies_Tooltip)],
    [LLSTRING(CBA_Category_main), LLSTRING(CBA_notificationCategory)],
    [[0, 1], ["Group Leaders", "Side"], 0],
    1,
    {},
    true
] call CBA_Settings_fnc_init;