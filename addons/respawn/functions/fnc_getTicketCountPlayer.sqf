/*
 * Author: [Tuntematon]
 * [Description]
 * Count side tickest
 *
 * Arguments:
 * 0: Playerside <side>
 * 1: player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [side, player, true] call tunres_Respawn_fnc_getTicketCountPlayer
 */
#include "script_component.hpp"
params [["_side", nil, [west]], ["_player", objNull, [objNull]], ["_doHint", false, [true]]];
if (!isServer) exitWith { };

private _hash = GVAR(PlayerTicektsHash);
private _playerUID = getPlayerUID _player;
private _remainingTickets = _hash getOrDefault [_playerUID, -10];

if (_remainingTickets isEqualTo -10) then {
	private _sideNum = [west, east, resistance, civilian] findIf { _side isEqualTo _x };
	_remainingTickets = [GVAR(tickets_west), GVAR(tickets_east), GVAR(tickets_guer), GVAR(tickets_civ)] select _sideNum;
	_hash set [_playerUID, _remainingTickets, true];
};

if (_doHint) then {
	private _text = format["%1 %2","STR_tunres_Respawn_RemainingTicketsText" call BIS_fnc_localize, str _remainingTickets];
	_text remoteExecCall ["CBA_fnc_notify", _player];
};

_remainingTickets