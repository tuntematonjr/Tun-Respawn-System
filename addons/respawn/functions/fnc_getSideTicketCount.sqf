/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Side to get tickets <SIDE>
 *
 * Return Value:
 *
 * Example:
 * [west] call tunres_Respawn_fnc_getSideTicketCount
 */
#include "script_component.hpp"
if (!isServer) exitWith { };
params ["_side", "_count"];

private _hash = GVAR(tickets);
private _ticketCount = _hash get _side;

_ticketCount