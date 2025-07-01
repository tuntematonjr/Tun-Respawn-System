/*
 * Author: [Tuntematon]
 * [Description]
 * Return remaining wave time for that side
 *
 * Arguments:
 * Side
 *
 * Return Value:
 * Time in seconds
 *
 * Example:
 * [] call tunres_Respawn_fnc_getRemainingTime
 */
#include "script_component.hpp"
params["_side"];
private _hashWaitTime = GVAR(nextWaveTimesHash);
private _waitTime = _hashWaitTime get _side;

round (_waitTime - cba_missiontime)
