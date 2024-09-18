 /*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * ["something", player] call tunres_Main_fnc_briefingNotes
 */
#include "script_component.hpp"

if (playerSide isEqualTo sideLogic) exitWith { }; // Exit if a virtual entity (IE zeus)

private _text = "<font face='PuristaBold' size='20'>"+ LSTRING(Briefing_Header)+"</font><br/>";

if (GVAR(briefingEnableShowRespawnType)) then {
	if ( GVAR(forcedRespawn) ) then {
		_text = format ["%1<br/>- %2",_text, LSTRING(Briefing_onlyForcedWaves)];
	};
	switch (GVAR(respawnType)) do {
		case 0: { 
			_text = format ["<br/>%1<br/>- %2",_text, LSTRING(Briefing_default)];
		};
		case 1: { 
			_text = format ["<br/>%1<br/>- %2",_text, LSTRING(Briefing_sidetickets)];	
		};
		case 2: { 
			_text = format ["<br/>%1<br/>- %2",_text, LSTRING(Briefing_playertickets)];
		};
		default { };
	};
};

if (GVAR(briefingEnableShowTime)) then {
	private _waveLenghtTimeHash = GVAR(waveLenghtTimesHash);
	_text = format ["%1<br/><br/><font face='PuristaBold' size='15'>Wave interval</font>",_text];
	if (playerSide isEqualTo west || GVAR(briefingEnableShowOtherSidesDataWest)) then {
		_text = format ["%1<br/>- "+LSTRING(Briefing_WaveTime_west),_text, _waveLenghtTimeHash get west];
	};

	if (playerSide isEqualTo east || GVAR(briefingEnableShowOtherSidesDataEast)) then {
		_text = format ["%1<br/>- "+LSTRING(Briefing_WaveTime_east),_text,_waveLenghtTimeHash get east];
	};

	if (playerSide isEqualTo resistance || GVAR(briefingEnableShowOtherSidesDataResistance)) then {
		_text = format ["%1<br/>- "+LSTRING(Briefing_WaveTime_resistance),_text, _waveLenghtTimeHash get resistance];
	};

	if (playerSide isEqualTo civilian || GVAR(briefingEnableShowOtherSidesDataCivilian)) then {
		_text = format ["%1<br/>- "+LSTRING(Briefing_WaveTime_civilian),_text, _waveLenghtTimeHash get civilian];
	};

	private _delayedRespawn = GVAR(delayedRespawn);
	if (_delayedRespawn > 0) then {
		private _respawnTime = _waveLenghtTimeHash get playerSide;
		_respawnTime = _respawnTime * 60;
		private _delayedTime = [(_respawnTime * (_delayedRespawn / 100)), "M:SS"] call CBA_fnc_formatElapsedTime;
		_respawnTime = [_respawnTime, "M:SS"] call CBA_fnc_formatElapsedTime;
		_text = format ["%1<br/><br/>- " + LSTRING(Briefing_DelayedRespawn),_text, _delayedTime, _delayedRespawn, _respawnTime, "%"];
	} else {
		_text = _text + "<br/><br/>- " + LSTRING(Briefing_DelayedRespawnOff);
		
	};
};

if (GVAR(briefingEnableShowTickets) && { GVAR(respawnType) isNotEqualTo 0}) then {
	_text = format ["%1<br/><br/><font face='PuristaBold' size='15'>"+ LSTRING(Briefing_Category_Tickets) +"</font>",_text];
	if (playerSide isEqualTo west || GVAR(briefingEnableShowOtherSidesDataWest)) then {
		_text = format ["%1<br/>- "+LSTRING(Briefing_TicketCount_west),_text, GVAR(initialTicketsWest)];
	};

	if (playerSide isEqualTo east || GVAR(briefingEnableShowOtherSidesDataEast)) then {
		_text = format ["%1<br/>- "+LSTRING(Briefing_TicketCount_east),_text, GVAR(initialTicketsEast)];
	};

	if (playerSide isEqualTo resistance || GVAR(briefingEnableShowOtherSidesDataResistance)) then {
		_text = format ["%1<br/>- "+LSTRING(Briefing_TicketCount_resistance),_text, GVAR(initialTicketsResistance)];
	};

	if (playerSide isEqualTo civilian || GVAR(briefingEnableShowOtherSidesDataCivilian)) then {
		_text = format ["%1<br/>- "+LSTRING(Briefing_TicketCount_civilian),_text, GVAR(initialTicketsCivilian)];
	};
	
	if (GVAR(allowCheckTicketsBase)) then {
		_text = format ["%1<br/><br/>- "+ LSTRING(Briefing_CheckTicketsMainbase),_text];
	};
};

if (GVAR(killJIP)) then {
	_text = format [("%1<br/><br/>- "+LSTRING(Briefing_killJipEnabled)),_text, GVAR(killJipTime)];
} else {
	_text = format ["%1<br/><br/>- %2",_text, LSTRING(Briefing_killJipDisabled)];
};

_text = _text + "<br/><br/>" + LSTRING(Briefing_teleportNetwork);
_text = format ["%1<br/><br/><font color='#4F4F4F' size='11'>Powered By TuntematonEngine v%2.%3.%4</font>", _text, MAJOR, MINOR, PATCH];

if !(player diarySubjectExists QEGVAR(main,briefing)) then {
	player createDiarySubject [QEGVAR(main,briefing),LSTRING(Briefing_RespawnMainCategory)];
};

player createDiaryRecord [QEGVAR(main,briefing),[LSTRING(Briefing_RespawnInfoTab), _text]];