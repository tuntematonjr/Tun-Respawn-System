/*
 * Author: [Tuntematon]
 * [Description]
 * Create local marker.
 *
 * Arguments:
 * 0: Marker name <STRING>
 * 1: Position <ARRAY>
 * 2: Marker text <STRING>
 * 3: Icon <STRING>
 * 4: Color <STRING>
 * 5: Alpha <Number> 
 *
 * Return Value:
 *
 * Example:
 * ["RespawnPosLocal", _pos, "Respawn", "respawn_inf", _color, 1] call tunres_Respawn_fnc_createLocalMarker
 */
#include "script_component.hpp"
params [["_name", nil [""]], ["_pos", nil [[]]], ["_text", nil [""]], ["_icon", nil [""]], ["_color", nil [""]], ["_alpha", 0, [0]]];
if (!hasInterface) exitWith {};

private _marker = createMarkerLocal [_name, _pos];
_marker setMarkerTextLocal _text;
_marker setMarkerColorLocal _color;
_marker setMarkerTypeLocal _icon;
_marker setMarkerAlphaLocal _alpha;