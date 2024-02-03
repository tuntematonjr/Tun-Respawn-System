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

if (GVAR(respawnType) isEqualTo 2) then {
	private _hash = GVAR(playerTicektsHash);
	private _playerUID = getPlayerUID _player;
	_hash set [_playerUID, _count];
	breakWith true;
} else {
	ERROR("Tried to set player tickest, when not using player tickest");
	breakWith false;
};