/*
 * Author: [Tuntematon]
 * [Description]
 * Add action to check how many tickets left.
 *
 * Arguments:
 * 0: Action target object <OBJECT>
 * 1: Use ace action <BOOL> (default: true) "Optional"
 *
 * Example:
 * [object, true] call tunres_Respawn_fnc_addCheckTicketCountAction
 */
#include "script_component.hpp"
if (isDedicated) exitWith { };

params [ ["_object", objNull, [objNull]], 
["_useAceAction", true, [true]], 
["_offset", nil, [[]]], 
["_parrenPath", ["ACE_MainActions"], [[]]]];

if (GVAR(respawnType) isEqualTo 0) exitWith {
	LOG("Skip adding ticket check ace action, as we dont use tickets");
};

if (_useAceAction) then {
	private _action = ["CheckTickets", LLSTRING(CheckTickets),"\a3\modules_f_curator\data\portraitmissionname_ca.paa",{ [] call FUNC(checkTicketCount); }, {true}, nil, nil, _offset] call ace_interact_menu_fnc_createAction;
	[_object, 0, _parrenPath, _action] call ace_interact_menu_fnc_addActionToObject;

} else {
	_object addAction [LLSTRING(CheckTickets), { [] call FUNC(checkTicketCount) }, [], 10, true, true, "", "true", 10];
};