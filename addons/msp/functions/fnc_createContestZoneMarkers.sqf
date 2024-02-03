/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Give object to get position <OBJECT> (default: {player})
 *
 * Return Value:
 * None
 *
 * Example:
 * [_target] call tunres_MSP_fnc_createContestZoneMarkers

 */
#include "script_component.hpp"

if (playerSide isEqualTo sideLogic || !hasInterface) exitWith { }; 

params[["_target", player]];

private _values = GVAR(contestValues) get playerSide;
private _reportEnemiesRange = _values param [1];
private _contestedRadiusMax = _values param [2];
private _contestedRadiusMin = _values param [3];

openMap true;
private _pos = getPos _target;
private _posMax = _pos getPos [_contestedRadiusMax, 100];
private _posMin = _pos getPos [_contestedRadiusMin, 90];
private _posReport= _pos getPos [_reportEnemiesRange, 80];
[QGVAR(contestMarkerMapMax), _pos, "ELLIPSE", [_contestedRadiusMax, _contestedRadiusMax], "COLOR:", "ColorOrange"] call CBA_fnc_createMarker;
[QGVAR(contestMarkerMapMaxText), _posMax, "ICON", [1,1], "TEXT:", format["Max Contest range (%1m)",_contestedRadiusMax], "COLOR:", "ColorOrange", "TYPE:", "hd_warning"] call CBA_fnc_createMarker;

[QGVAR(contestMarkerMapReport), _pos, "ELLIPSE", [_reportEnemiesRange, _reportEnemiesRange], "COLOR:", "colorOPFOR"] call CBA_fnc_createMarker;
[QGVAR(contestMarkerMapReportText), _posReport, "ICON", [1,1],"TEXT:", format["Report enemies range (%1m)",_reportEnemiesRange], "COLOR:", "ColorYellow", "TYPE:", "hd_warning"] call CBA_fnc_createMarker;

[QGVAR(contestMarkerMapMin), _pos, "ELLIPSE", [_contestedRadiusMin, _contestedRadiusMin], "COLOR:", "colorOPFOR"] call CBA_fnc_createMarker;
[QGVAR(contestMarkerMapMinText), _posMin, "ICON", [1,1],"TEXT:", format["Min Contest range (%1m)",_contestedRadiusMin], "COLOR:", "ColorRed", "TYPE:", "hd_warning"] call CBA_fnc_createMarker;

[QGVAR(contestMarkerMapMSPText), _pos, "ICON", [1,1],"TEXT:", "MSP", "TYPE:", "loc_Truck"] call CBA_fnc_createMarker;


GVAR(contestMarkerMapEH) = addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
	if !(_mapIsOpened) then {
    	removeMissionEventHandler ["Map", GVAR(contestMarkerMapEH)];
		deleteMarkerLocal QGVAR(contestMarkerMapMax);
		deleteMarkerLocal QGVAR(contestMarkerMapMin);
		deleteMarkerLocal QGVAR(contestMarkerMapMinText);
		deleteMarkerLocal QGVAR(contestMarkerMapMaxText);
		deleteMarkerLocal QGVAR(contestMarkerMapReport);
		deleteMarkerLocal QGVAR(contestMarkerMapReportText);
		deleteMarkerLocal QGVAR(contestMarkerMapMSPText);
	};
}]