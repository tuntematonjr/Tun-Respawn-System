/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Unit who to teleport <OBJECT>
 * 1: Coordinates where to TP <[ARRAY]>
 * 2: Text shown <STRING>
 * 3: Spread Range <NUMBER>
 *
 * Return Value:
 * The return true when done <BOOL>
 *
 * Example:
 * [_unit, _destination, _text, _range] call Tun_Respawn_fnc_teleport
 */
#include "script_component.hpp"

params [["_unit", objNull, [objNull]],
		["_destination", [0,0,0], [[]]], 
		["_text", "", [""]],
		["_range", 10, [0]]
];

[_text, 10] remoteExecCall [QFUNC(blackscreen), _unit]; // make player screen black and prevent them moving right away so server can keep up.

_unit setPos ([_destination, _range] call CBA_fnc_randPos);

[QGVAR(EH_unitTeleported), [_unit, _destination]] call CBA_fnc_serverEvent;

true