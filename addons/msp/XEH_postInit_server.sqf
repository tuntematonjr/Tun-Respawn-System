#include "script_component.hpp"


[{ ADDON }, {
	[] call FUNC(startContestedChecks);
}] call CBA_fnc_waitUntilAndExecute;