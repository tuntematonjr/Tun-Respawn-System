#include "script_component.hpp"
if (!hasInterface) exitWith { };

[QGVAR(doNotification), {
	params ["_text", ["_duration", 7]];
	[_text, false, _duration] call ace_common_fnc_displayText;
}] call CBA_fnc_addEventHandler;