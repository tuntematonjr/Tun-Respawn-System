/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Player who to add tickets <OBJECT>
 * 1: New ticket count <NUMBER>
 *
 * Return Value:
 *
 * Example:
 * [player, 10] call tunres_Respawn_fnc_setPlayerTicketCount
 */
#include "script_component.hpp"
if (!isServer) exitWith { };
params ["_player", "_count"];

private _hash = GVAR(PlayerTicektsHash);
private _playerUID = getPlayerUID _player;
_hash set [_playerUID, _count];