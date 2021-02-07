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
 * ["something", player] call Tun_Respawn_fnc_module_teleporter
 */
#include "script_component.hpp"

private _logic = param [0,objNull,[objNull]];

if (isServer) then { 
	private _obj = _logic getVariable [QGVAR(teleportPointOBJ), "FlagPole_F"];
	_obj = _obj createVehicle getpos _logic;
	_logic setVariable [QGVAR(teleportObject), _obj, true];
};

if (hasInterface) then {

	GVAR(teleportPoints) pushBackUnique _logic;

	private _statement = {
		params ["_logic"];
		private _tpObject = _logic getVariable [QGVAR(teleportObject), objNull];
		private _action = ["TpMenu","Teleport Menu","",{ [_target] call FUNC(openTeleportMenu)},{true}] call ace_interact_menu_fnc_createAction;
		[_tpObject, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
	};

	[
		{
			params ["_logic"];
			_logic getVariable [QGVAR(teleportObject), objNull] != objNull
		},
		_statement,
		[_logic],
		60
	] call CBA_fnc_waitUntilAndExecute;
};