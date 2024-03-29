﻿/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Side <SIDE>
 * 1: False: Rertur to original pos. True: Update to new given pos <BOOL> (default: false)
 * 2: New position <ARRAY> (default: [0,0,0])
 *
 * Return Value:
 * None
 *
 * Example:
 * [west, true] call Tun_respawn_fnc_update_respawn_point
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

//Forsce players to update markers
[] remoteExecCall [QFUNC(marker_update), -2, false];