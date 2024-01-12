#include "script_component.hpp"

if (GVAR(respawn_type) isEqualTo localize "STR_tunres_Respawn_Type_Playertickets") then {
	GVAR(PlayerTicektsHash) = createHashMap;
	AAR_UPDATE("west","Player tickets", (round GVAR(tickets_west)));
	AAR_UPDATE("east","Player tickets", (round GVAR(tickets_east)));
	AAR_UPDATE("guer","Player tickets", (round GVAR(tickets_guer)));
	AAR_UPDATE("civ","Player tickets", (round GVAR(tickets_civ)));
};

if (GVAR(respawn_type) isNotEqualTo localize "STR_tunres_Respawn_Type_Default") then {
	// if player disconnect add its uid to list so when he come back. No ticket is used. Only used if Kill jip is enabled
	addMissionEventHandler ["PlayerDisconnected", {
		if (GVAR(respawn_type) isEqualTo "default") exitWith { };
		params ["_id", "_uid", "_name", "_jip", "_owner"];

		if (cba_missiontime > (GVAR(killJIP_time) * 60) && GVAR(killJIP)) then {
			GVAR(disconnected_players) set [_uid, true];
		};
	}];
};

//clean bodies during briefing && safestart
addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];
	if (cba_missiontime < (GVAR(killJIP_time) * 60) || _unit getVariable [QGVAR(waiting_respawn),false]) then {
		deleteVehicle _unit;
	};
	false;
}];

//AAR times
if ( !isnil "afi_aar2" ) then {
	[{cba_missiontime > 10}, {
		if (missionNamespace getVariable ["afi_aar2", false]) then {

			if ((GVAR(respawn_type) isEqualTo localize "STR_tunres_Respawn_Type_Sidetickets")) then {
				private _hashTickets = GVAR(tickets)
				if (GVAR(enabled_west)) then {
					private _ticektsWest = _hashTickets get west;
					AAR_UPDATE("west","Side tickets", _ticektsWest);
				};

				if (GVAR(enabled_east)) then {
					private _ticektsEast = _hashTickets  get east;
					AAR_UPDATE("east","Side tickets", _ticektsEast);
				};

				if (GVAR(enabled_guer)) then {
					private _ticektsResistance = _hashTickets get resistance;
					AAR_UPDATE("guer","Side tickets", _ticektsResistance);
				};

				if (GVAR(enabled_civ)) then {
					private _ticektsCivilian = _hashTickets get civilian;
					AAR_UPDATE("civ","Side tickets", _ticektsCivilian);
				};
			};

			[{
				private _hashTime = GVAR(nextWaveTimes);
				if (GVAR(enabled_west)) then {
					private _time = (_hashTime get west);
					AAR_UPDATE("west","Next respawn wave", _time);
				};

				if (GVAR(enabled_east)) then {
					private _time = (_hashTime get east);
					AAR_UPDATE("east","Next respawn wave", _time);
				};

				if (GVAR(enabled_guer)) then {
					private _time = (_hashTime get resistance);
					AAR_UPDATE("guer","Next respawn wave", _time);
				};

				if (GVAR(enabled_civ)) then {
					private _time = (_hashTime get civilian);
					AAR_UPDATE("civ","Next respawn wave", _time);
				};

			}, 10] call CBA_fnc_addPerFrameHandler;
		};
	}] call CBA_fnc_waitUntilAndExecute;
};