/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument <OBJECT>
 * 2: Multiple input types <STRING|ARRAY|CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE|STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: nil)
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["something", player] call TUN_Respawn_fnc_init
 *
 * Public: [Yes]
 */
#include "script_component.hpp"

// Spawn Flags at the Respawn wait areas
if (!isServer) exitWith { };


if !(getMarkerColor "respawn_west" == "") Then {
	TUN_respawn_flag_west = "Flag_Blue_F" createVehicle getMarkerPos "respawn_west";
	["west"] call FUNC(timer);
};

if !(getMarkerColor "respawn_east" == "") Then {
	TUN_respawn_flag_east = "Flag_Red_F" createVehicle getMarkerPos "respawn_east";
	["east"] call FUNC(timer);
};

if !(getMarkerColor "respawn_guerrila" == "") Then {
	TUN_respawn_flag_guerrila = "Flag_Green_F" createVehicle getMarkerPos "respawn_guerrila";
	["guer"] call FUNC(timer);
};

if !(getMarkerColor "respawn_civilian" == "") Then {
	TUN_respawn_flag_civilian = "Flag_White_F" createVehicle getMarkerPos "respawn_civilian";
	["civ"] call FUNC(timer);
};