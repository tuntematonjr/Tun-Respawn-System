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
params[["_player", objNull, [objNull]]];

setPlayerRespawnTime 99999;
( "BIS_fnc_respawnSpectator" call BIS_fnc_rscLayer ) cutText [ "", "PLAIN" ];

if (GVAR(endRespawns)) exitWith {
	[{
		[QGVAR(startSpectatorEH), "", _this] call CBA_fnc_targetEvent;
	}, player, 5] call CBA_fnc_waitAndExecute;
	}, _player, 5] call CBA_fnc_waitAndExecute;
};

if (GVAR(respawnType) isEqualTo 0) then {
	setPlayerRespawnTime 5;
} else {
	[_player] remoteExecCall [QFUNC(bleedTicketCountOnDeath),2];
};