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

params["_pos"];

private _values = GVAR(contestValuesHash) get playerSide;
private _reportEnemiesRange = _values param [1];
private _contestedRadiusMax = _values param [2];
private _contestedRadiusMin = _values param [3];

private _posMax = _pos getPos [_contestedRadiusMax, 100];
private _posMin = _pos getPos [_contestedRadiusMin, 90];
private _posReport = _pos getPos [_reportEnemiesRange, 80];


// * 0: Marker name <STRING>
// * 1: Position <ARRAY>
// * 2: Marker text <STRING>
// * 3: Icon/brush <STRING> https://community.bistudio.com/wiki/setMarkerBrushLocal  https://community.bistudio.com/wiki/setMarkerTypeLocal
// * 4: Color <STRING>
// * 5: Alpha <Number> 
// * 6: Priority <Number> 
// * 7: Shape <STRING> (Default: "ICON") "ICON", "RECTANGLE", "ELLIPSE", "POLYLINE" 
// * 8: Size [a-axis, b-axis] <ARRAY> 
// * 9: Direction <Number> 


[QGVAR(contestMarkerMapMax), _pos, nil, "Solid", "ColorOrange", 0.75, -2, "ELLIPSE", [_contestedRadiusMax, _contestedRadiusMax]] call EFUNC(respawn,createLocalMarker);

[QGVAR(contestMarkerMapMaxText), _posMax, format["Max Contest range (%1m)",_contestedRadiusMax], "hd_warning", "ColorOrange", 1, 110] call EFUNC(respawn,createLocalMarker);

[QGVAR(contestMarkerMapReport), _pos, nil, "Solid", "ColorYellow", 0.75, -3, "ELLIPSE",  [_reportEnemiesRange, _reportEnemiesRange]] call EFUNC(respawn,createLocalMarker);

[QGVAR(contestMarkerMapReportText), _posReport, format["Report enemies range (%1m)",_reportEnemiesRange], "hd_warning", "ColorYellow", 1, 110] call EFUNC(respawn,createLocalMarker);

[QGVAR(contestMarkerMapMin), _pos, nil, "Solid", "colorOPFOR", 0.75, -1, "ELLIPSE",  [_contestedRadiusMin, _contestedRadiusMin]] call EFUNC(respawn,createLocalMarker);

[QGVAR(contestMarkerMapMinText), _posMin, format["Min Contest range (%1m)",_contestedRadiusMin], "hd_warning", "ColorRed", 1, 110] call EFUNC(respawn,createLocalMarker);

[QGVAR(contestMarkerMapMSPText), _pos, "MSP", "loc_Truck", "ColorBlack", 1, 110, nil, [2,2]] call EFUNC(respawn,createLocalMarker);