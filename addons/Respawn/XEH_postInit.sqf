#include "script_component.hpp"
if !(GVAR(enable)) exitWith { INFO("TUN Respawn Disabled"); };
INFO("TUN Respawn Enabled");

//GVAR(respawn_type) = ["default", "Sidetickets"] select GVAR(respawn_type_cba);


if (hasInterface) then {
	[{!isNull player}, {

		//Add respawn eh
		[player, "Respawn", {
			[] call FUNC(removegear);
			player setVariable [QGVAR(waiting_respawn), true, true];
			[] call FUNC(waitingArea);
		}] call CBA_fnc_addBISEventHandler;

		// Add killed EH
		[player, "killed", {
			[] call FUNC(killed);
		}] call CBA_fnc_addBISEventHandler;
	}] call CBA_fnc_waitUntilAndExecute;


	addMissionEventHandler ["Map", {
		params ["_mapIsOpened", "_mapIsForced"];
		[] call FUNC(marker_update);
	}];

	[] call FUNC(killJIP);
	[] call FUNC(marker_update);
};

if (isServer) then {
	// if player disconnect add its uid to list so when he come back. No ticket is used. Only used if Kill jip is enabled
	addMissionEventHandler ["PlayerDisconnected", {
		if (GVAR(respawn_type) == "default") exitWith { };
		params ["_id", "_uid", "_name", "_jip", "_owner"];

		if (cba_missiontime > (GVAR(killJIP_time) * 60) && GVAR(killJIP)) then {
			GVAR(disconnected_players) pushBackUnique _uid;
		};
	}];

	//clean bodies during briefing
	_cleanbodiesEH = addMissionEventHandler ["HandleDisconnect", {
		params ["_unit", "_id", "_uid", "_name"];
		deleteVehicle _unit;
		false;
	}];
	//remove clean bodies EH
	[{cba_missiontime > 0}, {
		removeMissionEventHandler ["HandleDisconnect", _this];
	},_cleanbodiesEH] call CBA_fnc_waitUntilAndExecute;
};