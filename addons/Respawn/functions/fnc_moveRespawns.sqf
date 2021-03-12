/*
 * Author: [Tuntematon]
 * [Description]
 * Move respawns and give gear
 *
 * Arguments:
 * 0: ("west","east","resistance","civilian") <STRING>
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["side"] call Tun_Respawn_fnc_moveRespawns
 */
#include "script_component.hpp"
params ["_side"];
private ["_respawn_position", "_respawn_waitingarea", "_respawn_gearPath"];

if (!isServer) exitWith { };

private _players_in_respawn = [];

switch toLower(_side) do {
	case "west": {
		_respawn_position = getpos (GVAR(respawnpos_west) select 1);
		_respawn_waitingarea = getpos (GVAR(waitingarea_west) select 1);
	};

	case "east": {
		_respawn_position = getpos (GVAR(respawnpos_east) select 1);
		_respawn_waitingarea = getpos (GVAR(waitingarea_east) select 1);
	};

	case "guer": {
		_respawn_position = getpos (GVAR(respawnpos_guer) select 1);
		_respawn_waitingarea = getpos (GVAR(waitingarea_guer) select 1);
	};

	case "civ": {
		_respawn_position = getpos (GVAR(respawnpos_civ) select 1);
		_respawn_waitingarea = getpos (GVAR(waitingarea_civ) select 1);
	};

	default {
		ERROR_MSG("Move respawn FNC missing side param!");
	};
};

//Sort out delayed respawn play
{
	_player = _x;
	if !(_player getVariable [QGVAR(skip_next_wave), false]) then {
		_players_in_respawn pushBackUnique _player;
	} else {
		_player setVariable [QGVAR(skip_next_wave), false, true];
	};
} forEach (allPlayers inAreaArray [_respawn_waitingarea, GVAR(waiting_area_range) + 10, GVAR(waiting_area_range) + 10, 0, false]);

//RPT data
_count = count _players_in_respawn;
_text = format ["Respawn count: %1, %2", _count, _side];
INFO(_text);

//move
private _timeChange = 0.2;

private _fnc_timeisUp = {
    params [["_player", objNull, [objnull]],"_respawn_waitingarea", "_respawn_position", "_side"];
    if (isnull _player || !(_player in allPlayers) ) exitWith {false};

    _player setVariable [QGVAR(waiting_respawn), false, true];
	private _text = "STR_Tun_Respawn_FNC_moveRespawns" call BIS_fnc_localize;
	[_player, _respawn_position, _text, 20] call FUNC(teleport);
    remoteExecCall [QFUNC(addGear), _player];
};

{
	_player = _x;
	if (isnull _player) exitWith {false};
    private _execWaitTime = _timeChange * _forEachIndex;
    [_fnc_timeisUp, [_player, _respawn_waitingarea, _respawn_position, _side], _execWaitTime] call CBA_fnc_waitAndExecute;
} forEach _players_in_respawn;

INFO(format ["Side %1 all respawn units moved", _side]);