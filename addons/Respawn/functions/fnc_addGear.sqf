/*
 * Author: [Tuntematon]
 * [Description]
 * Give player its original gear.
 *
 * Arguments:
 * none
 *
 * Return Value:
 * none
 *
 * Example:
 * [] call TUN_Respawn_addGear
 */
#include "script_component.hpp"
if (isDedicated) exitWith { };



if (GVAR(use_gearscript)) then {
	//using gearscript
	_gearScriptPath = player getVariable [QGVAR(GearPath), "Not set"];
	if (_gearScriptPath == "Not set") exitWith { hint "this unit is missing its gearscript path!"};

	_role = player getVariable [QGVAR(Role), "Not Set"];
	if (_role == "Not set") exitWith { hint "Missing role variable !"};

	[_role, player] call compile preprocessFileLineNumbers _gearScriptPath;
} else {
	//if not using gearscript
	_var = player getVariable QGVAR(savedgear);

	_var params ["_uniform", "_vest", "_headGear", "_backPack", "_googles", "_primaryWeapon", "_secondaryWeapon", "_handGunWeapon", "_uniformItems", "_vestItems", "_backPackItems", "_primaryWeaponItems", "_secondaryWeaponItems", "_handGunItems", "_assignedItems"];

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
};