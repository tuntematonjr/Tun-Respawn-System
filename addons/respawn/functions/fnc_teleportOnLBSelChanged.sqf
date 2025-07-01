/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Control <STRING>
 * 1: Index <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_control, _selectedIndex] call tunres_Respawn_fnc_teleportOnLBSelChanged
 */
#include "script_component.hpp"
params ["_control", "_selectedIndex"];

if (_selectedIndex isEqualTo -1) exitWith { };

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
