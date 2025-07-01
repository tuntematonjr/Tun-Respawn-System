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

[QGVAR(setPlayerRespawnTimeEH), 99999, _player] call CBA_fnc_targetEvent;

( "BIS_fnc_respawnSpectator" call BIS_fnc_rscLayer ) cutText [ "", "PLAIN" ];

if (GVAR(endRespawns)) exitWith {
	[{
		[QGVAR(startSpectatorEH), nil, _this] call CBA_fnc_targetEvent;
	}, _player, 5] call CBA_fnc_waitAndExecute;
};

if (GVAR(respawnType) isEqualTo 0) then {
	[QGVAR(setPlayerRespawnTimeEH), 5, _player] call CBA_fnc_targetEvent;
} else {
	[_player] remoteExecCall [QFUNC(bleedTicketCountOnDeath),2];
};
