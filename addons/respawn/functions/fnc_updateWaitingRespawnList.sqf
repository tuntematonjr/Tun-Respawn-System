/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: unit to add or remove <OBJECT>
 * 1: true to add, false to remove <BOOL>
 * 2: Unit side <SIDE>
 * 3: true/false to publicVariable unit list <BOOL>
 *
 * Return Value:
 * none
 *
 * Example:
 * [player] call tunres_Respawn_fnc_updateWaitingRespawnList 
 */
#include "script_component.hpp"
params [["_player", nil, [objNull]], ["_addPlayer", nil, [false]], ["_side", nil, [west]], ["_doPublicVar", true, [true]]];

if (isnull _player || !(_player in allPlayers) || !alive _player ) exitWith {
	LOG("Tried to add unit what is not there");
};

private _unitSkipsNextWave = _player getVariable [QGVAR(skipNextWave), [_player, _side] call FUNC(delayedRespawn)];
private _unitListHash = [GVAR(waitingRespawnList), GVAR(waitingRespawnDelayedList)] select _unitSkipsNextWave;
private _unitList = _unitListHash get _side;

if (_addPlayer) then {
	_unitList pushBackUnique _player;
} else {
	_unitList deleteAt (_unitList find _player);
};
	
_unitListHash set [_side, _unitList];

// //this is for not broadcasting on every player on respawn wave.
// if (_doPublicVar) then {
// 	publicVariable [QGVAR(waitingRespawnDelayedList), QGVAR(waitingRespawnList)] select _unitSkipsNextWave;
// };