/*
 * Author: [Tuntematon]
 * [Description]
 * Update all marker alphas. If in waiting area, makes respawn marker BIG!
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunres_Respawn_fnc_updateRespawnMarkers
 */
#include "script_component.hpp"

if (!hasInterface) exitWith { };
private _side = playerSide;
if (_side isEqualTo sideLogic) exitWith { }; // Exit if a virtual entity (IE zeus)

private _localRespawnPosMarker = QGVAR(RespawnPosLocal);
private _localMainBaseMarker = QGVAR(MainBaseLocal);

_localRespawnPosMarker setMarkerPosLocal (getMarkerPos MARKER_NAME(_side));

//show main base if respawn pos is somewhere else
if ((getMarkerPos _localRespawnPosMarker) distance2D (getMarkerPos _localMainBaseMarker) > 2) then {
	_localMainBaseMarker setMarkerAlphaLocal 1;
} else {
	_localMainBaseMarker setMarkerAlphaLocal 0;
};

//maker marker bigger, if waiting respawn just because
if (player getVariable [QGVAR(isWaitingRespawn), false]) then {
	_localRespawnPosMarker setMarkerSizeLocal [3,3];
} else {
	_localRespawnPosMarker setMarkerSizeLocal [1,1];
};