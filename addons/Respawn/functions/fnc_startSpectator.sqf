/*
 * Author: [Tuntematon]
 * [Description]
 * Start spectator
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call TUN_Respawn_fnc_startSpectator
 */
#include "script_component.hpp"

private _allowed_sides = [];
if (GVAR(spectate_west)) then {
	_allowed_sides pushBack west;
};

if (GVAR(spectate_east)) then {
	_allowed_sides pushBack east;
};

if (GVAR(spectate_independent)) then {
	_allowed_sides pushBack resistance;
};

if (GVAR(spectate_civilian)) then {
	_allowed_sides pushBack civilian;
};



// use ace spectator if using ace
if ((isClass(configFile >> "CfgPatches" >> "ace_main"))) then {
	[] call ace_spectator_fnc_setSpectator; //force spectator

	[[], [west, east, independent, civilian]] call ace_spectator_fnc_updateSides;
	[_allowed_sides, []] call ace_spectator_fnc_updateSides;

	//Set camera modes
	[[], [0,1,2]] call ace_spectator_fnc_updateCameraModes;

	private _Cameramodes = [];

	if (GVAR(spectate_Cameramode_1st)) then { _Cameramodes pushBack 0; };
	if (GVAR(spectate_Cameramode_3th)) then { _Cameramodes pushBack 1; };
	if (GVAR(spectate_Cameramode_free)) then { _Cameramodes pushBack 2; };

	[_Cameramodes, []] call ace_spectator_fnc_updateCameraModes;
} else {
	["Initialize", [
	player,
	 _allowed_sides,
	 true,
	 GVAR(spectate_Cameramode_free),
	 GVAR(spectate_Cameramode_3th),
	 true,
	 true,
	 true,
	 true,
	 true]] call BIS_fnc_EGSpectator;
};
