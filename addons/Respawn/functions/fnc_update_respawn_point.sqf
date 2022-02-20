/*
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

params [["_side", nil, [west]], ["_update", false, [true]], ["_new_pos", [0,0,0], [[]]]];

if (!isServer) exitWith { };

_value = switch (_side) do {
	case west: {
		GVAR(respawnpos_west);
	};

	case east: {
		GVAR(respawnpos_east);
	};

	case resistance: {
		GVAR(respawnpos_guer);
	};

	case civilian: {
		GVAR(respawnpos_civ);
	};

	default {
		nil;
	};
};

_marker = _value select 0;
_originalpos = _value select 2;

if (_new_pos isequalto [0,0,0]) then {
	_new_pos = _originalpos;
};

_marker setMarkerAlpha 0;

if (_update) then {
	_marker setMarkerPos _new_pos;
} else {
	_marker setMarkerPos _originalpos;
};

//Forsce players to update markers
[_update] remoteExecCall [QGVAR(marker_update), [0, -2] select isServer, false];