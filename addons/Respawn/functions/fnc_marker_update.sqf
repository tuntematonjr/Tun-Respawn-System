/*
 * Author: [Tuntematon]
 * [Description]
 * Update all marker alphas. If in waiting area, makes respawn marker BIG!
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_Respawn_fnc_marker_update
 */
#include "script_component.hpp"

if (isDedicated) exitWith { };
params [["_backToBase", false]];
private _contestedStatus = true;
private _status = false;
private _marker = "";
switch (playerSide) do {
	case west: {
		_contestedStatus = missionNamespace getVariable ["tun_msp_contested_west", objNull];
		_status = missionNamespace getVariable ["tun_msp_status_west", false];
		_marker = "tun_respawn_west";
	};

	case east: {
		_contestedStatus = missionNamespace getVariable ["tun_msp_contested_east", objNull];
		_status = missionNamespace getVariable ["tun_msp_status_east", false];
		_marker = "tun_respawn_east";
	};

	case resistance: {
		_contestedStatus = missionNamespace getVariable ["tun_msp_contested_guer", objNull];
		_status = missionNamespace getVariable ["tun_msp_status_guer", false];
		_marker = "tun_respawn_guerrila";
	};

	case civilian: {
		_contestedStatus = missionNamespace getVariable ["tun_msp_contested_civ", objNull];
		_status = missionNamespace getVariable ["tun_msp_status_civ", false];
		_marker = "tun_respawn_civilian";
	};
};

private _mainMarker = format["%1_mainbase",_marker];
_marker setMarkerAlphaLocal 1;

//show main base if msp is
if (_status && !_contestedStatus) then {
	_mainMarker setMarkerAlphaLocal 1;
} else{
	_mainMarker setMarkerAlphaLocal 0;
};

//maker marker bigger, if waiting respawn just because
if (player getvariable [QGVAR(waiting_respawn), false]) then {
	_marker setMarkerSizeLocal [3,3];
} else {
	_marker setMarkerSizeLocal [1,1];
};