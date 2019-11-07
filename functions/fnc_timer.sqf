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
 * ["something", player] call TUN_Respawn_fnc_timer
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
params ["_side"];

private _wait_time = 0;
//systemChat ("timer " + _side);

switch (_side) do {
	case "west": {
		GVAR(wait_time_west) = GVAR(wait_time_west) + GVAR(times_west) * 60;
		_wait_time = GVAR(times_west) * 60;
		publicVariable QGVAR(wait_time_west);
	};

	case "east": {
		GVAR(wait_time_east) = GVAR(wait_time_east) + GVAR(times_east) * 60;
		_wait_time = GVAR(times_east) * 60;
		publicVariable QGVAR(wait_time_east);
	};

	case "guer": {
		GVAR(wait_time_guer) = GVAR(wait_time_guer) + GVAR(times_guer) * 60;
		_wait_time = GVAR(times_guer) * 60;
		publicVariable QGVAR(wait_time_guer);
	};

	case "civ": {
		GVAR(wait_time_civ) = GVAR(wait_time_civ) + GVAR(times_civ) * 60;
		_wait_time = GVAR(times_civ) * 60;
		publicVariable QGVAR(wait_time_civ);
	};

	default {
		hint "respawn timer FNC missing side param!";
	};
};

if (_wait_time > 0) then {
	[{
		[_this select 0] call FUNC(moveRespawns);
		[_this select 0] call FUNC(timer);
	}, [_side], _wait_time] call CBA_fnc_waitAndExecute;
};

