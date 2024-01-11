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
 * [] call tunres_Respawn_fnc_waitingArea
 */
#include "script_component.hpp"
private ["_respawn_waitingarea"];

if (isDedicated || !(playerSide in [west,east,resistance,civilian]) ) exitWith { };

//tell server to add this player to list
[player, true, playerSide] remoteExecCall [QFUNC(updateWaitingRespawnList),2];

switch (playerSide) do {

	case west: {
		_respawn_waitingarea = getpos (GVAR(waitingarea_west) select 1);
	};

	case east: {
		_respawn_waitingarea = getpos (GVAR(waitingarea_east) select 1);
	};

	case resistance: {
		_respawn_waitingarea = getpos (GVAR(waitingarea_guer) select 1);
	};

	case civilian: {
		_respawn_waitingarea = getpos (GVAR(waitingarea_civ) select 1);
	};
};

[{
	params ["_respawn_waitingarea"];
	if !( player getvariable QGVAR(waiting_respawn) ) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };

	//Show remaining time
	private _hashWaitTime = GVAR(nextWaveTimes);
	private _waitTime = _hashWaitTime get playerSide;
	private _remainingWaitTime = round (_waitTime - cba_missiontime);

	if (player getVariable [QGVAR(skip_next_wave), false]) then {
		private _hashWaveLenght = GVAR(waveLenghtTimes);
		private _waveLenght = _hashWaveLenght get playerSide;
		_remainingWaitTime = _remainingWaitTime + _waveLenght;
	};


	private _text = format ["<t color='#0800ff' size = '.8'>%1</t>", "STR_tunres_Respawn_FNC_only_forced_waves" call BIS_fnc_localize];

	if (_remainingWaitTime >= 0 && { (missionNamespace getVariable [format ["%1_%2", QGVAR(allow_respawn), playerSide], true]) }) then {
		_text = format ["<t color='#0800ff' size = '.8'>%2<br />%1</t>", ([_remainingWaitTime] call CBA_fnc_formatElapsedTime), "STR_tunres_Respawn_FNC_remaining_time" call BIS_fnc_localize];
	} else {
		if (player getvariable [QGVAR(waiting_respawn), true] && { !(GVAR(forced_respawn)) }) then {
			_text = format ["<t color='#0800ff' size = '.8'>%1</t>", "STR_tunres_Respawn_FNC_RespawnDisabled" call BIS_fnc_localize];
		};
	};

	[_text,0,0,1,0] spawn BIS_fnc_dynamicText;

	//make sure that player is still in area
	private _waitingRange = GVAR(waiting_area_range);
	if !(player inArea [_respawn_waitingarea, _waitingRange, _waitingRange, 0, false]) then {
		player setPos ([_respawn_waitingarea, (_waitingRange / 2)] call CBA_fnc_randPos);
		"Get over here!" call CBA_fnc_notify;
	};

}, 1, _respawn_waitingarea] call CBA_fnc_addPerFrameHandler;
