/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Give object to get position <OBJECT> (default: {player})
 *
 * Return Value:
 * None
 *
 * Example:
 * [_target] call tunres_MSP_fnc_checkContestZoneArea

 */
#include "script_component.hpp"

if (playerSide isEqualTo sideLogic || !hasInterface) exitWith { }; 

params [["_target", player]];

openMap true;
private _pos = getPosASL _target;

[_pos] call FUNC(createContestZoneMarkers);

GVAR(contestMarkerMapEH) = addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
	if !(_mapIsOpened) then {
		removeMissionEventHandler ["Map", GVAR(contestMarkerMapEH)];
		[] call FUNC(deleteContestZoneMarkers);
		QEGVAR(Respawn,RespawnPosLocal) setMarkerAlphaLocal 1;
	};
}];

QEGVAR(Respawn,RespawnPosLocal) setMarkerAlphaLocal 0;
