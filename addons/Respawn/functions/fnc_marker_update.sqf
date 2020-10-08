/*
 * Author: [Tuntematon]
 * [Description]
 * Update all marker alphas. If in waiting area, makes respawn marker BIG!
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_Respawn_fnc_marker_update
 */
#include "script_component.hpp"


{
	_x params ["_marker", "_side"];

	if ( !(getMarkerColor _marker == "") && {[_side, playerSide] call BIS_fnc_sideIsFriendly} ) then {
		_marker setMarkerAlphaLocal 1;

		if (_side == playerSide) then{
			if (player getvariable [QGVAR(waiting_respawn), false]) then {
				_marker setMarkerSizeLocal [3,3];
			} else {
				_marker setMarkerSizeLocal [1,1];
			};
		};
	};
} forEach [["tun_respawn_west", west], ["tun_respawn_east", east], ["tun_respawn_guerrila", resistance], ["tun_respawn_civilian", civilian]];