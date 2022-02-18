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
 * ["something", player] call Tun_Respawn_fnc_addTeleportAction
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
params ["_obj", "_menuOpenConditio", "_useAceAction", "_offset", "_parrenPath"];

private ["_statement"];
if (_useAceAction) then {
	_statement = {
		params ["_obj", "_menuOpenConditio", "_offset", "_parrenPath"];
		_menuOpenConditio = compile _menuOpenConditio;
		private _action = ["TpMenu", "STR_Tun_Respawn_TeleportMenu" call BIS_fnc_localize,"",{ [_target] call FUNC(openTeleportMenu) }, _menuOpenConditio, nil, nil, _offset] call ace_interact_menu_fnc_createAction;
		[_obj, 0, _parrenPath, _action] call ace_interact_menu_fnc_addActionToObject;
	};
} else {
	_statement = {
		params ["_obj", "_menuOpenConditio"];
		_obj addAction ["STR_Tun_Respawn_TeleportMenuVanilla" call BIS_fnc_localize, { [_this select 0] call FUNC(openTeleportMenu) }, [], 10, true, true, "", _menuOpenConditio, 10]
	};	
};

[
	{
		true
	},
	_statement,
	[_obj, _menuOpenConditio, _offset, _parrenPath]
] call CBA_fnc_waitUntilAndExecute;