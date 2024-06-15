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
params [["_side", nil, [west]], ["_unit", objnull, [objnull]]];
private _respawnPointsHash = GVAR(respawnPointsHash);
private _respawnPosition = getMarkerPos ((_respawnPointsHash get _side) select 0);

[_unit, false, _side] call FUNC(updateWaitingRespawnList);

_unit setVariable [QGVAR(isWaitingRespawn), false, true];

private _text = localize "STR_tunres_Respawn_FNC_moveRespawnText";

[_unit, _respawnPosition, _text, 20, true] call FUNC(teleportUnit);

[_unit] remoteExecCall [QFUNC(addGear), _unit];

[QGVAR(EH_unitRespawned), [_unit], _unit] call CBA_fnc_localEvent;