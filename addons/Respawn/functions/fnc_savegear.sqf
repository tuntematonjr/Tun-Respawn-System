/*
 * Author: [Tuntematon]
 * [Description]
 * Save starting gear
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
 * [player] call Tun_Respawn_fnc_savegear
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