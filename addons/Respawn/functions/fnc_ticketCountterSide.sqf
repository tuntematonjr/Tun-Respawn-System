/*
 * Author: [Tuntematon]
 * [Description]
 * Count side tickest
 *
 * Arguments:
 * 0: Playerside <side>
 * 1: player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [side, player] call TUN_Respawn_fnc_ticketCounterSide
 */
#include "script_component.hpp"
params ["_side","_player"];


switch (toLower str _side) do {
	case "west": {
		if ( GVAR(tickets_west) > 0 ) then {
			//if player disconnected and came back. So no ticket wasted.
			if (getPlayerUID _player in GVAR(disconnected_players)) then {
				REM(GVAR(disconnected_players), (getPlayerUID _player));
			} else {
				DEC(GVAR(tickets_west));
			};

			[5] remoteExecCall ["setPlayerRespawnTime", _player];
		} else {
			remoteExecCall [QFUNC(startSpectator), _player];
		};
	};

	case "east": {
		if ( GVAR(tickets_east) > 0 ) then {
			//if player disconnected and came back. So no ticket wasted.
			if (getPlayerUID _player in GVAR(disconnected_players)) then {
				REM(GVAR(disconnected_players), (getPlayerUID _player));
			} else {
				DEC(GVAR(tickets_east));
			};

			[5] remoteExecCall ["setPlayerRespawnTime", _player];
		} else {
			remoteExecCall [QFUNC(startSpectator), _player];
		};
	};

	case "guer": {
		if ( GVAR(tickets_guer) > 0 ) then {
			//if player disconnected and came back. So no ticket wasted.
			if (getPlayerUID _player in GVAR(disconnected_players)) then {
				REM(GVAR(disconnected_players), (getPlayerUID _player));
			} else {
				DEC(GVAR(tickets_guer));
			};

			[5] remoteExecCall ["setPlayerRespawnTime", _player];
		} else {
			remoteExecCall [QFUNC(startSpectator), _player];
		};
	};

	case "civ": {
		if ( GVAR(tickets_civ) > 0 ) then {
			//if player disconnected and came back. So no ticket wasted.
			if (getPlayerUID _player in GVAR(disconnected_players)) then {
				REM(GVAR(disconnected_players), (getPlayerUID _player));
				_text = format ["Ticket not used, %1 disconnected and came back", _player];
				INFO(_text);
			} else {
				DEC(GVAR(tickets_civ));
			};

			[5] remoteExecCall ["setPlayerRespawnTime", _player];
		} else {
			remoteExecCall [QFUNC(startSpectator), _player];
		};
	};

	default {
		systemChat "side tiketti fnc kysee";
	};
};
