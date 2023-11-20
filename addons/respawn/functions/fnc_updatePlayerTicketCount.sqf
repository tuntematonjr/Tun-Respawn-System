/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Player who to add tickets <OBJECT>
 * 1: New ticket count <NUMBER>
 *
 * Return Value:
 * The return true when done <BOOL>
 *
 * Example:
 * [player, 10] call Tun_Respawn_fnc_updatePlayerTicketCount
 */
#include "script_component.hpp"
if (!isServer) exitWith { };
params ["_player", "_count"];

private _hash = GVAR(PlayerTicektsHash);
private _playerUID = getPlayerUID _player;
_hash set [_playerUID, _count];