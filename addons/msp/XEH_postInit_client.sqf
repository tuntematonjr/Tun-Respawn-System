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