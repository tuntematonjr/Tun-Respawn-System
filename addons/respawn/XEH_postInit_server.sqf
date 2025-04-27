#include "script_component.hpp"

if (!GVAR(enable)) exitWith {
	INFO("Respawn not enabled, server exit");
};

if (GVAR(respawnType) isEqualTo 2) then {
	LOG("Init aar for player tickets");
	AAR_UPDATE("west","Player tickets",(round GVAR(initialTicketsWest)));
	AAR_UPDATE("east","Player tickets",(round GVAR(initialTicketsEast)));
	AAR_UPDATE("guer","Player tickets",(round GVAR(initialTicketsResistance)));
	AAR_UPDATE("civ","Player tickets",(round GVAR(initialTicketsCivilian)));
};

if (GVAR(respawnType) isNotEqualTo 0) then {
	// if player disconnect add its uid to list so when he come back. No ticket is used. Only used if Kill jip is enabled
	addMissionEventHandler ["PlayerDisconnected", {
		if (GVAR(respawnType) isEqualTo 0) exitWith { };
		params ["_id", "_uid", "_name", "_jip", "_owner"];

		if (cba_missiontime > (GVAR(killJipTime) * 60) && GVAR(killJIP)) then {
			GVAR(disconnectedPlayersHash) set [_uid, true];
		};
	}];
};

//clean bodies during briefing && safestart
addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];
	if (cba_missiontime < (GVAR(moveJIPTime) * 60) || _unit getVariable [QGVAR(isWaitingRespawn),false]) then {
		deleteVehicle _unit;
	};
	false;
}];

//AAR times  
if ( EGVAR(main,AAR_Enabled) ) then {
	[{cba_missiontime > 10}, {
		if (missionNamespace getVariable ["afi_aar2", false]) then {

			if ((GVAR(respawnType) isEqualTo 1)) then {
				private _hashTickets = GVAR(ticketsHash);
				private _enabledSideHash = GVAR(enabledSidesHash);

				if (_enabledSideHash getOrDefault [west, false]) then {
					private _ticektsWest = _hashTickets get west;
					AAR_UPDATE("west","Side tickets",_ticektsWest);
				};

				if (_enabledSideHash getOrDefault [east, false]) then {
					private _ticektsEast = _hashTickets  get east;
					AAR_UPDATE("east","Side tickets",_ticektsEast);
				};

				if (_enabledSideHash getOrDefault [resistance, false]) then {
					private _ticektsResistance = _hashTickets get resistance;
					AAR_UPDATE("guer","Side tickets",_ticektsResistance);
				};

				if (_enabledSideHash getOrDefault [civilian, false]) then {
					private _ticektsCivilian = _hashTickets get civilian;
					AAR_UPDATE("civ","Side tickets",_ticektsCivilian);
				};
			};

			[{
				private _enabledSideHash = GVAR(enabledSidesHash);
				private _hashTime = GVAR(nextWaveTimesHash);
				{
					private _side = _x;
					if (_enabledSideHash getOrDefault [_side, false]) then {
						private _time = [_side] call FUNC(getRemainingTime);
						private _sideSTR = str _side;
						AAR_UPDATE(_sideSTR,"Next respawn wave",_time);
					};
				} forEach ALL_SIDES;
			}, 10] call CBA_fnc_addPerFrameHandler;
		};
	}] call CBA_fnc_waitUntilAndExecute;
};

[QGVAR(updateRespawnPointEH), {
	params [["_side", nil, [west]], ["_update", false, [true]], ["_newPos", [0,0,0], [[]]]];
	[_side, _update, _newPos] call FUNC(updateRespawnPoint);
}] call CBA_fnc_addEventHandler;

[QGVAR(updateWaitingRespawnListEH), {
	params [["_player", nil, [objNull]], ["_addPlayer", nil, [false]], ["_side", nil, [west]], ["_skipWaitingCountUpdate", false, [false]]];
	[_player, _addPlayer, _side, _skipWaitingCountUpdate] call FUNC(updateWaitingRespawnList);
}] call CBA_fnc_addEventHandler;

[QGVAR(respawnUnitEH), {
	params [["_side", nil, [west]], ["_unit", objNull, [objNull]], ["_skipWaitingCountUpdate", false, [false]]];
	[_side, _unit,_skipWaitingCountUpdate] call FUNC(respawnUnit);
}] call CBA_fnc_addEventHandler;

[QGVAR(updateRespawnCountEH), {
	params [["_side", nil, [west]], ["_count", 0, [0]]];
	[_side, _count] call FUNC(updateRespawnCount);
}] call CBA_fnc_addEventHandler;

[QGVAR(forceRespawnWaveEH), {
	params [["_side", nil, [west]], ["_resetTimer", false, [false]]];
	[_side, _resetTimer] call FUNC(forceRespawnWave);
}] call CBA_fnc_addEventHandler;

[QGVAR(setTickectCountEH), {
	params [["_side", nil, [west]], ["_count", 0, [0]]];
	[_side, _count] call FUNC(setTicketCount);
}] call CBA_fnc_addEventHandler;

[QGVAR(updateWaitRespawnCountEH), {
	params [["_side", nil, [west]], ["_updateDelayed", false, [false]]];
	[_side, _updateDelayed] call FUNC(updateWaitingRespawnCount);
}] call CBA_fnc_addEventHandler;
