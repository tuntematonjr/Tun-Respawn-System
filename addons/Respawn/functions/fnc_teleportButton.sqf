/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument <OBJECT>
 * 2: Multiple input types <STRING|ARRAY|CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE|STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: nil)
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["something", player] call Tun_Respawn_fnc_teleportButton
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"

private _listIDC = 300001;
private _okButtonIDC = 300002;

private _index = lbCurSel _listIDC;
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
