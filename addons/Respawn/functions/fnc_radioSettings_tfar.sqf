/*
 * Author: [ gruppe-adler ]
 * https://github.com/gruppe-adler/TvT_Template.VR/blob/master/functions/linearSD/fn_transferRadiosAcrossRespawn.sqf
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_Respawn_fnc_radioSettings_tfar
 */
#include "script_component.hpp"

if (!hasInterface || { !(isClass(configFile >> "CfgPatches" >> "tfar_core")) }) exitWith { };

// save entire settings array once anything is changed basically
private _fnc_saveSWSettings = {
    params ["_unit"];
    if (_unit != player) exitWith {};
    player setVariable [QGVAR(swSettings),(call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSettings];
};

{[_x,_fnc_saveSWSettings] call CBA_fnc_addEventHandler} forEach [
    "TFAR_event_OnSWchannelSet",
    "TFAR_event_OnSWstereoSet",
    "TFAR_event_OnSWvolumeSet",
    "TFAR_event_OnSWChange",
    "TFAR_event_OnSWspeakersSet"
];

// same for longrange
private _fnc_saveLRSettings = {
    params ["_unit"];

    if (_unit != player) exitWith {};
    [{
        player setVariable [QGVAR(lrSettings),(call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrSettings];
    }] call CBA_fnc_execNextFrame;
    
};

{[_x,_fnc_saveLRSettings] call CBA_fnc_addEventHandler} forEach [
    "TFAR_event_OnLRchannelSet",
    "TFAR_event_OnLRstereoSet",
    "TFAR_event_OnLRvolumeSet",
    "TFAR_event_OnLRChange",
    "TFAR_event_OnLRspeakersSet"
];

// frequency changed event gets special treatment, because it fires for both sw and lr
[
    "TFAR_event_OnFrequencyChanged",
    {
        params ["_unit","_radio"];
        if (_unit != player) exitWith {};

        private _activeSw = call TFAR_fnc_activeSwRadio;
        if (_activeSw isEqualTo _radio) exitWith {
            player setVariable [QGVAR(swSettings),(call TFAR_fnc_activeSwRadio) call TFAR_fnc_getSwSettings];
        };

        private _activeLr = call TFAR_fnc_activeLRRadio;
        if (_activeLr isEqualTo _radio) exitWith {
            player setVariable [QGVAR(lrSettings),(call TFAR_fnc_activeLrRadio) call TFAR_fnc_getLrSettings];
        };
    }
] call CBA_fnc_addEventHandler;

// apply SR settings every time a radio is instanced
[
    "TFAR_event_OnRadiosReceived",
    {
        params ["_unit","_radio"];
        if (_unit != player) exitWith {};
        private _settings = player getVariable [QGVAR(swSettings),[]];
        if (count _settings > 0) then {
            [call TFAR_fnc_activeSwRadio, _settings] call TFAR_fnc_setSwSettings;
        };
    }
] call CBA_fnc_addEventHandler;

// apply LR settings every time a new loadout is applied
[
    QGVAR(setTfarLRsettings_EH),
    {
        params ["_unit"];
        if (_unit != player) exitWith {};

        private _settings = player getVariable [QGVAR(lrSettings),[]];
        if (count _settings > 0) then {
            [
                {
                    params ["_unit"];
                    backpack _unit call TFAR_fnc_isLRRadio
                },
                {
                    params ["_unit","_settings"];
                    [call TFAR_fnc_activeLrRadio, _settings] call TFAR_fnc_setLrSettings;
                },
                [_unit,_settings],
                5
            ] call CBA_fnc_waitUntilAndExecute;
        };
    }
] call CBA_fnc_addEventHandler;