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

//RPT data
_players = allPlayers inAreaArray [_respawn_waitingarea, 50, 50, 0, false];
_count = count _players;
_text = format ["Respawn count: %1, %2", _count, _side];
INFO(_text);

//move
[{
	_args params ["_respawn_waitingarea", "_respawn_position", "_side"];
	private _players = allPlayers inAreaArray [_respawn_waitingarea, 50, 50, 0, false];

	if (count _players > 0) then {
		_player = _players select 0;

		[localize "STR_Tun_Respawn_FNC_moveRespawns",15] remoteExecCall [QFUNC(blackscreen), _player]; // make player screen black and prevent them moving right away so server can keep up.

		_player setVariable [QGVAR(waiting_respawn), false, true];
		_player setPos ([_respawn_position, 10] call CBA_fnc_randPos);
		remoteExecCall [QFUNC(addGear), _player];

	} else {
		INFO(format ["Side %1 all respawn units moved", _side]);
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
}, 0.1, [_respawn_waitingarea, _respawn_position, _side]] call CBA_fnc_addPerFrameHandler;