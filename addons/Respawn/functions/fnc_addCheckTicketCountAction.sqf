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
 * [object, true] call Tun_Respawn_fnc_addCheckTicketCountAction
 */
#include "script_component.hpp"
if (isDedicated) exitWith { };

params [ ["_object", objNull, [objNull]], ["_useAceAction", true, [true]], ["_offset", nil, [[]]], ["_parrenPath", ["ACE_MainActions"], [[]]]];

if (_useAceAction) then {
	private _action = ["CheckTickets", "STR_Tun_Respawn_CheckTickets" call BIS_fnc_localize,"",{ [playerSide] call FUNC(checkTicketCount) }, {true}, nil, nil, _offset] call ace_interact_menu_fnc_createAction;
	[_object, 0, _parrenPath, _action] call ace_interact_menu_fnc_addActionToObject;

} else {
	_object addAction ["STR_Tun_Respawn_CheckTickets" call BIS_fnc_localize, { [playerSide] call FUNC(checkTicketCount) }, [], 10, true, true, "", "true", 10];
};