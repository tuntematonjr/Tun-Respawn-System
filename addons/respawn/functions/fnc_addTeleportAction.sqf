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
 * _flag, true, nil, ["tunres_baseAction"] call tunres_Respawn_fnc_addTeleportAction
 */
#include "script_component.hpp"
params ["_obj", "_menuOpenConditio", "_useAceAction", "_actionPath"];

private ["_statement"];
if (_useAceAction) then {
	_statement = {
		params ["_obj", "_menuOpenConditio", "_actionPath"];
		_menuOpenConditio = compile _menuOpenConditio;
		private _action = ["TpMenu", LLSTRING(TeleportMenu),"\a3\3den\data\cfg3den\history\changeattributes_ca.paa",{ [_target] call FUNC(openTeleportMenu) }, _menuOpenConditio] call ace_interact_menu_fnc_createAction;
		[_obj, 0, _actionPath, _action] call ace_interact_menu_fnc_addActionToObject;
	};
} else {
	_statement = {
		params ["_obj", "_menuOpenConditio"];
		_obj addAction [LLSTRING(TeleportMenuVanilla), { [_this select 0] call FUNC(openTeleportMenu) }, [], 10, true, true, "", _menuOpenConditio, 10]
	};	
};

//MITÄ VITTUA TÄÄ TEKEEEEEEEE!
[
	{
		params ["_obj", "_menuOpenConditio", "_actionPath"];
		!isNull _obj;
	},
	_statement,
	[_obj, _menuOpenConditio, _actionPath]
] call CBA_fnc_waitUntilAndExecute;

true
