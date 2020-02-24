/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument <OBJECT>
 * 2: Multiple input types <STRING|ARRAY|CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE|STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: nil)
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["something", player] call TUN_Respawn_fnc_waitingArea
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
private ["_respawn_waitingarea"];


switch (toLower str playerSide) do {
	case "west": {
		_respawn_waitingarea = getMarkerPos "respawn_west";
	};

	case "east": {
		_respawn_waitingarea = getMarkerPos "respawn_east";
	};

	case "guer": {
		_respawn_waitingarea = getMarkerPos "respawn_guerrila";
	};

	case "civ": {
		_respawn_waitingarea = getMarkerPos "respawn_civilian";
	};
};

[{
	params ["_respawn_waitingarea"];
	if !( player getvariable QGVAR(waiting_respawn) ) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };

	//Show remaining time
	_wait_time = ((missionNamespace getVariable format ["%1_%2", QGVAR(wait_time), playerSide]) - cba_missiontime);

	if (_wait_time >= 0) then {
		[format ["<t color='#0800ff' size = '.8'> Remaining time until respawn<br />%1</t>", [_wait_time] call CBA_fnc_formatElapsedTime],0,0,1,0] spawn BIS_fnc_dynamicText;
	};

	//make sure that player is still in area
	if !(player inArea [_respawn_waitingarea, 35, 35, 0, false]) then {
		player setPos ([_respawn_waitingarea, 5] call CBA_fnc_randPos);
	};

}, 1, _respawn_waitingarea] call CBA_fnc_addPerFrameHandler;



