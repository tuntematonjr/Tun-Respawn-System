#include "script_component.hpp"

[{!isNull player  &&
ADDON
}, {
	[] call FUNC(briefingNotes);
	[] call FUNC(ace_actions);
}] call CBA_fnc_waitUntilAndExecute;