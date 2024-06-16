/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Side/player to add tickets <SIDE/OBJ>
 * 1: New ticket count <NUMBER>
 *
 * Return Value:
 * True on success
 * Example:
 * [west, 10] call tunres_Respawn_fnc_setTicketCount
 */
#include "script_component.hpp"
if (!isServer) exitWith { };
params [["_target", nil, [objnull, west]], ["_count", nil, [0]]];

switch (GVAR(respawnType)) do {
	case 1: {
		if (IS_SIDE(_target)) then {
			GVAR(tickets) set [_target, _count];
			publicVariable QGVAR(tickets);
			breakWith true;
		} else {
			ERROR("Tried to set side tickest, but did not give side");
			breakWith false;
		};
	};

	case 2: { 
		if (_target in allPlayers) then {
			private _hash = GVAR(playerTicektsHash);
			private _playerUID = getPlayerUID _target;
			_hash set [_playerUID, _count];
			[_count] remoteExecCall [QFUNC(updateClientsTicketCount), _target];
			breakWith true;
		} else {
			ERROR("Tried to set player tickest, but did not give player");
			breakWith false;
		};
	};

	default {
		LOG("Tried to change ticket count, while not using tickets");
	};
};