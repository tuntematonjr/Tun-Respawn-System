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
params [["_player", objNull, [objNull]]];
if (!isServer) exitWith {};

private _side = side group _player;
private _respawnType = GVAR(respawnType);
if (_respawnType isEqualTo 0) exitWith {
	ERROR("Tried to bleed tickets, when not using them");
};

//Player was already in respawn area
if ( _player getVariable [QGVAR(isWaitingRespawn), false]) exitWith {
	INFO("Player already waiting respawn");
	[1] remoteExecCall ["setPlayerRespawnTime", _player];
};

private _remainingTickets = [_side, _player, false] call FUNC(getTicketCount);

if ( _remainingTickets <= 0 ) exitWith {
	[{
		[QGVAR(startSpectatorEH), "", _this] call CBA_fnc_targetEvent;
	}, _player, 5] call CBA_fnc_waitAndExecute;
};

DEC(_remainingTickets);

if (_respawnType isEqualTo 1) then {
	private _sideSTR = str  _side;
	AAR_UPDATE(_sideSTR,"Side tickets",_remainingTickets);
	[_side, _remainingTickets] call FUNC(setTicketCount);
} else {
	AAR_UPDATE(_player,"Player tickets",_remainingTickets);
	[_player, _remainingTickets] call FUNC(setTicketCount);
};

[5] remoteExecCall ["setPlayerRespawnTime", _player];