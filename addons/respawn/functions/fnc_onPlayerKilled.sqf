/*
 * Author: [Tuntematon]
 * [Description]
 * Depending what respawn style is chosen.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunres_Respawn_fnc_onPlayerKilled

 */
#include "script_component.hpp"

setPlayerRespawnTime 99999;
( "BIS_fnc_respawnSpectator" call BIS_fnc_rscLayer ) cutText [ "", "PLAIN" ];

if (GVAR(endRespawns)) exitWith {
	[{
		remoteExecCall [QFUNC(startSpectator), _this];
	}, player, 5] call CBA_fnc_waitAndExecute;
};

switch (GVAR(respawnType)) do {
	case 0: {
		setPlayerRespawnTime 5;
	};
	case 1: {
		[playerSide, player] remoteExecCall [QFUNC(bleedSideTicketCountOnDeath),2];
	};
	case 2: {
		[playerSide, player] remoteExecCall [QFUNC(bleedPlayerTicketCountOnDeath),2];
	};
	default {};
};