/*
 * Author: [Tuntematon]
 * [Description]
 * Return remaining wave time for that side
 *
 * Arguments:
 * Side
 * Is delayed
 *
 * Return Value:
 * Waiting respawn count
 *
 * Example:
 * [west, false] call tunres_Respawn_fnc_getWaitingRespawnCount
 */
#include "script_component.hpp"
params[["_side",sideLogic,[west]],["_isDelayd",false,[false]]];

private _count = (GVAR(waitingRespawnCountHash) getOrDefault [_side, [0,0]]) select (parseNumber _isDelayd);

_count
