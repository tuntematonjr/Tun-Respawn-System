/*
 * Author: [Tuntematon]
 * [Description]
 * Helper functio to get side tickets
 * Arguments:
 * 0: Side to get tickets <SIDE>
 *
 * Return Value:
 * ticket count. 
 * Example:
 * [west] call tunres_Respawn_fnc_getSideTicketCount
 */
#include "script_component.hpp"
if (!isServer) exitWith { };
params [["_side", nil, [west]]];

private _hash = GVAR(ticketsHash);
private _ticketCount = _hash getOrDefault [_side, -1];

_ticketCount