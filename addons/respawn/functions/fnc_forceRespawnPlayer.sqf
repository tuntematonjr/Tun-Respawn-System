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

if !(player getVariable [QGVAR(isWaitingRespawn),false]) exitWith {
	ERROR("Tried to force respawn unit, whichs is not at respawn");
};

player setVariable [QGVAR(skipNextWave), false, true];

[QGVAR(respawnUnitEH), [playerSide, player]] call CBA_fnc_serverEvent;