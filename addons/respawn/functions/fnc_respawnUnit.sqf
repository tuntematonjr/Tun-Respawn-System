/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Side <SIDE>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * 
 *
 * Example:
 * [_side, _unit] call tunres_Respawn_fnc_respawnUnit
 */
#include "script_component.hpp"
params [["_side", nil, [west]], ["_unit", objNull, [objNull]], ["_skipWaitingCountUpdate", false, [false]]];
private _respawnPointsHash = GVAR(respawnPointsHash);
private _respawnPosition = getMarkerPos ((_respawnPointsHash get _side) select 0);

[QGVAR(updateWaitingRespawnListEH), [_unit, false, _side, _skipWaitingCountUpdate]] call CBA_fnc_serverEvent;

_unit setVariable [QGVAR(isWaitingRespawn), false, true];
_unit setVariable [QGVAR(skipNextWave), nil, true];

private _text = LLSTRING(FNC_moveRespawnText);

[_unit, _respawnPosition, _text, 30, true] call FUNC(teleportUnit);

[_unit] remoteExecCall [QFUNC(addGear), _unit];

[QGVAR(EH_unitRespawned), [_unit], _unit] call CBA_fnc_localEvent;
