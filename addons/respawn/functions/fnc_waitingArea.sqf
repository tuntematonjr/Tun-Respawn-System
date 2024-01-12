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

private _playerSide = playerSide;
if (isDedicated || !(_playerSide in [west,east,resistance,civilian]) ) exitWith { };

//tell server to add this player to list
[player, true, _playerSide] remoteExecCall [QFUNC(updateWaitingRespawnList),2];

private _respawnWaitingarea = (GVAR(waitingArea) get _playerSide) select 1;
GVAR(firstMark) = true;

[{
	params ["_respawnWaitingarea"];
	if !( player getvariable QGVAR(isWaitingRespawn) ) exitWith { [_handle] call CBA_fnc_removePerFrameHandler; };
	private _playerSide = playerSide;
	//Show remaining time
	private _hashWaitTime = GVAR(nextWaveTimes);
	private _waitTime = _hashWaitTime get _playerSide;
	private _remainingWaitTime = round (_waitTime - cba_missiontime);

	if (player getVariable [QGVAR(skipNextWave), false]) then {
		private _hashWaveLenght = GVAR(waveLenghtTimes);
		private _waveLenght = _hashWaveLenght get _playerSide;
		_remainingWaitTime = _remainingWaitTime + _waveLenght;
	};

	if (GVAR(firstMark) && {_remainingWaitTime <= 20} ) then {
		GVAR(firstMark) = false;
		playSound "Orange_PhoneCall_Ringtone";
	};

	if ( _remainingWaitTime <= 5 ) then {
		playSound "TacticalPing";
	};

	private _text = format ["<t color='#0800ff' size = '0.8'>%1</t>", localize "STR_tunres_Respawn_FNC_only_forced_waves"];
	if (_remainingWaitTime >= 0 && { GVAR(allowRespawn) get _playerSide }) then {
		_text = format ["<t color='#0800ff' size = '0.8'>%2<br />%1</t>", ([_remainingWaitTime] call CBA_fnc_formatElapsedTime), localize "STR_tunres_Respawn_FNC_remaining_time"];
	} else {
		if (player getvariable [QGVAR(isWaitingRespawn), true] && { !(GVAR(forced_respawn)) } && { !(GVAR(allowRespawn) get _playerSide) }) then {
			_text = format ["<t color='#0800ff' size = '0.8'>%1</t>", localize "STR_tunres_Respawn_FNC_RespawnDisabled"];
		} else {
			_text = format ["Something is vevy vevy wrong. time: %1 - allowRespawn: %2 - forced respawn: %3 ", _remainingWaitTime, GVAR(allowRespawn) get playerSid, GVAR(forced_respawn)];
		};
	};

	private _usesTickets = false;
	private "_tickets";
	private "_ticketsTypeText";
	if (GVAR(respawn_type) isEqualTo localize "STR_tunres_Respawn_Type_Sidetickets") then {
		_tickets = GVAR(tickets) get _playerSide;
		_ticketsTypeText = localize "STR_tunres_Respawan_RemainingTicketsSide";
		_usesTickets = true;
	} else {
		if (GVAR(respawn_type) isEqualTo localize "STR_tunres_Respawn_Type_Playertickets") then {
			_tickets = GVAR(tickets) get _playerSide;
			_ticketsTypeText = localize "STR_tunres_Respawan_RemainingTicketsPlayer";
			_usesTickets = true;
		};
	};

	if (_usesTickets) then {
		_text = format["%1<br/><t color='#0800ff' size = '0.5'>%2 %3</t>", _text, _ticketsTypeText, _tickets];
	};

	[_text,0,0,1,0] spawn BIS_fnc_dynamicText;

	//make sure that player is still in area
	private _waitingRange = GVAR(waiting_area_range);
	if !(player inArea [_respawnWaitingarea, _waitingRange, _waitingRange, 0, false]) then {
		player setPos ([_respawnWaitingarea, (_waitingRange / 2)] call CBA_fnc_randPos);
		"Get over here!" call CBA_fnc_notify;
	};

}, 1, _respawnWaitingarea] call CBA_fnc_addPerFrameHandler;