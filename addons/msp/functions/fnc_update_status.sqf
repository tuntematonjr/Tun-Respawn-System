/*
 * Author: [Tuntematon]
 * [Description]
 *
 *
 * Arguments:
 * 0: MSP <OBJ>
 * 1: True: Setup MSP. False: Pack MSP <BOOL>
 *
 * Return Value:
 * none
 *
 * Example:
 * [msp, true] call tunres_MSP_fnc_update_status
 */
#include "script_component.hpp"

params ["_msp", "_setup"];

private _side = _msp getVariable QGVAR(side);
private _msp_var = objNull;
private _whoToNotify = [_side] call FUNC(whoToNotify);

AAR_UPDATE(_msp,"Is active MSP", _setup);

if (_setup) then {
	
	if (count _whoToNotify > 0 ) then {
		(call compile ("STR_tunres_MSP_FNC_setup_notification" call BIS_fnc_localize)) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
	};

	[_msp] remoteExecCall [QFUNC(create_msp_props), 2];

	//force player out from MSP and LOCK it
	{
	    [_x, ["getOut", _msp]] remoteExecCall ["action", _x];
	} forEach crew _msp;

	[{count crew _this isEqualTo 0}, {
	    [_this, 2] remoteExecCall ["lock", _this];
	}, _msp] call CBA_fnc_waitUntilAndExecute;

	_msp_var = _msp;

} else {
	if (count _whoToNotify > 0 ) then {
		(call compile ("STR_tunres_MSP_FNC_pack_notification" call BIS_fnc_localize)) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
	};
	//Delete props
	{
	    deleteVehicle _x;
	} forEach (_msp getVariable QGVAR(objects));

	//Unlock vehicle
	[_msp, 0] remoteExecCall ["lock", _msp];

};

private _pos = getpos _msp;

[_side, _setup, _pos] remoteExecCall [QEFUNC(respawn,update_respawn_point), 2];

_msp setVariable [QGVAR(isMSP), _setup, true];

switch (_side) do {
	case west: {
		missionNamespace setVariable [QGVAR(vehicle_west), _msp_var, true];
		missionNamespace setVariable [QGVAR(status_west), _setup, true];
		if !(_setup) then {
			missionNamespace setVariable [QGVAR(contested_west), false, true];
		};
	};

	case east: {
		missionNamespace setVariable [QGVAR(vehicle_east), _msp_var, true];
		missionNamespace setVariable [QGVAR(status_east), _setup, true];
		if !(_setup) then {
			missionNamespace setVariable [QGVAR(contested_east), false, true];
		};
	};

	case resistance: {
		missionNamespace setVariable [QGVAR(vehicle_guer), _msp_var, true];
		missionNamespace setVariable [QGVAR(status_guer), _setup, true];
		if !(_setup) then {
			missionNamespace setVariable [QGVAR(contested_guer), false, true];
		};
	};

	case civilian: {
		missionNamespace setVariable [QGVAR(vehicle_civ), _msp_var, true];
		missionNamespace setVariable [QGVAR(status_civ), _setup, true];
		if !(_setup) then {
			missionNamespace setVariable [QGVAR(contested_civ), false, true];
		};
	};
};

if (_setup) then {
	[] remoteExecCall [QFUNC(contestedCheck), 2];
};