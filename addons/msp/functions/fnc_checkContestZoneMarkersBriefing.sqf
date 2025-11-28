/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument <OBJECT>
 * 2: Multiple input types <STRING|ARRAY|CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE|STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: nil)
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["something", player] call tunres_MSP_fnc_checkContestZoneMarkersBriefing
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
params [["_enable", true]];

if (playerSide isEqualTo sideLogic || !hasInterface) exitWith { }; 

if (_enable) then {
	if (cba_missiontime > 1) exitWith {
		[QEGVAR(main,doNotification), [LLSTRING(checkContestCantUse)]] call CBA_fnc_localEvent;
	};

	if (!isNil QGVAR(checkContestZoneMarkersBriefingEH)) exitWith {
		
	};
	LOG("Enable briefing contest area check during briefing");
	GVAR(checkContestZoneMarkersBriefingEH) = addMissionEventHandler ["MapSingleClick", {
		params ["_units", "_pos", "_alt", "_shift"];

		LOG("Update briefing contest area check markers pos");
		[] call FUNC(deleteContestZoneMarkers);
		[_pos] call FUNC(createContestZoneMarkers);	
	}];

	[{ cba_missiontime > 1 || isNil QGVAR(checkContestZoneMarkersBriefingEH) }, {
		if (!isNil QGVAR(checkContestZoneMarkersBriefingEH)) then {
			LOG("Cleare briefing contest area check markers");
			[false] call FUNC(checkContestZoneMarkersBriefing);
		};
	}] call CBA_fnc_waitUntilAndExecute;
} else {
	if (!isNil QGVAR(checkContestZoneMarkersBriefingEH)) then {
		onMapSingleClick "";
		LOG("Disable contest markers");
		[] call FUNC(deleteContestZoneMarkers);
		removeMissionEventHandler ["MapSingleClick", GVAR(checkContestZoneMarkersBriefingEH)];
		GVAR(checkContestZoneMarkersBriefingEH) = nil;
	};
};
