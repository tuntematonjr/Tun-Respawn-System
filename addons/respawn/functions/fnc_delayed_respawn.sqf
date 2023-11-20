/*
 * Author: [Tuntematon]
 * [Description]
 * If remaining respawn time is less than percent specified here, player skips the next wave. Ie. if wave interval is 20 (min) and this is set to 50 (%) and player dies after there is less than 10 minutes remaining until next respawn, player will skip the next wave and needs to wait for the following one. 0 = Disabled.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [] call Tun_Respawn_fnc_delayed_respawn
 */
#include "script_component.hpp"
params ["_unit", "_side"];

_skip = false;
if (GVAR(delayed_respawn) > 0) then {

	private ["_time", "_waittime"];

	switch (_side) do {

		case west: {
			_time = GVAR(wait_time_west);
			_waittime = GVAR(time_west);
		};
		case east: {
			_time = GVAR(wait_time_east);
			_waittime = GVAR(time_east);
		};

		case resistance: {
			_time = GVAR(wait_time_guer);
			_waittime = GVAR(time_guer);
		};

		case civilian: {
			_time = GVAR(wait_time_civ);
			_waittime = GVAR(time_civ);
		};

		default {
			ERROR_MSG("Delayed respawn got no side");
		};
	};

	_skip = ((_time - cba_missiontime) < ((_waittime * 60) * (GVAR(delayed_respawn) / 100)));
};

_unit setVariable [QGVAR(skip_next_wave), _skip, true];

if (_skip) then {
	switch (_side) do {
		case west: { 
			PUSH(GVAR(waitingRespawnDelayedWest),_unit);
			FILTER(GVAR(waitingRespawnDelayedWest),(!isnull _x && _x in allPlayers && alive _x ));
			publicVariable QGVAR(waitingRespawnDelayedWest);
		};
		case east: { 
			PUSH(GVAR(waitingRespawnDelayedEast),_unit);
			FILTER(GVAR(waitingRespawnDelayedEast),(!isnull _x && _x in allPlayers && alive _x ));
			publicVariable QGVAR(waitingRespawnDelayedEast);
		};
		case resistance: { 
			PUSH(GVAR(waitingRespawnDelayedGuer),_unit);
			FILTER(GVAR(waitingRespawnDelayedGuer),(!isnull _x && _x in allPlayers && alive _x ));
			publicVariable QGVAR(waitingRespawnDelayedGuer);
		};
		case civilian: { 
			PUSH(GVAR(waitingRespawnDelayedCiv),_unit);
			FILTER(GVAR(waitingRespawnDelayedCiv),(!isnull _x && _x in allPlayers && alive _x ));
			publicVariable QGVAR(waitingRespawnDelayedCiv);
		};
	};
};

_skip