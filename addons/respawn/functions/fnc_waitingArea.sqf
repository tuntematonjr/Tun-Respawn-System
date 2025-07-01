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
params[["_player", objNull, [objNull]]];

private _playerSide = side group _player;
if (isDedicated || !(_playerSide in ALL_SIDES) ) exitWith { };

LOG("Start waiting area");

if (!isNil QGVAR(uselesBody)) then {
	LOG("Delete old body");
	deleteVehicle GVAR(uselesBody);
	GVAR(uselesBody) = nil;
};

//tell server to add this player to list
[QGVAR(updateWaitingRespawnListEH), [_player, true, _playerSide]] call CBA_fnc_serverEvent;

private _respawnWaitingarea = (GVAR(waitingAreaHash) get _playerSide) select 1;
private _waitingRange = GVAR(waitingAreaRange);
private _respawnType = GVAR(respawnType);
GVAR(mark) = 0;

GVAR(waitingAreaPFH) = [{
	_args params ["_respawnWaitingarea", "_playerSide", "_waitingRange", "_respawnType"];
	if !( player getVariable QGVAR(isWaitingRespawn) ) exitWith {
		GVAR(waitingAreaPFH) = nil;
		[_handle] call CBA_fnc_removePerFrameHandler;
	};

	private _playerSkipsWave = player getVariable [QGVAR(skipNextWave), nil];

	//Skip respawn due to slow variable init
	if (isNil "_playerSkipsWave") exitWith {};

	//Show remaining time
	private _remainingWaitTime = [_playerSide] call FUNC(getRemainingTime);

	if (_playerSkipsWave) then {
		private _hashWaveLenght = GVAR(waveLenghtTimesHash);
		private _waveLenght = _hashWaveLenght get _playerSide;
		_remainingWaitTime = _remainingWaitTime + _waveLenght;
	};

	if ((GVAR(mark) < 1 && _remainingWaitTime <= 20) || (GVAR(mark) < 2 && _remainingWaitTime <= 10) )then {
		INC(GVAR(mark));
		playSound "Orange_PhoneCall_Ringtone";
	};

	if ( _remainingWaitTime <= 5 ) then {
		playSound "TacticalPing";
	};

	private _allowRespawn = GVAR(allowRespawnHash) get _playerSide;
	private _text = format ["<t color='#0800ff' size = '0.8'>%1</t>", LLSTRING(FNC_only_forced_waves)];
	if (_remainingWaitTime >= 0 && { _allowRespawn }) then {
		_text = format ["<t color='#0800ff' size = '0.8'>%2<br />%1</t>", ([_remainingWaitTime] call CBA_fnc_formatElapsedTime), LLSTRING(FNC_remaining_time)];
	} else {
		if (player getVariable [QGVAR(isWaitingRespawn), true] && { !(GVAR(forcedRespawn)) } && { !_allowRespawn }) then {
			_text = format ["<t color='#0800ff' size = '0.8'>%1</t>", LLSTRING(FNC_RespawnDisabled)];
		} else {
			_text = format ["Something is vevy vevy wrong. time: %1 - allowRespawn: %2 - forced respawn: %3 ", _remainingWaitTime, _allowRespawn, GVAR(forcedRespawn)];
		};
	};

	if (_playerSkipsWave) then {
		_text = format["%1<br/><t color='#0800ff' size = '0.5'>%2</t>", _text, LLSTRING(FNC_playerSkipsWave)];
	};

	if (_respawnType in [1,2]) then {
		private _tickets = [false] call FUNC(getTicketCountClient);
		DEC(_respawnType); // so it works on select 
		private _ticketsTypeText = localize ([LSTRING(RemainingTicketsSide), LSTRING(RemainingTicketsPlayer)] select _respawnType);
		_text = format["%1<br/><t color='#0800ff' size = '0.5'>%2 %3</t>", _text, _ticketsTypeText, _tickets];
	};

	[_text,0,0,4,0] spawn BIS_fnc_dynamicText;

	//make sure that player is still in area
	if !(player inArea [_respawnWaitingarea, _waitingRange, _waitingRange, 0, false]) then {
		player setPosASL ([_respawnWaitingarea, (_waitingRange / 2)] call CBA_fnc_randPos);
		[QEGVAR(main,doNotification), [LLSTRING(youAreNotAllowedToLeave)]] call CBA_fnc_localEvent;
	};
}, 1, [_respawnWaitingarea, _playerSide, _waitingRange,_respawnType]] call CBA_fnc_addPerFrameHandler;
