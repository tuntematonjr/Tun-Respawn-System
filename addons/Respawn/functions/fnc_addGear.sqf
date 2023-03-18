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

switch (GVAR(gearscriptType)) do {
	case "SQF Gearscript": {
		private _gearScriptPath = player getVariable [QGVAR(GearPath), "Not set"];
		if (_gearScriptPath == "Not set") exitWith { hint "this unit is missing its gearscript path!"};

		private  _role = player getVariable [QGVAR(Role), "Not Set"];
		if (_role == "Not set") exitWith { hint "Missing role variable !"};

		[_role, player] call compile preprocessFileLineNumbers _gearScriptPath;
	};
	case "Potato Tool": { 
		[player] call potato_assignGear_fnc_assignGearMan;
	};
	case "Save gear": { 
		player setUnitLoadout GVAR(savedgear);
	};

	default { };
};

if (isClass(configFile >> "CfgPatches" >> "tfar_core")) then {
	[QGVAR(setTfarLRsettings_EH), [player]] call CBA_fnc_localEvent;
};

[QGVAR(EH_GearAdded), [player]] call CBA_fnc_localEvent;