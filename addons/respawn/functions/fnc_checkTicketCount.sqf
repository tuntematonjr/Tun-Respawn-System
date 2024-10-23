/*
 * Author: [Tuntematon]
 * [Description]
 * Run for clints and do hint what shows how many tickets left.
 *
 * Arguments:
 * None
 * Return Value:
 * None
 *
 * Example:
 * [] call tunres_Respawn_fnc_checkTicketCount
 */
#include "script_component.hpp"
if (isDedicated) exitWith { };

private _respawnType = GVAR(respawnType);

if (_respawnType isEqualTo 0) exitWith {};

[playerSide, player, true] remoteExecCall [QFUNC(getTicketCount),2];