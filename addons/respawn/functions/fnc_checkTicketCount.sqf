/*
 * Author: [Tuntematon]
 * [Description]
 * Run for clints and show how many tickets left.
 *
 * Arguments:
 * 0: The first argument <SIDE>
 * Return Value:
 * None
 *
 * Example:
 * [west] call tunres_Respawn_fnc_checkTicketCount
 */
#include "script_component.hpp"
if (isDedicated) exitWith { };
params [["_side", nil, [west]]];

if (GVAR(respawn_type) isEqualTo localize "STR_tunres_Respawn_Type_Sidetickets")  then {
	_ticetCount = GVAR(tickets) get _side;
	_text = format["%1 %2","STR_tunres_Respawn_RemainingTicketsText" call BIS_fnc_localize, _ticetCount];
	_text call CBA_fnc_notify;
} else {
	[playerSide, player, true] remoteExecCall [QFUNC(getPlayerTicketCount),2];
};

