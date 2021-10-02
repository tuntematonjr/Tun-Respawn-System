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
 * [_unit, _destination, _text, _range] call Tun_Respawn_fnc_teleport
 *
 * Public: [Yes/No]
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