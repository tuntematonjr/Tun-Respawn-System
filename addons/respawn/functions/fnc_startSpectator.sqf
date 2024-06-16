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
LOG("Start spectator");

private _allowedSides = +GVAR(allowedSpectateSidesHash) get playerSide;
_allowedSides pushBackUnique playerSide;

private _notAllowedSides = [west, east, resistance, civilian] - _allowedSides;

// use ace spectator if using ace
if ((isClass(configFile >> "CfgPatches" >> "ace_main"))) then {
	[] call ace_spectator_fnc_setSpectator; //force spectator

	//Set allowed sides
	[_allowedSides, _notAllowedSides] call ace_spectator_fnc_updateSides;

	//Set camera modes
	private _allowedCameraModes = +GVAR(allowedSpectateCameraModes);
	private _notAllowedCameraModes = ALL_MODES - _allowedCameraModes;
	
	[_allowedCameraModes, _notAllowedCameraModes] call ace_spectator_fnc_updateCameraModes;
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