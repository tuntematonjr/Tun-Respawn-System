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
	[{remoteExecCall [QFUNC(startSpectator), _this];}, _player, 5] call CBA_fnc_waitAndExecute;
};

switch (GVAR(respawn_type)) do {
	case localize "STR_tunres_Respawn_Type_Sidetickets": {
		[playerSide, player] remoteExecCall [QFUNC(bleedSideTicketCountOnDeath),2];
	};

	case localize "STR_tunres_Respawn_Type_Playertickets": {
		[playerSide, player] remoteExecCall [QFUNC(bleedPlayerTicketCountOnDeath),2];
	};

	default {
		setPlayerRespawnTime 5;
	};
};