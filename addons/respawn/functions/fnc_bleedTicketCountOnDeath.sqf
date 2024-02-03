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
 * [side, player] call tunres_Respawn_fnc_bleedTicketCountOnDeath
 */
#include "script_component.hpp"
params [["_side", nil, [west]], ["_player", objNull, [objNull]]];
if (!isServer) exitWith { };

private _respawnType = GVAR(respawnType);
if (_respawnType isEqualTo 0) exitWith {
	ERROR("Tried to bleed tickets, when not using them");
};
private _playerUID = getPlayerUID _player;

//if player disconnected and came back. So no ticket wasted.
if (GVAR(disconnectedPlayers) getOrDefault [_playerUID, false]) exitWith {
	GVAR(disconnectedPlayers) set [_uid, false];
	[5] remoteExecCall ["setPlayerRespawnTime", _player];
};

private _remainingTickets = [_side, _player, false] call FUNC(getTicketCount);

if !( _remainingTickets > 0 ) exitWith {
	[{
		remoteExecCall [QFUNC(startSpectator), _this];
	}, _player, 5] call CBA_fnc_waitAndExecute;
};

DEC(_remainingTickets);

if (_respawnType isEqualTo 1) then {
	private _sideSTR = str  _side;
	AAR_UPDATE(_sideSTR,"Side tickets",_remainingTickets);
	GVAR(tickets) set [_side, _remainingTickets];
	publicVariable QGVAR(tickets);
} else {
	AAR_UPDATE(_player,"Player tickets",_remainingTickets);
	GVAR(playerTicektsHash) set [_playerUID, _remainingTickets];

	private _text = format["%1 %2",localize "STR_tunres_Respawn_RemainingTicketsText", str _remainingTickets];
	_text remoteExecCall ["CBA_fnc_notify", _player];	
};

[5] remoteExecCall ["setPlayerRespawnTime", _player];