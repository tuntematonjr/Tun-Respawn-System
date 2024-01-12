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
 * ["something", player] call tunres_MSP_fnc_contestZoneMarkers

 */
#include "script_component.hpp"
params[["_target", player]];

openMap true;
private _pos = getPos _target;
private _contestRangeMax = GVAR(contested_radius_max);
private _contestRangeMin = GVAR(contested_radius_min);
private _posMax = _pos getPos [_contestRangeMax, 90];
private _posMin = _pos getPos [_contestRangeMin, 90];
[QGVAR(contestMarkerMapMax), _pos, "ELLIPSE", [_contestRangeMax, _contestRangeMax], "COLOR:", "ColorOrange"] call CBA_fnc_createMarker;
[QGVAR(contestMarkerMapMaxText), _posMax, "ICON", [1,1], "TEXT:", "Max Contest range", "COLOR:", "ColorOrange", "TYPE:", "hd_warning"] call CBA_fnc_createMarker;
[QGVAR(contestMarkerMapMin), _pos, "ELLIPSE", [_contestRangeMin, _contestRangeMin], "COLOR:", "colorOPFOR"] call CBA_fnc_createMarker;
[QGVAR(contestMarkerMapMinText), _posMin, "ICON", [1,1],"TEXT:", "Min Contest range", "COLOR:", "ColorRed", "TYPE:", "hd_warning"] call CBA_fnc_createMarker;

GVAR(contestMarkerMapEH) = addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
	if !(_mapIsOpened) then {
    	removeMissionEventHandler ["Map", GVAR(contestMarkerMapEH)];
		deleteMarkerLocal QGVAR(contestMarkerMapMax);
		deleteMarkerLocal QGVAR(contestMarkerMapMin);
		deleteMarkerLocal QGVAR(contestMarkerMapMinText);
		deleteMarkerLocal QGVAR(contestMarkerMapMaxText);
	};
}]