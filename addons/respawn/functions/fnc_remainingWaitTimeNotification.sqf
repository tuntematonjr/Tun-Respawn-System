/*
 * Author: [Tuntematon]
 * [Description]
 *
 *
 * Arguments:
 * 0: None
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [] call tunres_respawn_fnc_remainingWaitTimeNotification
 */
#include "script_component.hpp"

private _hash = GVAR(nextWaveTimes);
private _waitTime = (_hash get playerSide) - cba_missiontime;
format [localize "STR_tunres_MSP_remaining_time", [_waitTime] call CBA_fnc_formatElapsedTime] call CBA_fnc_notify;