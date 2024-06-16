/*
 * Author: [Tuntematon]
 * [Description]
 * Timer
 *
 * Arguments:
 * 0: side <SIDE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [west] call tunres_Respawn_fnc_timer
 */
#include "script_component.hpp"
params [["_side", nil, [west]]];

if (!isServer) exitWith { };

if (GVAR(forcedRespawn)) exitWith { INFO("No timer, Only forced waves"); };

private _hashWaitTime = GVAR(nextWaveTimesHash);
private _hashWaveLenght = GVAR(waveLenghtTimesHash);
private _time = round ((_hashWaitTime get _side) + (_hashWaveLenght get _side) * 60);

_hashWaitTime set [_side, _time];
publicVariable QGVAR(nextWaveTimesHash);

if !( GVAR(timerRunningHash) getOrDefault [_side, false]) then {
	GVAR(timerRunningHash) set [_side, true];
	publicVariable QGVAR(timerRunningHash);
	[{ _this params["_side"];
		GVAR(allowRespawnHash) get _side && 
		{ cba_missiontime >= GVAR(nextWaveTimesHash) get _side } 
	}, {
		_this params["_side"];
		if (EGVAR(msp,enable)) then {
			[_side] call EFUNC(msp,contestedCheck);
		};

		GVAR(timerRunningHash) set [_side, false];
		publicVariable QGVAR(timerRunningHash);
		[_side] call FUNC(doRespawnWave);
		[_side] call FUNC(timer);
	}, [_side]] call CBA_fnc_waitUntilAndExecute;
};