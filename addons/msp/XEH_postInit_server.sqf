#include "script_component.hpp"

[QGVAR(startContestedChecksEH), {
	params ["_side", "_start"];
	[_side, _start] call FUNC(startContestedChecks);
}] call CBA_fnc_addEventHandler;