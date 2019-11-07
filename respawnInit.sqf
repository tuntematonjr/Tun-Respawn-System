#include "script_component.hpp"

FUNC(removegear) = compile preprocessFileLineNumbers "functions\fnc_removegear.sqf";
FUNC(timer) = compile preprocessFileLineNumbers "functions\fnc_timer.sqf";
FUNC(moveRespawns) = compile preprocessFileLineNumbers "functions\fnc_moveRespawns.sqf";
FUNC(addGear) = compile preprocessFileLineNumbers "functions\fnc_addGear.sqf";
FUNC(waitingArea) = compile preprocessFileLineNumbers "functions\fnc_waitingArea.sqf";
FUNC(init) = compile preprocessFileLineNumbers "functions\fnc_init.sqf";
FUNC(startSpectator) = compile preprocessFileLineNumbers "functions\fnc_startSpectator.sqf";
FUNC(killed) = compile preprocessFileLineNumbers "functions\fnc_killed.sqf";
FUNC(ticketCountterSide) = compile preprocessFileLineNumbers "functions\fnc_ticketCountterSide.sqf";
FUNC(ticketCountterPlayer) = compile preprocessFileLineNumbers "functions\fnc_ticketCountterPlayer.sqf";
FUNC(killJIP) = compile preprocessFileLineNumbers "functions\fnc_killJIP.sqf";
FUNC(blackscreen) = compile preprocessFileLineNumbers "functions\fnc_blackscreen.sqf";


//Wave times
ISNILS(GVAR(times_west),15);
ISNILS(GVAR(times_east),10);
ISNILS(GVAR(times_guer),10);
ISNILS(GVAR(times_civ),10);

//Remaining time for wave.
ISNILS(GVAR(wait_time_west),0);
ISNILS(GVAR(wait_time_east),0);
ISNILS(GVAR(wait_time_guer),0);
ISNILS(GVAR(wait_time_civ),0);

//allowed sides to spectate !WIP!
ISNILS(GVAR(spectate_west),true);
ISNILS(GVAR(spectate_east),true);
ISNILS(GVAR(spectate_independent),true);
ISNILS(GVAR(spectate_civilian),true);

//Spectator camera modes
ISNILS(GVAR(spectate_Cameramode_1st),true);
ISNILS(GVAR(spectate_Cameramode_3th),true);
ISNILS(GVAR(spectate_Cameramode_free),true);

//Side Tickets
ISNILS(GVAR(tickets_west),0);
ISNILS(GVAR(tickets_east),0);
ISNILS(GVAR(tickets_guer),0);
ISNILS(GVAR(tickets_civ),0);

//Kill JIP
ISNILS(GVAR(killJIP_time),5); //Time after JIP is killed minutes
ISNILS(GVAR(killJIP),true);

ISNILS(GVAR(respawn_type),"default"); // "default" : Loputon aalto. Sidetickets: Tiketti aalto

ISNILS(GVAR(disconnected_players),[]);

ISNILS(GVAR(use_gearscript),true);

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
	}, [player]] call CBA_fnc_waitUntilAndExecute;
};



[] call FUNC(init);
[] call FUNC(killJIP);


addMissionEventHandler ["PlayerDisconnected", {
	if (GVAR(respawn_type) == "default") exitWith { };
	params ["_id", "_uid", "_name", "_jip", "_owner"];

	if (time > (GVAR(killJIP_time) * 60) && GVAR(killJIP)) then {
		GVAR(disconnected_players) pushBackUnique _uid;
	};
}];

