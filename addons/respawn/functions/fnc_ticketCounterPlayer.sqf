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
 * [side, player] call tunres_Respawn_fnc_ticketCounterPlayer
 */
#include "script_component.hpp"
params ["_side","_player"];
if (!isServer) exitWith { };

private _hash = GVAR(PlayerTicektsHash);
private _playerUID = getPlayerUID _player;
private _remainingTickets = [_side, _player, false] call FUNC(getTicketCountPlayer);

if ( _remainingTickets > 0 ) then {
	//if player disconnected and came back. So no ticket wasted.
	if (_playerUID in GVAR(disconnected_players)) then {
		REM(GVAR(disconnected_players), _playerUID);
	} else {
		DEC(_remainingTickets);
		AAR_UPDATE(_player,"Player tickets", _remainingTickets);
		_hash set [_playerUID, _remainingTickets];
	};
	[5] remoteExecCall ["setPlayerRespawnTime", _player];
	private _text = format["%1 %2","STR_tunres_Respawn_RemainingTicketsText" call BIS_fnc_localize, str _remainingTickets];
	_text remoteExecCall ["CBA_fnc_notify", _player];

	} else {
	[{remoteExecCall [QFUNC(startSpectator), _this];}, _player, 5] call CBA_fnc_waitAndExecute;
};