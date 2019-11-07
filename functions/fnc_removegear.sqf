/*
 * Author: [Tuntematon]
 * [Description]
 * Remove gear
 * Arguments:
 * none
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [] call TUN_Respawn_fnc_removegear
 *
 * Public: [Yes]
 */
#include "script_component.hpp"

removeAllWeapons player;
removeAllAssignedItems player;
removeHeadgear player;
removeGoggles player;
removeVest player;
removeBackpack player;
player linkItem "itemMap";
player linkitem "itemWatch";
player linkitem "itemCompas";

