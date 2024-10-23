/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * The return true when done <BOOL>
 *
 * Example:
 * [_unit, _destination, _text, _range] call tunres_Respawn_fnc_godMode
 */
#include "script_component.hpp"
params [["_unit", objNull, [objNull]], ["_godModeLenght", 30, [0]]];

if (_unit isEqualTo objNull && {!local _unit}) exitWith {LOG("unit was objnull when adding god mode")};

if (isDamageAllowed _unit) then {
	_unit allowDamage false;
	INFO("Enable god mode");
	[{
		params ["_unit"];
		_unit allowDamage true;
		INFO("Disable god mode");
	}, [_unit], _godModeLenght] call CBA_fnc_waitAndExecute;
};

true