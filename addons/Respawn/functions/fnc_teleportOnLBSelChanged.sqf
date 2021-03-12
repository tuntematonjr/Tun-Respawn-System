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
 * ["something", player] call Tun_Respawn_fnc_teleportOnLBSelChanged
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
params ["_control", "_selectedIndex"];

if (_selectedIndex == -1) exitWith { };

private _listIDC = 300001;
private _mapIDC = 300003;

private _value = lbData [_listIDC, _selectedIndex];
private _obj = _value call BIS_fnc_objectFromNetId;
//private _tpObject = _obj getVariable [QGVAR(teleportObject), objNull];
private _marker= _obj getVariable [QGVAR(markerName),""];
private _mapCTRL = ((findDisplay 300000) displayCtrl 300003);

ctrlMapAnimClear _mapCTRL;
_mapCTRL ctrlMapAnimAdd [1, 0.1, _obj];
ctrlMapAnimCommit _mapCTRL;