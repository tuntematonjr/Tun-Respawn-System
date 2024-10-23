#include "script_component.hpp"

[{ ADDON }, {
	
	if !(GVAR(enable)) exitWith { INFO("TUN Mobile Respawn Point Disabled"); };
	INFO("TUN Mobile Respawn Point Enabled");

	[] call FUNC(addEventHandlers);
}] call CBA_fnc_waitUntilAndExecute;