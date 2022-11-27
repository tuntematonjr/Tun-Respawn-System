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
 * ["something", player] call Tun_Respawn_fnc_createLocalMarker
 */
#include "script_component.hpp"
params ["_name", "_pos", "_text", "_icon", "_color", ["_alpha", 0]];
if (!hasInterface) exitWith {};

private _marker = createMarkerLocal [_name, _pos];
_marker setMarkerTextLocal _text;
_marker setMarkerColorLocal _color;
_marker setMarkerTypeLocal _icon;
_marker setMarkerAlphaLocal _alpha;