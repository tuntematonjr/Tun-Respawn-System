/*
 * Author: [Tuntematon]
 * [Description]
 * This is to just to update clients ticket count for player specific tickest
 *
 * Arguments:
 * 0: Ticket count <NUBMER>
 *
 * Return Value:
 * 
 *
 * Example:
 * ["something", player] call tunres_Respawn_fnc_updateClientsTicketCount
 */
#include "script_component.hpp"

params ["_ticketCount"];

GVAR(playerTickets) = _ticketCount;
