/*
 * Author: [Nurmi & Tuntematon]
 * [Description]
 *
 * Arguments:
 * 1: Object <OBJECT>
 *
 * Return Value:
 * Parent Action Path in array, if no parent action exists empty array is returned
 *
 * Example:
 * [Object] call tunres_Respawn_fnc_getParentAction

 */
#include "script_component.hpp"

params [["_object", objNull,[objNull]]];

private _parentAction = [];
//check if there is base actions made in config, if not checks if there is made with script
if (isClass(configFile >> "CfgVehicles" >> typeOf _object >> "ACE_Actions")) then { 
	_parentAction = [configName (("true" configClasses (configFile >> "CfgVehicles" >> typeOf _object >> "ACE_Actions")) select 0)];
} else {
	private _allActions = _object getVariable ["ace_interact_menu_actions", []];
	{
		private _action = _x;
		private _actionArray = _action select 1;
		if (count _actionArray isEqualTo 0) then {
			_parentAction append [_action select 0 select 0];
			break;
		};

		if (count _actionArray isEqualTo 1) then {
			_parentAction = _actionArray;
			break;
		};
	} forEach _allActions;
};

_parentAction
