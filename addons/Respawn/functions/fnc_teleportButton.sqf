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
//private _tpObject = _obj getVariable [QGVAR(teleportObject), objNull];
private _destination = getpos _obj;
private _text = format["%1 %2", "STR_Tun_Respawn_Teleporting" call BIS_fnc_localize, _teleportName];

if (_teleportConditio) then {
	closeDialog 2;
	[player, _destination, _text, 10] call FUNC(teleport);
} else {
	("STR_Tun_Respawn_Teleport_Disabled" call BIS_fnc_localize) call CBA_fnc_notify;
};