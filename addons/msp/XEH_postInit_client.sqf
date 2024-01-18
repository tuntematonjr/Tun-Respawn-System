#include "script_component.hpp"

[{!isNull player  &&
ADDON
}, {
	[] call FUNC(briefingNotes);
	[] call FUNC(addAceActions);
}] call CBA_fnc_waitUntilAndExecute;