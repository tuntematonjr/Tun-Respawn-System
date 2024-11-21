/*
 * Author: [Tuntematon]
 * [Description]
 * 
 *
 * Arguments:
 * How many need to bee adden  <NUMBER>
 *
 * Return Value:
 * How many has respawned <NUMBER>
 *
 * Example:
 * [] call tunres_Respawn_fnc_upddateRespawnCount
 */
#include "script_component.hpp"
if (!isServer) exitWith { };
params [["_side", nil, [west]], ["_count", 0, [0]]];

private _totalRespawnCountHash = GVAR(totalRespawnCountHash);
private _totalRespawnCount = _totalRespawnCountHash get _side;
_totalRespawnCount = _totalRespawnCount + _count;
_totalRespawnCountHash set [_side, _totalRespawnCount];

_totalRespawnCount