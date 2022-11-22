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
if (!isServer) exitWith { };

switch (toLower str _side) do {
	case "west": {
		if ( GVAR(tickets_west) > 0 ) then {
			//if player disconnected and came back. So no ticket wasted.
			if (getPlayerUID _player in GVAR(disconnected_players)) then {
				REM(GVAR(disconnected_players), (getPlayerUID _player));
			} else {
				DEC(GVAR(tickets_west));
				AAR_UPDATE("west","Side tickets", GVAR(tickets_west));
				publicVariable QGVAR(tickets_west);
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
				AAR_UPDATE("east","Side tickets", GVAR(tickets_east));
				publicVariable QGVAR(tickets_east);
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
				AAR_UPDATE("guer","Side tickets", GVAR(tickets_guer));
				publicVariable QGVAR(tickets_guer);
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
			} else {
				DEC(GVAR(tickets_civ));
				AAR_UPDATE("civ","Side tickets", GVAR(tickets_civ));
				publicVariable QGVAR(tickets_civ);
			};

			[5] remoteExecCall ["setPlayerRespawnTime", _player];
		} else {
			remoteExecCall [QFUNC(startSpectator), _player];
		};
	};

	default {
		systemChat "Side ticket error";
	};
};
