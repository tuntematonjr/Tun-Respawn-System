/*
 * Author: [Tuntematon]
 * [Description]
 * Depending what respawn style is chosen. Chose fnc acording that.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call TUN_Respawn_fnc_killed

 */
#include "script_component.hpp"


setPlayerRespawnTime 99999;
( "BIS_fnc_respawnSpectator" call BIS_fnc_rscLayer ) cutText [ "", "PLAIN" ];

missionNamespace getVariable format ["%1_%2", QGVAR(tickets), playerSide];


switch (GVAR(respawn_type)) do {
	case "Sidetickets": {
		[playerSide, player] remoteExecCall [QFUNC(ticketCountterSide),2];
	};
	case "Playertickets": {
		//WIP
	};

	default {
		setPlayerRespawnTime 5;
	};
};