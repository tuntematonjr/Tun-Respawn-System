/*
 * Author: [Tuntematon]
 * [Description]
 * Load saved gear
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_Respawn_fnc_loadSavedGear
 */
#include "script_component.hpp"

//if not using gearscript
private  _var = player getVariable QGVAR(savedgear);

_var params ["_uniform", "_vest", "_headGear", "_backPack", "_googles", "_primaryWeapon", "_secondaryWeapon", "_handGunWeapon", "_binocularWeapon", "_uniformItems", "_vestItems", "_backPackItems", "_primaryWeaponItems", "_secondaryWeaponItems", "_handGunItems", "_binocularItems", "_assignedItems"];

removeUniform player;
removeVest player;
removeHeadgear player;
removeBackpack player;
removeGoggles player;
removeAllWeapons player;
removeAllAssignedItems player;

if (_primaryWeapon != "") then {
	player addWeapon _primaryWeapon;

	//to make sure container is empty
	{
		if (_x != "") then {
			player removePrimaryWeaponItem _x;
		};
	} forEach (primaryWeaponItems player + primaryWeaponMagazine player);

	//add original stuff
	{
		if (_x != "") then {
			player addPrimaryWeaponItem _x;
		};
	} forEach _primaryWeaponItems;
};

if (_secondaryWeapon != "") then {
	player addWeapon _secondaryWeapon;

	//to make sure container is empty
	{
		if (_x != "") then {
			player removeSecondaryWeaponItem _x;
		};
	} forEach (secondaryWeaponItems player + secondaryWeaponMagazine player);

	//add original stuff
	{
		if (_x != "") then {
			player addPrimaryWeaponItem _x;
		};
	} forEach _secondaryWeaponItems;
};

if (_handGunWeapon != "") then {
	player addWeapon _handGunWeapon;

	//to make sure container is empty
	{
		if (_x != "") then {
			player removeHandgunItem _x;
		};
	} forEach (handgunItems player + handgunMagazine player);

	//add original stuff
	{
		if (_x != "") then {
			player addHandgunItem _x;
		};
	} forEach _handGunItems;
};

if (_binocularWeapon != "") then {
	player addWeapon _binocularWeapon;

	//to make sure container is empty
	{
		if (_x != "") then {
			player removeBinocularItem _x;
		};
	} forEach (binocularItems player + binocularMagazine player);

	//add original stuff
	{
		if (_x != "") then {
			player addBinocularItem _x;
		};
	} forEach _binocularItems;
};

if (count _assignedItems > 0) then {
	removeAllAssignedItems player;

	//add original stuff
	{
		player linkItem _x
	} forEach _assignedItems;
};


if (_uniform != "") then {
	player forceAddUniform _uniform;

	//to make sure container is empty
	{
		player removeItemFromUniform _x;
	} forEach uniformItems player;

	//add original stuff
	{
		player addItemToUniform _x
	} forEach _uniformItems;
};

if (_vest != "") then {
	player addVest _vest;

	//to make sure container is empty
	{
		player removeItemFromVest _x;
	} forEach vestItems player;

	//add original stuff
	{
		player addItemToVest _x
	} forEach _vestItems;
};

if (_backPack != "") then {
	player addBackpack _backPack;

	//to make sure container is empty
	{
		player removeItemFromBackpack _x;
	} forEach backPackItems player;

	//add original stuff
	{
		player addItemToBackpack _x
	} forEach _backPackItems;
};

if (_headGear != "") then {
		player addHeadgear _headGear;
};

if (_googles != "") then {
		player addGoggles _googles;
};