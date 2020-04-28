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
	_wait_time = round ((missionNamespace getVariable format ["%1_%2", QGVAR(wait_time), playerSide]) - cba_missiontime);

	if (_wait_time >= 0) then {
		[format ["<t color='#0800ff' size = '.8'>%2<br />%1</t>", ([_wait_time] call CBA_fnc_formatElapsedTime), localize "STR_Tun_Respawn_FNC_remaining_time"],0,0,1,0] spawn BIS_fnc_dynamicText;
	};

	//make sure that player is still in area
	if !(player inArea [_respawn_waitingarea, 100, 100, 0, false]) then {
		player setPos ([_respawn_waitingarea, 5] call CBA_fnc_randPos);
		hint "Get over here!";
	};

}, 1, _respawn_waitingarea] call CBA_fnc_addPerFrameHandler;