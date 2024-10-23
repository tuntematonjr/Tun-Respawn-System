/*
 * Author: [Nurmi]
 * [Description]
 *
 * Arguments:
 * 1: Object <OBJECT>
 *
 * Return Value:
 * Object hight in model coordinates, if object is higher than 1.8[m] defult value is used (1.6[m])
 *
 * Example:
 * [Object] call tunres_Respawn_fnc_getOffSet

 */
#include "script_component.hpp"

params [["_object", objNull]];

private _offSet = [];
private _size = boundingBoxReal _object;
private _height = abs (((_size select 1) select 2) - ((_size select 0) select 2));
private _pos = ASLToATL getPosASL _object;
private _realHeight = (_pos select 2) + _height;

if (_realHeight > 1.8) then {
	_offSet = _object worldToModel [_pos select 0, _pos select 1, 1.6];
} else {
	_offSet = _object worldToModel [_pos select 0, _pos select 1, _realHeight];
};

_offSet