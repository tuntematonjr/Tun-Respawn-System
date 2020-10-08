/*
 * Author: [Tuntematon]
 * [Description]
 * Move player to MSP or Base
 *
 * Arguments:
 * 0: True = move to MSP. False = move to base <BOOl>
 *
 * Return Value:
 * None
 * Example:
 * [true] call Tun_MSP_fnc_move_player
 */
#include "script_component.hpp"
params [["_destination", false, [true]]];
private ["_currentpos", "_originalpos"];

switch (playerSide) do {
	case west: {
		_currentpos = getpos (tun_respawn_respawnpos_west select 1);
		_originalpos = (tun_respawn_respawnpos_west select 2);
	};

	case east: {
		_currentpos = getpos (tun_respawn_respawnpos_east select 1);
		_originalpos = (tun_respawn_respawnpos_east select 2);
	};

	case resistance: {
		_currentpos = getpos (tun_respawn_respawnpos_guer select 1);
		_originalpos = (tun_respawn_respawnpos_guer select 2);
	};

	case civilian: {
		_currentpos = getpos (tun_respawn_respawnpos_civ select 1);
		_originalpos = (tun_respawn_respawnpos_civ select 2);
	};
};

if (_destination) then {
	[localize "STR_Tun_MSP_Move_To_MSP_Text", 15] call Tun_Respawn_fnc_blackscreen;
	player setPos ([_currentpos, 10] call CBA_fnc_randPos);
} else {
	[localize "STR_Tun_MSP_Move_To_BASE_Text",15] call Tun_Respawn_fnc_blackscreen;
	player setPos ([_originalpos, 10] call CBA_fnc_randPos);
};