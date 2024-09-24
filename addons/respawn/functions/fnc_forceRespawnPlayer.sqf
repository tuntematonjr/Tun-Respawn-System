/*
 * Author: [Tuntematon]
 * [Description]
 * Force respawn wave
 *
 * Arguments:
 * None
 * 
 * Return Value:
 * None
 *
 * Example:
 * [] call tunres_Respawn_fnc_forceRespawnPlayer
 */
#include "script_component.hpp"
if (!hasInterface) exitWith { };

if !(player getVariable [QGVAR(isWaitingRespawn),false]) exitWith {
	ERROR("Tried to force respawn unit, whichs is not at respawn");
};

AAR_EVENT(LLSTRING(playerForceRespawned),player,nil,nil);

player setVariable [QGVAR(skipNextWave), false, true];

[1] call FUNC(upddateRespawnCount);

[QGVAR(respawnUnitEH), [playerSide, player]] call CBA_fnc_serverEvent;