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
 * [] call Tun_Respawn_fnc_imanexample
 */
#include "script_component.hpp"

_skip = false;
if (GVAR(delayed_respawn) > 0) then {

	private ["_time", "_waittime"];

	switch (playerSide) do {

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

player setVariable [QGVAR(skip_next_wave), _skip, true];

_skip