/*
 * Author: [Tuntematon]
 * [Description]
 * Save gear
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunres_Respawn_fnc_savegear
 */
#include "script_component.hpp"

private _gearToSave = getUnitLoadout player;
private _itemsList = _gearToSave select 9;
private _radio = _itemsList select 2;

if (isNumber (configFile >> "CfgWeapons" >> _radio  >> "tf_radio")) then {
	_radio = getText  (configFile >> "CfgWeapons" >> _radio  >> "tf_parent");
	_itemsList set [2, _radio];
	_gearToSave set [9, _itemsList];
};

GVAR(savedgear) = _gearToSave;