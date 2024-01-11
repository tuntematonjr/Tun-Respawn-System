/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: unit to add or remove <OBJECT>
 * 1: true to add, false to remove <BOOL>
 *
 * Return Value:
 * none
 *
 * Example:
 * [player] call tunres_Respawn_fnc_updateWaitingRespawnList
 */
#include "script_component.hpp"
params [["_player", nil, [objNull]], ["_addPlayer", nil, [false]], ["_side", nil, [west]]];

private _skip = [_player, _side] call FUNC(delayed_respawn);

if !(_skip) then {
	private _waitingRespawnHash = GVAR(waitingRespawnList);
	private _unitList = _waitingRespawnHash get _side;

	FILTER(_unitList,(!isnull _x && _x in allPlayers && alive _x ));
	
	if (_addPlayer) then {
		_unitList pushBackUnique _player;
	} else {
		_unitList deleteAt (_unitList find _player);
	};

	_waitingRespawnHash set [_side, _unitList];
	publicVariable QGVAR(waitingRespawnList);
};