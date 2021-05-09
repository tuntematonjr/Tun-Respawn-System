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

private _msp = objNull;
private _status = false;
private _marker = "";
switch (playerSide) do {
	case west: {
		_msp = missionNamespace getVariable [QEGVAR(msp,vehicle_west), objNull];
		_status = missionNamespace getVariable [QEGVAR(msp,status_west), false];
		_marker = "tun_respawn_west";
	};

	case east: {
		_msp = missionNamespace getVariable [QEGVAR(msp,vehicle_east), objNull];
		_status = missionNamespace getVariable [QEGVAR(msp,status_east), false];
		_marker = "tun_respawn_east";
	};

	case resistance: {
		_msp = missionNamespace getVariable [QEGVAR(msp,vehicle_guer), objNull];
		_status = missionNamespace getVariable [QEGVAR(msp,status_guer), false];
		_marker = "tun_respawn_guerrila";
	};

	case civilian: {
		_msp = missionNamespace getVariable [QEGVAR(msp,vehicle_civ), objNull];
		_status = missionNamespace getVariable [QEGVAR(msp,status_civ), false];
		_marker = "tun_respawn_civilian";
	};
};

private _mainMarker = format["%1_mainbase",_marker];
_marker setMarkerAlphaLocal 1;

//show main base if msp is
if (!isNull _msp && _status && alive _msp) then {
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