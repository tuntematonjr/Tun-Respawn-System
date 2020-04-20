/*
 * Author: [Tuntematon]
 * [Description]
 * Save starting gear
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_Respawn_fnc_savegear
 */
#include "script_component.hpp"

_uniform = uniform player;
_vest = vest player;
_headGear = headGear player;
_backPack = backpack player;
_googles = goggles player;

_primaryWeapon = primaryWeapon player;
_secondaryWeapon = secondaryWeapon player;
_handGunWeapon = handGunWeapon player;

_uniformItems = uniformItems player;
_vestItems = vestItems player;
_backPackItems = backPackItems player;
_primaryWeaponItems = primaryWeaponItems player + primaryWeaponMagazine player;
_secondaryWeaponItems = secondaryWeaponItems player + secondaryWeaponMagazine player;
_handGunItems = handgunItems player + handgunMagazine player;

_assignedItems= assignedItems player;

player setVariable [QGVAR(savedgear), [_uniform, _vest, _headGear, _backPack, _googles, _primaryWeapon, _secondaryWeapon, _handGunWeapon, _uniformItems, _vestItems, _backPackItems, _primaryWeaponItems, _secondaryWeaponItems, _handGunItems, _assignedItems]];