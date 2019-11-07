/*
 * Author: [Tuntematon]
 * [Description]
 * Move respawns and give gear
 * Arguments:
 * 0: ("west","east","resistance","civilian") <STRING>
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["side"] call Tun_Respawn_fnc_moveRespawns
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
params ["_side"];
private ["_respawn_position", "_respawn_waitingarea", "_respawn_gearPath"];


switch toLower(_side) do {
	case "west": {
		_respawn_position = getMarkerPos "TUN_respawn_west";
		_respawn_waitingarea = getMarkerPos "respawn_west";
	};

	case "east": {
		_respawn_position = getMarkerPos "TUN_respawn_east";
		_respawn_waitingarea = getMarkerPos "respawn_east";
	};

	case "guer": {
		_respawn_position = getMarkerPos "TUN_respawn_guerrila";
		_respawn_waitingarea = getMarkerPos "respawn_guerrila";
	};

	case "civ": {
		_respawn_position = getMarkerPos "TUN_respawn_civilian";
		_respawn_waitingarea = getMarkerPos "respawn_civilian";
	};

	default {
		hint "Move respawn FNC missing side param!";
	};
};

//move
[{
	_args params ["_respawn_waitingarea", "_respawn_position", "_side"];
	private _players = allPlayers inAreaArray [_respawn_waitingarea, 50, 50, 0, false];



	if (count _players > 0) then {
		_player = _players select 0;

		["You are prepared to respawn!",15] remoteExecCall [QFUNC(blackscreen), _player]; // make player screen black and prevent them moving right away so server can keep up.

		_player setVariable [QGVAR(waiting_respawn), false, true];
		_player setPos ([_respawn_position, 10] call CBA_fnc_randPos);
		remoteExecCall [QFUNC(addGear), _player];


	} else {
		LOG(format ["Side %1 all respawn units moved", _side]);
		[_handle] call CBA_fnc_removePerFrameHandler;
	};
}, 0.1, [_respawn_waitingarea, _respawn_position, _side]] call CBA_fnc_addPerFrameHandler;



