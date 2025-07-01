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
params [["_side", nil, [west]], ["_resetTimer", false, [true]]];

if (!isServer) exitWith { };

if (GVAR(forcedRespawn)) exitWith { INFO("No timer, Only forced waves"); };

private _hashWaitTime = GVAR(nextWaveTimesHash);
private _waveLenght = GVAR(waveLenghtTimesHash) get _side;
private _time = [(_hashWaitTime get _side), cba_missiontime] select _resetTimer;
_time = round (_time + _waveLenght);

_hashWaitTime set [_side, _time];
publicVariable QGVAR(nextWaveTimesHash);

if !( GVAR(timerRunningHash) getOrDefault [_side, false]) then {
	GVAR(timerRunningHash) set [_side, true];
	publicVariable QGVAR(timerRunningHash);
	[{ _this params ["_side"];
		GVAR(allowRespawnHash) get _side && 
		{ 0 >= [_side] call FUNC(getRemainingTime) } 
	}, {
		_this params ["_side"];
		if (EGVAR(msp,enable)) then {
			[_side] call EFUNC(msp,contestedCheck);
		};

		GVAR(timerRunningHash) set [_side, false];
		publicVariable QGVAR(timerRunningHash);
		[_side] call FUNC(doRespawnWave);
		[_side] call FUNC(timer);
	}, [_side]] call CBA_fnc_waitUntilAndExecute;
};
