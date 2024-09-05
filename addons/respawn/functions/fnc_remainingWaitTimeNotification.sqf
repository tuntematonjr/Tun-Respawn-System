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

private _hash = GVAR(nextWaveTimesHash);
private _waitTime = (_hash get playerSide) - cba_missiontime;
private _text = format [localize "STR_tunres_MSP_remaining_time", [_waitTime] call CBA_fnc_formatElapsedTime];
[QGVAR(doNotification), [_text]] call CBA_fnc_localEvent;