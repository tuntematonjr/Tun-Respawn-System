/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument <OBJECT>
 * 2: Multiple input types <STRING|ARRAY|CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE|STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: nil)
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["something", player] call TUN_Respawn_fnc_imanexample
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"


setPlayerRespawnTime 99999;
( "BIS_fnc_respawnSpectator" call BIS_fnc_rscLayer ) cutText [ "", "PLAIN" ];

missionNamespace getVariable format ["%1_%2", QGVAR(tickets), playerSide];

//GVAR(respawn_type) = "Sidetickets";

switch (GVAR(respawn_type)) do {
	case "Sidetickets": {
		[playerSide, player] remoteExecCall [QFUNC(ticketCountterSide),2];
	};
	case "Playertickets": {
		//WIP
	};

	default {
		setPlayerRespawnTime 5;
	};
};