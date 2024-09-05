/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Side to get tickets <SIDE>
 * 1: Player to get tickets <UNIT> (optional)
 * 2: Do hint <BOOL> (optional)
 *
 * Return Value:
 * ticket count
 * Example:
 * [west, _unit, false] call tunres_Respawn_fnc_getTicketCount
 */
#include "script_component.hpp"
if (!isServer) exitWith { };
params [["_side", nil, [west]], ["_player", objNull, [objNull]], ["_doHint", false, [true]]];
private "_ticketCount";
switch (GVAR(respawnType)) do {
	case 1: { //Side ticket
		private _hash = GVAR(ticketsHash);
		_ticketCount = _hash get _side;
	};
	case 2: { // Player tickets
		if (!isNull _player) then {
			private _hash = GVAR(playerTicektsHash);
			private _playerUID = getPlayerUID _player;
			_ticketCount = _hash getOrDefault [_playerUID, -10];

			if (_ticketCount isEqualTo -10) then {
				_ticketCount = GVAR(ticketsHash) get _side;
				_hash set [_playerUID, _ticketCount, true];
			};
		} else {
			ERROR("Tried to get player tickest from objNull");
			breakWith "player was objNull";
		};
	};
	default { 
		breakWith "Not using tickest";
	};
};

if (_doHint && !isNull _player) then {
	private _text = format["%1 %2",localize "STR_tunres_Respawn_RemainingTicketsText", str _ticketCount];
	[QEGVAR(main,doNotification), [_text], _player] call CBA_fnc_targetEvent;
};

_ticketCount
