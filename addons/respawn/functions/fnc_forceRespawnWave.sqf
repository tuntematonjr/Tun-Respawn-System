/*
 * Author: [Tuntematon]
 * [Description]
 * Force respawn wave
 *
 * Arguments:
 * 0: Side (west, east, resistance, civilian) <SIDE>
 * 1: Reset Timer  <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [west, false] call tunres_Respawn_fnc_forceRespawnWave
 */
#include "script_component.hpp"

if (!isServer) exitWith { };

params [["_side", nil, [east]], ["_reset", false, [false]]];

private _text = format["__%1__ has been force respawned.",str _side];
private _markerPos = getMarkerPos ((GVAR(respawnPointsHash) get _side) select 0);

AAR_EVENT(_text,nil,nil,_markerPos);

[_side, true] call FUNC(doRespawnWave);

if (_reset && { !(GVAR(forcedRespawn)) }) then {
	[_side,true] call FUNC(timer);
};
