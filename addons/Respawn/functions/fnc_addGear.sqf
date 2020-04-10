/*
 * Author: [Tuntematon]
 * [Description]
 * Give player its original gear.
 *
 * Arguments:
 * none
 *
 * Return Value:
 * none
 *
 * Example:
 * [] call TUN_Respawn_addGear
 */
#include "script_component.hpp"
if (isDedicated) exitWith { };



if (GVAR(use_gearscript)) then {
	_gearScriptPath = player getVariable [QGVAR(GearPath), "Not set"];
	if (_gearScriptPath == "Not set") exitWith { hint "this unit is missing its gearscript path!"};

	_role = player getVariable [QGVAR(Role), "Not Set"];
	if (_role == "Not set") exitWith { hint "Missing role variable !"};

	[_role, player] call compile preprocessFileLineNumbers _gearScriptPath;
};