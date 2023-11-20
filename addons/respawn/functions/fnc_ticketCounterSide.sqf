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
 * [side, player] call TUN_Respawn_fnc_ticketCounterSide
 */
#include "script_component.hpp"
params ["_side","_player"];
if (!isServer) exitWith { };

//if player disconnected and came back. So no ticket wasted.
if (getPlayerUID _player in GVAR(disconnected_players)) exitWith {
	REM(GVAR(disconnected_players), (getPlayerUID _player));
	[5] remoteExecCall ["setPlayerRespawnTime", _player];
};

private _sideNum = [west, east, resistance, civilian] findIf { _side isEqualTo _x };
private _remainingTicketsVar = [QGVAR(tickets_west), QGVAR(tickets_east), QGVAR(tickets_guer), QGVAR(tickets_civ)] select _sideNum;
private _remainingTickets = missionNamespace getVariable _remainingTicketsVar;

if ( _remainingTickets > 0 ) then {
	DEC(_remainingTickets);
	private _sideSTR = str  _side;
	AAR_UPDATE(_sideSTR,"Side tickets", _remainingTickets);
	missionNamespace setVariable [_remainingTicketsVar, _remainingTickets, true];
	[5] remoteExecCall ["setPlayerRespawnTime", _player];
} else {
	[{remoteExecCall [QFUNC(startSpectator), _this];}, _player, 5] call CBA_fnc_waitAndExecute;
};