/*
 * Author: [Tuntematon]
 * [Description]
 * Run for clints and show how many tickets left.
 *
 * Arguments:
 * 0: The first argument <SIDE>
 * Return Value:
 * Returns remaining tickets <NUMBER>
 *
 * Example:
 * [west] call Tun_Respawn_fnc_checkTicketCount
 */
#include "script_component.hpp"
if (isDedicated) exitWith { };
params [["_side", nil, [west]]];


private _ticetCount = switch (_side) do {
	case west: { GVAR(tickets_west) };
	case east: { GVAR(tickets_east) };
	case resistance: { GVAR(tickets_guer) };
	case civilian: { GVAR(tickets_civ) };
	default { "No side" };
};

private _text = format["%1 %3: %2","STR_Tun_Respawn_RemainingTicketsText" call BIS_fnc_localize, _ticetCount, _side];
_text call CBA_fnc_notify;

_ticetCount