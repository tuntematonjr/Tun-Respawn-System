/*
 * Author: [Tuntematon]
 * [Description]
 * Count side tickets
 *
 * Arguments:
 * 0: Playerside <side>
 * 1: player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [side, player, true] call tunres_Respawn_fnc_getPlayerTicketCount
 */
#include "script_component.hpp"
params [["_side", nil, [west]], ["_player", objNull, [objNull]], ["_doHint", false, [true]]];
if (!isServer) exitWith { };

private _hash = GVAR(PlayerTicektsHash);
private _playerUID = getPlayerUID _player;
private _remainingTickets = _hash getOrDefault [_playerUID, -10];

if (_remainingTickets isEqualTo -10) then {
	_remainingTickets = GVAR(tickets) get _side;
	_hash set [_playerUID, _remainingTickets, true];
};

if (_doHint) then {
	private _text = format["%1 %2",localize "STR_tunres_Respawn_RemainingTicketsText", str _remainingTickets];
	_text remoteExecCall ["CBA_fnc_notify", _player];
};

_remainingTickets