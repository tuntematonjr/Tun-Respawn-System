#include "script_component.hpp"

if (hasInterface) then {
	[{!isNull player && GVAR(cbaSettingsDone)}, {
		if (EGVAR(respawn,briefingEnable)) then {
			[] call FUNC(briefingNotes);
		};
	}] call CBA_fnc_waitUntilAndExecute;
};