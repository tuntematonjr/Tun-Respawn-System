/*
 * Author: [Tuntematon]
 * [Description]
 * Add action to TP object
 *
 * Arguments:
 * 0: Obj where to add TP action <OBJECT>
 * 1: Condition when it is enabled <STRING>
 * 2: Use ace or vanilla action (true is ace) <BOOL>
 * 3: Action point offset for ace <ARRAY>
 * 4: ACE action parrent path <STRING>
 *
 * Return Value:
 * The return true when done <BOOL>
 *
 * Example:
 * _flag, true, nil, ["Tun_baseAction"] call Tun_Respawn_fnc_addTeleportAction
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

true