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
 * [] call tunres_Respawn_fnc_delayedRespawn
 */
#include "script_component.hpp"
params ["_unit", "_side"];

private _skip = false;
if (GVAR(delayedRespawn) > 0) then {
	private _hashWaveLenght = GVAR(waveLenghtTimesHash);
	private _time = [_side] call FUNC(getRemainingTime);
	private _waveLenghtTime = _hashWaveLenght get _side;
	_skip = (_time < (_waveLenghtTime * (GVAR(delayedRespawn) / 100)));
};

_unit setVariable [QGVAR(skipNextWave), _skip, true];

_skip