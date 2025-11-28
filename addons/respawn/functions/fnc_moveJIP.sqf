/*
 * Author: [Tuntematon]
 * [Description]
 * Move JIP after time. Set in CBA settings
 *
 * Arguments:
 * Nones
 *
 * Return Value:
 * Nones
 *
 * Example:
 * [] call tunres_Respawn_fnc_moveJIP
 */
#include "script_component.hpp"
if (!hasInterface) exitWith { };

TRACE_2("move",cba_missiontime > GVAR(moveJIPTime),GVAR(moveJIP));
if (cba_missiontime > GVAR(moveJIPTime) && GVAR(moveJIP)) then {
	private _allowRespawn = false;
	if !(GVAR(endRespawns)) then {
		if (GVAR(respawnType) isEqualTo 0) then {
			_allowRespawn = true;
		} else {
			private _tickets = [false] call FUNC(getTicketCountClient);
			_allowRespawn = _tickets > 0;
		};	
	};

	if (_allowRespawn) then {
		private _player = [] call ace_common_fnc_player;
		private _respawnWaitingarea = (GVAR(waitingAreaHash) get playerSide) select 2;
		[_player, _respawnWaitingarea, "Move to respawn",10,false,0,5] call FUNC(teleportUnit); //TODO: stringtable

		[_player] call FUNC(removegear);
		_player setVariable [QGVAR(isWaitingRespawn), true, true];
		[_player] call FUNC(waitingArea);
	} else {
		[QGVAR(startSpectatorEH), nil] call CBA_fnc_localEvent;
	};
};
