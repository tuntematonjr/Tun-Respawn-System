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
 * [] call tunres_Respawn_addGear
 */
#include "script_component.hpp"
if (isDedicated) exitWith { };
params [["_unit", player, [objNull]]];

switch (GVAR(gearscriptType)) do {
	case 0: {
		private _gearScriptPath = _unit getVariable [QGVAR(GearPath), "Not set"];
		if (_gearScriptPath isEqualTo "Not set") exitWith { hint "this unit is missing its gearscript path!"};

		private  _role = _unit getVariable [QGVAR(Role), "Not Set"];
		if (_role isEqualTo "Not set") exitWith { hint "Missing role variable !"};

		[_role, _unit] call compile preprocessFileLineNumbers _gearScriptPath;
	};
	case 1: { 
		[_unit] call potato_assignGear_fnc_assignGearMan;
	};
	case 2: { 
		_unit setUnitLoadout GVAR(savedGear);
	};
	default { };
};

if (isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
	[QGVAR(setTfarLRsettings_EH), [_unit]] call CBA_fnc_localEvent;
};

[QGVAR(EH_GearAdded), [_unit]] call CBA_fnc_localEvent;