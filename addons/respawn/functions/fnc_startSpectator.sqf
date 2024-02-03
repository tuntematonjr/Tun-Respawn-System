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
 * [] call tunres_Respawn_fnc_startSpectator
 */
#include "script_component.hpp"

if (isDedicated) exitWith { };

private _allowed_sides = [];
private _notAllowed = [];
if (GVAR(spectate_west)) then {
	_allowed_sides pushBack west;
} else {
	_notAllowed pushBack west;
};

if (GVAR(spectate_east)) then {
	_allowed_sides pushBack east;
} else {
	_notAllowed pushBack east;
};

if (GVAR(spectate_independent)) then {
	_allowed_sides pushBack resistance;
} else {
	_notAllowed pushBack resistance;
};

if (GVAR(spectate_civilian)) then {
	_allowed_sides pushBack civilian;
} else {
	_notAllowed pushBack civilian;
};



// use ace spectator if using ace
if ((isClass(configFile >> "CfgPatches" >> "ace_main"))) then {
	[] call ace_spectator_fnc_setSpectator; //force spectator

	[_allowed_sides, _notAllowed] call ace_spectator_fnc_updateSides;

	//Set camera modes
	[[], [0,1,2]] call ace_spectator_fnc_updateCameraModes;

	private _Cameramodes = [];

	if (GVAR(spectateCameramode1st)) then { _Cameramodes pushBack 0; };
	if (GVAR(spectateCameramode3th)) then { _Cameramodes pushBack 1; };
	if (GVAR(spectateCameramodeFree)) then { _Cameramodes pushBack 2; };

	[_Cameramodes, []] call ace_spectator_fnc_updateCameraModes;
} else {
	["Initialize", [
	player,
	 _allowed_sides,
	 true,
	 GVAR(spectateCameramodeFree),
	 GVAR(spectateCameramode3th),
	 true,
	 true,
	 true,
	 true,
	 true]] call BIS_fnc_EGSpectator;
};
