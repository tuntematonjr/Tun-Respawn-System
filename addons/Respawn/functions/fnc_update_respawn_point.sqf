﻿/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Side <SIDE>
 * 1: False: Rertur to original pos. True: Update to module pos <BOOL> (default: false)
 * 2: New position <ARRAY> (default: [0,0,0])
 *
 * Return Value:
 * None
 *
 * Example:
 * [west, true] call Tun_respawn_fnc_update_respawn_point
 */
#include "script_component.hpp"

params [["_side", sideLogic, [west]], ["_update", false, [true]], ["_new_pos", [0,0,0], [[]]]];

if (!isServer) exitWith { };

_value = switch (_side) do {
	case west: {
		tun_respawn_respawnpos_west;
	};

	case east: {
		tun_respawn_respawnpos_east;
	};

	case resistance: {
		tun_respawn_respawnpos_guer;
	};

	case civilian: {
		tun_respawn_respawnpos_civ;
	};

	default {
		nil;
	};
};

_marker = _value select 0;
_module = _value select 1;
_originalpos = _value select 2;

_marker setMarkerAlpha 0;

if (_update) then {
	_module setPos _new_pos;
	_marker setMarkerPos (getPos _module);
} else {
	_module setPos _originalpos;
	_marker setMarkerPos _originalpos;
};

//Forsce players to update markers
[] remoteExecCall [QGVAR(marker_update), [0, -2] select isServer, false];