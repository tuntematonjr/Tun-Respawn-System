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
 * ["something", player] call TUN_Respawn_fnc_imanexample
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
params ["_side"];



switch (toLower str _side) do {
	case "west": {

	};

	case "east": {

	};

	case "guer": {

	};

	case "civ": {

	};

	default {
		hint "ticket counters FNC missing side param!";
	};
};
