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
 * [] call Tun_Respawn_fnc_marker_update
 */
#include "script_component.hpp"

if (!hasInterface) exitWith { };
private _currentRespawnPos = switch (playerSide) do {
	case west: {	
		"tun_respawn_west"
	};

	case east: {
		"tun_respawn_east";
	};

	case resistance: {
		"tun_respawn_guerrila"
	};

	case civilian: {
		"tun_respawn_civilian"
	};
};

private _newPos = getMarkerPos _currentRespawnPos;
private _contestedStatus = true;
private _status = false;

"RespawnPosLocal" setMarkerPosLocal _newPos;

//show main base if respawn pos is somewhere else
if ((getMarkerPos "RespawnPosLocal") distance2D (getMarkerPos "MainBaseLocal") > 2) then {
	"MainBaseLocal" setMarkerAlphaLocal 1;
} else {
	"MainBaseLocal" setMarkerAlphaLocal 0;
};

//maker marker bigger, if waiting respawn just because
if (player getvariable [QGVAR(waiting_respawn), false]) then {
	"RespawnPosLocal" setMarkerSizeLocal [3,3];
} else {
	"RespawnPosLocal" setMarkerSizeLocal [1,1];
};



