/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [] call Tun_Respawn_fnc_teleportButton
 */
#include "script_component.hpp"

private _listIDC = 300001;
private _okButtonIDC = 300002;

private _index = lbCurSel _listIDC;

if (_index == -1) exitWith { };

private _value = lbData [_listIDC, _index];
private _obj = _value call BIS_fnc_objectFromNetId;

private _teleportConditio = call compile (_obj getVariable [QGVAR(teleportConditio), true]);
private _teleportName = _obj getVariable [QGVAR(teleportName), "TP"];
private _tpObject = _obj getVariable [QGVAR(teleportObject), objNull];
private _destination = getpos _tpObject;
private _text = localize "STR_Tun_Respawn_Teleporting";

private _enabledSide = switch (playerSide) do {
	case west: { _obj getVariable [QGVAR(teleportEnableWest), false] };
	case east: { _obj getVariable [QGVAR(teleportEnableEast), false] };
	case resistance: { _obj getVariable [QGVAR(teleportEnableResistance), false] };
	case civilian: { _obj getVariable [QGVAR(teleportEnableCivilian), false] };
	default { false };
};

if (_teleportConditio && _enabledSide) then {
	closeDialog 2;
	[player, _destination, _text, 10] call FUNC(teleport);	
} else {
	hint localize "STR_Tun_Respawn_Teleport_Disabled";
};
