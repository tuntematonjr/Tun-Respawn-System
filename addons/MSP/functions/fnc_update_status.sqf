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
 * [msp, true] call Tun_MSP_fnc_update_status
 */
#include "script_component.hpp"


params ["_msp", "_setup"];

_side = _msp getVariable QGVAR(side);
_msp_var = objNull;

AAR_UPDATE(_msp,"Is active MSP", _setup);

if (_setup) then {
	localize "STR_Tun_MSP_FNC_setup_notification" remoteExecCall ["hint", _side];

	[_msp] remoteExecCall [QFUNC(create_msp_props), 2];

	//force player out from MSP and LOCK it
	{
	    [_x, ["getOut", _msp]] remoteExecCall ["action", _x];
	} forEach crew _msp;

	[{count crew _this == 0}, {
	    [_this, 2] remoteExecCall ["lock", _this];
	}, _msp] call CBA_fnc_waitUntilAndExecute;

	_msp_var = _msp;

} else {
	localize "STR_Tun_MSP_FNC_pack_notification" remoteExecCall ["hint", _side];

	//Delete props
	{
	    deleteVehicle _x;
	} forEach (_msp getVariable QGVAR(objects));

	//Unlock vehicle
	[_msp, 0] remoteExecCall ["lock", _msp];

};

_pos = getpos _msp;

[_side, _setup, _pos] remoteExecCall ["TUN_respawn_update_respawn_point", 2];

_msp setVariable [QGVAR(isMSP), _setup, true];

switch (_side) do {
	case west: {
		missionNamespace setVariable [QGVAR(vehicle_west), _msp_var, true];
		missionNamespace setVariable [QGVAR(status_west), _setup, true];
	};

	case east: {
		missionNamespace setVariable [QGVAR(vehicle_east), _msp_var, true];
		missionNamespace setVariable [QGVAR(status_east), _setup, true];
	};

	case resistance: {
		missionNamespace setVariable [QGVAR(vehicle_guer), _msp_var, true];
		missionNamespace setVariable [QGVAR(status_guer), _setup, true];
	};

	case civilian: {
		missionNamespace setVariable [QGVAR(vehicle_civ), _msp_var, true];
		missionNamespace setVariable [QGVAR(status_civ), _setup, true];
	};
};

if (_setup) then {
	[] call FUNC(force_contested_check);
};