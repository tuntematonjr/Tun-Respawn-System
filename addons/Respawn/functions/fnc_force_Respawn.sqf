﻿/*
 * Author: [Tuntematon]
 * [Description]
 * Force respawn wave
 *
 * Arguments:
 * 0: Side ("west", "east", "guer", "civ") <STRING>
 * 1: Reset Timer  <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["something", player] call Tun_Respawn_fnc_force_Respawn
 */
#include "script_component.hpp"

params [["_side", nil, [""]], ["_reset", false, [false]]];

[_side] call FUNC(moveRespawns);

if (_reset) then {
	[_side] call FUNC(timer);
};