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
private _playerSide = playerSide;
if (isDedicated || !(_playerSide in [west,east,resistance,civilian]) ) exitWith { };

//tell server to add this player to list
[player, true, _playerSide] remoteExecCall [QFUNC(updateWaitingRespawnList),2];

_respawn_waitingarea = GVAR(waitingArea) get _playerSide;

[{
	params ["_respawn_waitingarea"];
	if !( player getvariable QGVAR(waiting_respawn) ) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };
	private _playerSide = playerSide;
	//Show remaining time
	private _hashWaitTime = GVAR(nextWaveTimes);
	private _waitTime = _hashWaitTime get _playerSide;
	private _remainingWaitTime = round (_waitTime - cba_missiontime);

	if (player getVariable [QGVAR(skip_next_wave), false]) then {
		private _hashWaveLenght = GVAR(waveLenghtTimes);
		private _waveLenght = _hashWaveLenght get _playerSide;
		_remainingWaitTime = _remainingWaitTime + _waveLenght;
	};


	private _text = format ["<t color='#0800ff' size = '.8'>%1</t>", localize "STR_tunres_Respawn_FNC_only_forced_waves"];

	if (_remainingWaitTime >= 0 && { GVAR(allowRespawn) get _playerSide }) then {
		_text = format ["<t color='#0800ff' size = '.8'>%2<br />%1</t>", ([_remainingWaitTime] call CBA_fnc_formatElapsedTime), localize "STR_tunres_Respawn_FNC_remaining_time"];
	} else {
		if (player getvariable [QGVAR(waiting_respawn), true] && { !(GVAR(forced_respawn)) } && { !(GVAR(allowRespawn) get _playerSide) }) then {
			_text = format ["<t color='#0800ff' size = '.8'>%1</t>", localize "STR_tunres_Respawn_FNC_RespawnDisabled"];
		} else {
			_text = format ["Something is vevy vevy wrong. time: %1 - allowRespawn: %2 - forced respawn: %3 ", _remainingWaitTime, GVAR(allowRespawn) get playerSid, GVAR(forced_respawn)];
		};
	};

	if (GVAR(respawn_type) isEqualTo localize "STR_tunres_Respawn_Type_Default") then {
		private _tickets = GVAR(tickest) get _playerSide;
		_text = format["%1<br/>%2 %3", _text, localize "STR_tunres_Respawan_RemainingTickestSide", _tickets];
	} else {
		if (GVAR(respawn_type) isEqualTo localize "STR_tunres_Respawn_Type_Playertickets") then {
			private _tickets = GVAR(tickest) get _playerSide;
			_text = format["%1<br/>%2 %3", _text, localize "STR_tunres_Respawan_RemainingTickestPlayer", _tickets];
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
