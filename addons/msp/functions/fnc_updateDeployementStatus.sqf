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

params [["_msp", objNull, [objNull]], ["_setup", nil, [false]], "_player"];

private _side = _msp getVariable QGVAR(side);
AAR_UPDATE(_msp,"Is active MSP",_setup);

if (_setup) then {
	[_msp] remoteExecCall [QFUNC(createMspProps), 2];

	//force player out from MSP and LOCK it
	{
	    [_x, ["getOut", _msp]] remoteExecCall ["action", _x];
	} forEach crew _msp;

	[{count crew _this isEqualTo 0}, {
	    [_this, 2] remoteExecCall ["lock", _this];
	}, _msp] call CBA_fnc_waitUntilAndExecute;

} else {
	//Delete props
	{
	    deleteVehicle _x;
	} forEach (_msp getVariable QGVAR(objects));

	//Unlock vehicle
	[_msp, 0] remoteExecCall ["lock", _msp];

};

private _whoToNotify = [_side, GVAR(setupNotification)] call FUNC(whoToNotify);
if (_whoToNotify isNotEqualTo [] ) then {
	private _text = localize (["STR_tunres_MSP_FNC_pack_notification", "STR_tunres_MSP_FNC_setup_notification"] select _setup);
	[QEGVAR(main,doNotification), [_text], _whoToNotify] call CBA_fnc_targetEvent;
};

private _pos = getPosASL _msp;

[QEGVAR(respawn,updateRespawnPointEH), [_side, _setup, _pos]] call CBA_fnc_serverEvent;

_msp setVariable [QGVAR(isMSP), _setup, true];
GVAR(deployementStatusHash) set [_side, _setup];
publicVariable QGVAR(deployementStatusHash);
GVAR(activeVehicleHash) set [_side, [objNull, _msp] select _setup];
publicVariable QGVAR(activeVehicleHash);

if (AAR_IS_ENABLED) then {
	private _text = localize(["STR_tunres_MSP_AAR_MSP_Packed","STR_tunres_MSP_AAR_MSP_Deployed"] select _setup);
	_text = format[_text, _side];

	AAR_EVENT(_text,_msp,_player,nil);
};

//Change deployement status
if !(_setup) then {
	GVAR(contestedStatusHash) set [_side, false];
	publicVariable QGVAR(contestedStatusHash);
};

[QGVAR(startContestedChecksEH), [_side, _setup]] call CBA_fnc_serverEvent;
[QGVAR(EH_mspStatusUpdate), [_msp, _setup]] call CBA_fnc_globalEvent;