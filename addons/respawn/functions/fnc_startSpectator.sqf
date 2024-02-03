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

if (!hasInterface) exitWith { };

private _allowedSides = switch (playerSide) do {
	case west: { GVAR(allowedSpectateSidesWest) };
	case east: { GVAR(allowedSpectateSidesEast) };
	case resistance: { GVAR(allowedSpectateSidesResistance)  };
	case civilian: { GVAR(allowedSpectateSidesCivilian) };
	default { [west, east, resistance, civilian] };
};

// use ace spectator if using ace
if ((isClass(configFile >> "CfgPatches" >> "ace_main"))) then {
	[] call ace_spectator_fnc_setSpectator; //force spectator

	[_allowedSides, [west, east, resistance, civilian]] call ace_spectator_fnc_updateSides;

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
	 _allowedSides,
	 true,
	 GVAR(spectateCameramodeFree),
	 GVAR(spectateCameramode3th),
	 true,
	 true,
	 true,
	 true,
	 true]] call BIS_fnc_EGSpectator;
};