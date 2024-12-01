/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: unit to add or remove <OBJECT>
 * 1: true to add, false to remove <BOOL>
 * 2: Unit side <SIDE>
 *
 * Return Value:
 * none
 *
 * Example:
 * [player] call tunres_Respawn_fnc_updateWaitingRespawnList 
 */
#include "script_component.hpp"
params [["_player", nil, [objNull]], ["_addPlayer", nil, [false]], ["_side", nil, [west]], ["_skipWaitingCountUpdate", false, [false]]];

if (isNull _player || !(_player in allPlayers) || !alive _player ) exitWith {
	LOG("Tried to add unit what is not there");
};

{
	private _hash = _x;
	private _unitList = _hash get _side;
	FILTER(_unitList,(!isNull _x && _x in allPlayers && alive _x ));
	_hash set [_side, _unitList];
} forEach [GVAR(waitingRespawnListHash), GVAR(waitingRespawnDelayedListHash)];

private _skipNextWave = _player getVariable [QGVAR(skipNextWave), nil];

if (isNil "_skipNextWave") then {
	LOG("Check if unit needs to be at delayed respawn");
	_skipNextWave = [_player, _side] call FUNC(delayedRespawn);
};

private _unitListHash = [GVAR(waitingRespawnListHash), GVAR(waitingRespawnDelayedListHash)] select (_skipNextWave);
private _unitList = _unitListHash get _side;

TRACE_3("lol",_addPlayer,_unitList,_player);

if (_addPlayer) then {
	_unitList pushBackUnique _player;
} else {
	_unitList deleteAt (_unitList find _player);
};
	
_unitListHash set [_side, _unitList];

if !(_skipWaitingCountUpdate) then {
	[QGVAR(updateWaitRespawnCountEH), [_side,_skipNextWave]] call CBA_fnc_serverEvent;
};