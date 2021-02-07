/*
 * Author: [Tuntematon]
 * [Description]
 * Initate waiting area loop
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [] call TUN_Respawn_fnc_waitingArea
 */
#include "script_component.hpp"
private ["_respawn_waitingarea"];

if (isDedicated) exitWith { };

switch (toLower str playerSide) do {

	case "west": {
		_respawn_waitingarea = getpos (GVAR(waitingarea_west) select 1);
	};

	case "east": {
		_respawn_waitingarea = getpos (GVAR(waitingarea_east) select 1);
	};

	case "guer": {
		_respawn_waitingarea = getpos (GVAR(waitingarea_guer) select 1);
	};

	case "civ": {
		_respawn_waitingarea = getpos (GVAR(waitingarea_civ) select 1);
	};
};

[{
	params ["_respawn_waitingarea"];
	if !( player getvariable QGVAR(waiting_respawn) ) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };

	//Show remaining time
	private _respawn_time = (missionNamespace getVariable format ["%1_%2", QGVAR(wait_time), playerSide]);
	private _wait_time = round (_respawn_time - cba_missiontime);

	if (player getVariable [QGVAR(skip_next_wave), false]) then {
		private _wave_time = (missionNamespace getVariable format ["%1%2", QGVAR(time_), playerSide]) * 60;
		_wait_time = _wait_time + _wave_time;
	};


	private _text = format ["<t color='#0800ff' size = '.8'>%1</t>", localize "STR_Tun_Respawn_FNC_only_forced_waves"];

	if (_wait_time >= 0 && { (missionNamespace getVariable [format ["%1_%2", QGVAR(allow_respawn), playerSide], true]) }) then {
		_text = format ["<t color='#0800ff' size = '.8'>%2<br />%1</t>", ([_wait_time] call CBA_fnc_formatElapsedTime), localize "STR_Tun_Respawn_FNC_remaining_time"];
	} else {
		if (player getvariable [QGVAR(waiting_respawn), true] && { !(GVAR(forced_respawn)) }) then {
			_text = format ["<t color='#0800ff' size = '.8'>%1</t>", localize "STR_Tun_Respawn_FNC_RespawnDisabled"];
		};
	};

	[_text,0,0,1,0] spawn BIS_fnc_dynamicText;

	//make sure that player is still in area
	if !(player inArea [_respawn_waitingarea, GVAR(waiting_area_range), GVAR(waiting_area_range), 0, false]) then {
		player setPos ([_respawn_waitingarea, (GVAR(waiting_area_range) / 2)] call CBA_fnc_randPos);
		hint "Get over here!";
	};

}, 1, _respawn_waitingarea] call CBA_fnc_addPerFrameHandler;