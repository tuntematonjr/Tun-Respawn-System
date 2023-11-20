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
 * [player] call Tun_Respawn_fnc_updateWaitingRespawnList
 */
#include "script_component.hpp"
params [["_player", nil, [objNull]], ["_addPlayer", nil, [false]], ["_side", nil, [west]]];

private _skip = [_player, _side] call FUNC(delayed_respawn);

if !(_skip) then {
	private _unitList = switch (_side) do {
		case west: { GVAR(waitingRespawnWest) };
		case east: { GVAR(waitingRespawnEast) };
		case resistance: { GVAR(waitingRespawnGuer) };
		case civilian: { GVAR(waitingRespawnCiv) };
	};

	FILTER(_unitList,(!isnull _x && _x in allPlayers && alive _x ));
	
	if (_addPlayer) then {
		_unitList pushBackUnique _player;
	} else {
		_unitList deleteAt (_unitList find _player);
	};

	switch (_side) do {
		case west: { missionNamespace setVariable [QGVAR(waitingRespawnWest), _unitList, true]; };
		case east: { missionNamespace setVariable [QGVAR(waitingRespawnEast), _unitList, true]; };
		case resistance: { missionNamespace setVariable [QGVAR(waitingRespawnGuer), _unitList, true]; };
		case civilian: { missionNamespace setVariable [QGVAR(waitingRespawnCiv), _unitList, true]; };
	};
};