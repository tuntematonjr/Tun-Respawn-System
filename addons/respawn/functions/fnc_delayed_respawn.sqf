/*
 * Author: [Tuntematon]
 * [Description]
 * If remaining respawn time is less than percent specified here, player skips the next wave. Ie. if wave interval is 20 (min) and this is set to 50 (%) and player dies after there is less than 10 minutes remaining until next respawn, player will skip the next wave and needs to wait for the following one. 0 = Disabled.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [] call tunres_Respawn_fnc_delayed_respawn
 */
#include "script_component.hpp"
params ["_unit", "_side"];

private _skip = false;
if (GVAR(delayed_respawn) > 0) then {
	private _hashWaitTime = GVAR(nextWaveTimes);
	private _hashWaveLenght = GVAR(waveLenghtTimes);
	private _time = _hashWaitTime get _side;
	private _waveLenghtTime = _hashWaveLenght get _side;
	_skip = ((_time - cba_missiontime) < ((_waveLenghtTime * 60) * (GVAR(delayed_respawn) / 100)));
};

_unit setVariable [QGVAR(skip_next_wave), _skip, true];

if (_skip) then {
	private _waitingRespawnDelayedHash = GVAR(waitingRespawnDelayedList);
	private _waitingRespawnDelayed = _waitingRespawnDelayedHash get _side;
	PUSH(_waitingRespawnDelayed,_unit);
	FILTER(_waitingRespawnDelayed,(!isnull _x && _x in allPlayers && alive _x ));
	_waitingRespawnDelayed set [_side, _waitingRespawnDelayed];
	publicVariable QGVAR(waitingRespawnDelayedList);
};

_skip