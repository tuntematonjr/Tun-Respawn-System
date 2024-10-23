/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Unit who to teleport <OBJECT>
 * 1: Coordinates where to TP <[ARRAY]>
 * 2: Text shown <STRING>
 * 3: Spread Range <NUMBER>
 * 4: Enable god mode <BOOL>
 * 5: God mode duration <NUMBER>
 *
 * Return Value:
 * The return true when done <BOOL>
 *
 * Example:
 * [_unit, _destination, _text, _range, true, 30] call tunres_Respawn_fnc_teleportUnit
 */
#include "script_component.hpp"

params [["_unit", objNull, [objNull]],
		["_destination", [0,0,0], [[]]], 
		["_text", "", [""]],
		["_range", 10, [0]],
		["_godMode", false, [false]],
		["_godModeLenght", 30, [0]]
];

if (_unit isEqualTo objNull) exitWith {LOG("unit was objnull when teleporting")};

if (_godMode) then {
	[_unit, _godModeLenght] remoteExecCall [QFUNC(godMode), _unit];
};

[_text, 10] remoteExecCall [QFUNC(blackscreen), _unit]; // make player screen black and prevent them moving right away so server can keep up.

_unit setPosASL ([_destination, _range] call CBA_fnc_randPos);

[QGVAR(EH_unitTeleported), [_unit, _destination]] call CBA_fnc_serverEvent;

true