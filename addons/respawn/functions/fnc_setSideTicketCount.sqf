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

if (GVAR(respawnType) isEqualTo 1) then {
	GVAR(tickets) set [_side, _count];
	publicVariable QGVAR(tickets);
	breakWith true;
} else {
	ERROR("Tried to set side tickest, when not using side tickest");
	breakWith false;
};