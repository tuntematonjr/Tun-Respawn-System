/*
 * Author: [Tuntematon]
 * [Description]
 * Remove gear
 *
 * Arguments:
 * none
 *
 * Return Value:
 * none
 *
 * Example:
 * [] call tunres_Respawn_fnc_removegear
 */
#include "script_component.hpp"
params[["_player", player, [objNull]]];
if (isDedicated) exitWith { };
if (isNull _player) then {
    _player = [] call ace_common_fnc_player;
};

removeAllWeapons _player;
removeAllAssignedItems _player;
removeHeadgear _player;
removeGoggles _player;
removeVest _player;
removeBackpack _player;
_player linkItem "itemMap";
_player linkItem "itemWatch";
_player linkItem "ItemCompass";