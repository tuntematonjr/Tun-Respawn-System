/*
 * Author: [Tuntematon]
 * [Description]
 * Force respawn wave
 *
 * Arguments:
 * 0: Side (west, east, resistance, civilian) <SIDE>
 * 1: Reset Timer  <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [west, false] call tunres_Respawn_fnc_forceRespawnWave
 */
#include "script_component.hpp"

if (!isServer) exitWith { };

params [["_side", nil, [east]], ["_reset", false, [false]]];

[_side, true] call FUNC(doRespawnWave);

if (_reset && { !(GVAR(forcedRespawn)) }) then {
	[_side] call FUNC(timer);
};