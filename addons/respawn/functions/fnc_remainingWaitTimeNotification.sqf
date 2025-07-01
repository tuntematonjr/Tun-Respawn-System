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
private _text = format [LLSTRING(remainingTimeNotification), [_waitTime] call CBA_fnc_formatElapsedTime];
[QEGVAR(main,doNotification), [_text]] call CBA_fnc_localEvent;
