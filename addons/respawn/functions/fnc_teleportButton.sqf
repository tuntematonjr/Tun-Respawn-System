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
 * [] call tunres_Respawn_fnc_teleportButton
 */
#include "script_component.hpp"

private _listIDC = 300001;
private _okButtonIDC = 300002;

private _index = lbCurSel _listIDC;

if (_index isEqualTo -1) exitWith { };

private _value = lbData [_listIDC, _index];
private _obj = _value call BIS_fnc_objectFromNetId;

private _teleportConditioText = format ["_target = '%1' call BIS_fnc_objectFromNetId; %2",GVAR(tpMenuOpenedFrom) call BIS_fnc_netId, _obj getVariable [QGVAR(teleportConditio), "true"]];
private _teleportConditio = call compile (_teleportConditioText);

private _teleportName = _obj getVariable [QGVAR(teleportName), "TP"];

private _destination = getPosASL _obj;
private _text = format["%1 %2", LLSTRING(Teleporting), _teleportName];

if (_teleportConditio) then {
	closeDialog 2;
	GVAR(tpMenuOpenedFrom) = objNull;
	[player, _destination, _text, 30, true, 20] call FUNC(teleportUnit);
} else {
	[QEGVAR(main,doNotification), [LLSTRING(Teleport_Disabled)]] call CBA_fnc_localEvent;
};