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

if (isDedicated) exitWith { };

removeAllWeapons player;
removeAllAssignedItems player;
removeHeadgear player;
removeGoggles player;
removeVest player;
removeBackpack player;
player linkItem "itemMap";
player linkItem "itemWatch";
player linkItem "ItemCompass";