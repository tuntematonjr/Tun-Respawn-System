#include "script_component.hpp"
if !(GVAR(enable)) exitWith { INFO("TUN Respawn Disabled"); };
INFO("TUN Respawn Enabled");


if (hasInterface) then {
	[{!isNull player}, {
		
		if (GVAR(gearscriptType) isEqualTo "Save gear") then {
			[] call FUNC(savegear);
		};
		
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
	[] call FUNC(radioSettings_tfar);

};

if (isServer) then {

	if (GVAR(respawn_type) isEqualTo localize "STR_Tun_Respawn_Type_Playertickets") then {
		GVAR(PlayerTicektsHash) = createHashMap;
		GVAR(tickets_west), GVAR(tickets_east), GVAR(tickets_guer), GVAR(tickets_civ);
		AAR_UPDATE("west","Player tickets", GVAR(tickets_west));
		AAR_UPDATE("east","Player tickets", GVAR(tickets_east));
		AAR_UPDATE("guer","Player tickets", GVAR(tickets_guer));
		AAR_UPDATE("civ","Player tickets", GVAR(tickets_civ));
	};

	if (GVAR(respawn_type) isNotEqualTo localize "STR_Tun_Respawn_Type_Default") then {
		// if player disconnect add its uid to list so when he come back. No ticket is used. Only used if Kill jip is enabled
		addMissionEventHandler ["PlayerDisconnected", {
			if (GVAR(respawn_type) == "default") exitWith { };
			params ["_id", "_uid", "_name", "_jip", "_owner"];

			if (cba_missiontime > (GVAR(killJIP_time) * 60) && GVAR(killJIP)) then {
				GVAR(disconnected_players) pushBackUnique _uid;
			};
		}];
	};

	//clean bodies during briefing && safestart
	addMissionEventHandler ["HandleDisconnect", {
		params ["_unit", "_id", "_uid", "_name"];
		if (cba_missiontime < (GVAR(killJIP_time) * 60) || missionNamespace getVariable [QGVAR(waiting_respawn),false]) then {
			deleteVehicle _unit;
		};
		false;
	}];

	//AAR times
	[{cba_missiontime > 10}, {
		if (GVAR(respawn_type) isEqualTo localize "STR_Tun_Respawn_Type_Sidetickets") then {
			AAR_UPDATE("west","Side tickets", GVAR(tickets_west));
			AAR_UPDATE("east","Side tickets", GVAR(tickets_east));
			AAR_UPDATE("guer","Side tickets", GVAR(tickets_guer));
			AAR_UPDATE("civ","Side tickets", GVAR(tickets_civ));
		};

		if (missionNamespace getVariable ["afi_aar2", false]) then {
			[{

				if (GVAR(enabled_west)) then {
					_time = round (GVAR(wait_time_west) - cba_missiontime);
					AAR_UPDATE("west","Next respawn wave", _time);
				};

				if (GVAR(enabled_east)) then {
					_time = round (GVAR(wait_time_east) - cba_missiontime);
					AAR_UPDATE("east","Next respawn wave", _time);
				};

				if (GVAR(enabled_guer)) then {
					_time = round (GVAR(wait_time_guer) - cba_missiontime);
					AAR_UPDATE("guer","Next respawn wave", _time);
				};

				if (GVAR(enabled_civ)) then {
					_time = round (GVAR(wait_time_civ) - cba_missiontime);
					AAR_UPDATE("civ","Next respawn wave", _time);
				};

			}, 10] call CBA_fnc_addPerFrameHandler;
		};
	}] call CBA_fnc_waitUntilAndExecute;
};