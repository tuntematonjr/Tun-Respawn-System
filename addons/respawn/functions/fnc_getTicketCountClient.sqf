/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Do hint <BOOL> (optional)
 *
 * Return Value:
 * ticket count
 * Example:
 * [false] call tunres_Respawn_fnc_getTicketCountClient
 */
#include "script_component.hpp"
if (!hasInterface) exitWith { };
params [["_doHint", false, [true]]];
private _side = playerSide;

GVAR(playerTickets)

private _ticketCount = switch (GVAR(respawnType)) do {
	case 1: { //Side ticket
		private _hash = GVAR(tickets);
		_hash get _side;
	};
	case 2: { // Player tickets
		missionNamespace getVariable [QGVAR(playerTickets), GVAR(tickets) get _side];
	};
	default { 
		breakWith "Not using tickest";
	};
};

if (_doHint && !isNull player) then {
	private _text = format["%1 %2",localize "STR_tunres_Respawn_RemainingTicketsText", str _ticketCount];
	_text remoteExecCall ["CBA_fnc_notify", player];
};

_ticketCount