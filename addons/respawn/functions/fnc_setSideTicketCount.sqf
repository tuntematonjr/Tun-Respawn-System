/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Side to add tickets <SIDE>
 * 1: New ticket count <NUMBER>
 *
 * Return Value:
 * True on success
 * Example:
 * [west, 10] call tunres_Respawn_fnc_setSideTicketCount
 */
#include "script_component.hpp"
if (!isServer) exitWith { };
params ["_side", "_count"];

private _hash = GVAR(tickets);
_hash set [_side, _count];