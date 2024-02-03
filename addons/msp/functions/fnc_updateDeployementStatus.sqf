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
 * [msp, true] call tunres_MSP_fnc_updateDeployementStatus
 */
#include "script_component.hpp"

if (!isServer) then {};

params [["_msp", objNull, [objNull]], ["_setup", nil, [false]]];

private _side = _msp getVariable QGVAR(side);
private _whoToNotify = [_side] call FUNC(whoToNotify);

AAR_UPDATE(_msp,"Is active MSP",_setup);

if (_setup) then {
	
	if (count _whoToNotify > 0 ) then {
		(call compile (localize "STR_tunres_MSP_FNC_setup_notification")) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
	};

	[_msp] remoteExecCall [QFUNC(createMspProps), 2];

	//force player out from MSP and LOCK it
	{
	    [_x, ["getOut", _msp]] remoteExecCall ["action", _x];
	} forEach crew _msp;

	[{count crew _this isEqualTo 0}, {
	    [_this, 2] remoteExecCall ["lock", _this];
	}, _msp] call CBA_fnc_waitUntilAndExecute;

} else {
	if (count _whoToNotify > 0 ) then {
		(call compile (localize "STR_tunres_MSP_FNC_pack_notification")) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
	};
	//Delete props
	{
	    deleteVehicle _x;
	} forEach (_msp getVariable QGVAR(objects));

	//Unlock vehicle
	[_msp, 0] remoteExecCall ["lock", _msp];
	_msp = objNull;
};

private _pos = getpos _msp;

[_side, _setup, _pos] remoteExecCall [QEFUNC(respawn,update_respawn_point), 2];

_msp setVariable [QGVAR(isMSP), _setup, true];
GVAR(deployementStatus) set [_side, _setup];
publicVariable QGVAR(deployementStatus);
GVAR(activeVehicle) set [_side, _msp];
publicVariable QGVAR(activeVehicle);

if (_setup) then {
	[_side, true] remoteExecCall [QFUNC(contestedCheck), 2];
} else {
	GVAR(contestedStatus) set [_side, false];
	publicVariable QGVAR(contestedStatus);
};