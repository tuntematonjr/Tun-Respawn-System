/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Side <SIDE>
 * 1: False: Return to original pos. True: Update to new given pos <BOOL> (default: false)
 * 2: New position <ARRAY> (default: [0,0,0])
 *
 * Return Value:
 * None
 *
 * Example:
 * [west, true] call tunres_respawn_fnc_updateRespawnPoint
 */
#include "script_component.hpp"

params [["_side", nil, [west]], ["_update", false, [true]], ["_newPos", [0,0,0], [[]]]];

if (!isServer) exitWith { };

private _value = GVAR(respawnPointsHash) get _side;

private _marker = _value select 0;
private _originalPos = _value select 1;

if (_newPos isEqualTo [0,0,0] || !_update) then {
	_newPos = _originalPos;
};

_marker setMarkerPos _newPos;

//Force players to update markers
[] remoteExecCall [QFUNC(updateRespawnMarkers), _side, false];