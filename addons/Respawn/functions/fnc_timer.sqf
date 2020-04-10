/*
 * Author: [Tuntematon]
 * [Description]
 * Timer
 *
 * Arguments:
 * 0: side <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["west"] call TUN_Respawn_fnc_timer
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
		ok1 = _wait_time;
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

