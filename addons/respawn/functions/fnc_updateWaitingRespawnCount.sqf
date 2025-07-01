/*
 * Author: [Tuntematon]
 * [Description]
 * 
 *
 * Arguments:
 * 
 *
 * Return Value:
 * 
 *
 * Example:
 * [] call tunres_Respawn_fnc_updateWaitingRespawnCount
 */
#include "script_component.hpp"
if (!isServer) exitWith { };
params [["_side", nil, [west]], ["_updateDelayed", false, [false]]];

private _unitListHash = [GVAR(waitingRespawnListHash), GVAR(waitingRespawnDelayedListHash)] select (_updateDelayed);
private _unitList = _unitListHash get _side;
private _count = count _unitList;
private _unitCountHash = GVAR(waitingRespawnCountHash);
private _unitCountArray = _unitCountHash get _side;
_unitCountArray set [(parseNumber _updateDelayed), _count];
_unitCountHash set [_side,_unitCountArray];

publicVariable QGVAR(waitingRespawnCountHash);
