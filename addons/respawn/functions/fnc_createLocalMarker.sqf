/*
 * Author: [Tuntematon]
 * [Description]
 * Create local marker.
 *
 * Arguments:
 * 0: Marker name <STRING>
 * 1: Position <ARRAY>
 * 2: Marker text <STRING>
 * 3: Icon/brush <STRING> https://community.bistudio.com/wiki/setMarkerBrushLocal  https://community.bistudio.com/wiki/setMarkerTypeLocal
 * 4: Color <STRING>
 * 5: Alpha <Number> 
 * 6: Priority <Number> 
 * 7: Shape <STRING> (Default: "ICON") "ICON", "RECTANGLE", "ELLIPSE", "POLYLINE" 
 * 8: Size [a-axis, b-axis] <ARRAY> 
 * 9: Direction <Number> 
 *
 * Return Value:
 *
 * Example:
 * [QGVAR(RespawnPosLocal), _pos, "Respawn", "respawn_inf", _color, 1] call tunres_Respawn_fnc_createLocalMarker
 */
#include "script_component.hpp"
params [["_name", nil, [""]], 
		["_pos", nil, [[]]], 
		["_text", nil, [""]], 
		["_icon", nil, [""]],
		["_color", "Default", [""]], 
		["_alpha", 0, [0]], 
		["_priority", 0, [0]], 
		["_shape", "ICON", [""]],
		["_size", [1,1], [[]], 2],
		["_dir", 0, [0]]];
		
if (!hasInterface) exitWith {};

private _marker = createMarkerLocal [_name, _pos];
_marker setMarkerShapeLocal _shape;

if (toLower _shape isEqualTo "icon") then {
	_marker setMarkerTypeLocal _icon;
	_marker setMarkerTextLocal _text;
} else {
	_marker setMarkerBrushLocal _icon;
};

_marker setMarkerSizeLocal _size;
_marker setMarkerDirLocal _dir;
_marker setMarkerColorLocal _color;
_marker setMarkerAlphaLocal _alpha;
_marker setMarkerDrawPriority _priority;

_marker