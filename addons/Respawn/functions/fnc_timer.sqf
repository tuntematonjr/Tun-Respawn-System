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

if (GVAR(forced_respawn)) exitWith { INFO("No timer, Only forced waves"); };
private ["_wait_time_var", "_allow_respawn_var"];

switch (_side) do {
	case "west": {
		GVAR(wait_time_west) = GVAR(wait_time_west) + GVAR(time_west) * 60;
		_wait_time_var = QGVAR(wait_time_west);
		_allow_respawn_var = QGVAR(allow_respawn_west);
		publicVariable QGVAR(wait_time_west);
	};

	case "east": {
		GVAR(wait_time_east) = GVAR(wait_time_east) + GVAR(time_east) * 60;
		_wait_time_var = QGVAR(wait_time_east);
		_allow_respawn_var = QGVAR(allow_respawn_east);
		publicVariable QGVAR(wait_time_east);
	};

	case "guer": {
		GVAR(wait_time_guer) = GVAR(wait_time_guer) + GVAR(time_guer) * 60;
		_wait_time_var = QGVAR(wait_time_guer);
		_allow_respawn_var = QGVAR(allow_respawn_guer);
		publicVariable QGVAR(wait_time_guer);
	};

	case "civ": {
		GVAR(wait_time_civ) = GVAR(wait_time_civ) + GVAR(time_civ) * 60;
		_wait_time_var = QGVAR(wait_time_civ);
		_allow_respawn_var = QGVAR(allow_respawn_civ);
		publicVariable QGVAR(wait_time_civ);
	};

	default {
		ERROR_MSG("respawn timer FNC missing side param!");
	};
};

if !( _side in GVAR(timer_running) ) then {
	GVAR(timer_running) pushBack _side;
	[{ missionNamespace getVariable (_this select 2) && { cba_missiontime >= missionNamespace getVariable (_this select 1) } }, {

		private _side = _this select 0;
		REM(GVAR(timer_running), _side);
		[_side] call FUNC(moveRespawns);
		[_side] call FUNC(timer);
	}, [_side, _wait_time_var, _allow_respawn_var]] call CBA_fnc_waitUntilAndExecute;
};