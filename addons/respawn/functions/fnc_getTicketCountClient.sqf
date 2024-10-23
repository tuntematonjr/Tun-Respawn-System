/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Do hint <BOOL> (optional)
 *
 * Return Value:
 * ticket count. -1 is returned when something went wrong
 * Example:
 * [false] call tunres_Respawn_fnc_getTicketCountClient
 */
#include "script_component.hpp"
if (!hasInterface) exitWith { };
params [["_doHint", false, [true]]];
private _side = playerSide;

private _ticketCount = switch (GVAR(respawnType)) do {
	case 1: { //Side ticket
		private _hash = GVAR(ticketsHash);
		_hash get _side
	};
	case 2: { // Player tickets
		missionNamespace getVariable [QGVAR(playerTickets), GVAR(ticketsHash) get _side]
	};
	default { 
		breakWith -1;
	};
};

if (_doHint && !isNull player) then {
	private _text = format["%1 %2",LLSTRING(RemainingTicketsText), str _ticketCount];
	[QEGVAR(main,doNotification), [_text]] call CBA_fnc_localEvent;
};

_ticketCount