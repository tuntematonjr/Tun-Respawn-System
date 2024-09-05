#include "script_component.hpp"
if (!hasInterface) exitWith { };

[{!isNull player  &&
ADDON
}, {
	if (GVAR(enable)) then {
		[] call FUNC(briefingNotes);
		[] call FUNC(addAceActions);
	};
}] call CBA_fnc_waitUntilAndExecute;

[QGVAR(doNotification), {
	params ["_text", ["_duration", 7]];
	[_text, false, _duration] call ace_common_fnc_displayText;
}] call CBA_fnc_addEventHandler;