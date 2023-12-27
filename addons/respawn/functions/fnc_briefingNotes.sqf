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

private _text = "<font face='PuristaBold' size='20'>Respawn settings</font><br/>";

if (GVAR(briefingEnableShowRespawnType)) then {
	if ( GVAR(forced_respawn) ) then {
		_text = format ["%1<br/>%2",_text, localize "STR_tunres_Respawn_Briefing_onlyForcedWaves"];
	};
	switch (GVAR(respawn_type)) do {
		case localize "STR_tunres_Respawn_Type_Sidetickets": { 
			_text = format ["<br/>%1<br/>%2",_text, localize "STR_tunres_Respawn_Briefing_sidetickets"];	
		};
		case localize "STR_tunres_Respawn_Type_Default": { 
			_text = format ["<br/>%1<br/>%2",_text, localize "STR_tunres_Respawn_Briefing_default"];
		};
		case localize "STR_tunres_Respawn_Type_Playertickets": { 
			_text = format ["<br/>%1<br/>%2",_text, localize "STR_tunres_Respawn_Briefing_playertickets"];
		};
		default { };
	};
};

if (GVAR(briefingEnableShowTime)) then {
	_text = format ["%1<br/><br/><font face='PuristaBold' size='15'>Wave interval</font>",_text];
	if (playerSide isEqualTo west || GVAR(briefingEnableShowOtherSidesDataWest)) then {
		_text = format ["%1<br/>For West is %2min",_text, GVAR(time_west)];
	};

	if (playerSide isEqualTo east || GVAR(briefingEnableShowOtherSidesDataEast)) then {
		_text = format ["%1<br/>For East is %2min",_text, GVAR(time_east)];
	};

	if (playerSide isEqualTo resistance || GVAR(briefingEnableShowOtherSidesDataResistance)) then {
		_text = format ["%1<br/>For Resistance is %2min",_text, GVAR(time_guer)];
	};

	if (playerSide isEqualTo civilian || GVAR(briefingEnableShowOtherSidesDataCivilian)) then {
		_text = format ["%1<br/>For Civilian is %2min",_text, GVAR(time_civ)];
	};

	private _delayedRespawn = GVAR(delayed_respawn);
	if (_delayedRespawn > 0) then {
		private _respawnTime = switch (playerSide) do {
			case west: { GVAR(time_west) };
			case east: { GVAR(time_west) };
			case resistance: { GVAR(time_west) };
			case civilian: { GVAR(time_west) };
		};
		
		_respawnTime = _respawnTime * 60;
		private _delayedTime = [(_respawnTime * (_delayedRespawn / 100)), "M:SS"] call CBA_fnc_formatElapsedTime;
		_respawnTime = [_respawnTime, "M:SS"] call CBA_fnc_formatElapsedTime;
		_text = format [localize "STR_tunres_Respawn_Briefing_DelayedRespawn",_text, _delayedTime, _delayedRespawn, _respawnTime, "%"];
	} else {
		_text = _text + localize "STR_tunres_Respawn_Briefing_DelayedRespawnOff";
		
	};
};

if (GVAR(briefingEnableShowTickets) && { GVAR(briefingEnableShowRespawnType) isNotEqualTo localize "STR_tunres_Respawn_Type_Default"}) then {
	_text = format ["%1<br/><br/><font face='PuristaBold' size='15'>Tickets</font>",_text];
	if (playerSide isEqualTo west || GVAR(briefingEnableShowOtherSidesDataWest)) then {
		_text = format ["%1<br/>Ticket count: %2 (West)",_text, GVAR(tickets_west)];
	};

	if (playerSide isEqualTo east || GVAR(briefingEnableShowOtherSidesDataEast)) then {
		_text = format ["%1<br/>Ticket count: %2 (East)",_text, GVAR(tickets_east)];
	};

	if (playerSide isEqualTo resistance || GVAR(briefingEnableShowOtherSidesDataResistance)) then {
		_text = format ["%1<br/>Ticket count: %2 (Resistance)",_text, GVAR(tickets_guer)];
	};

	if (playerSide isEqualTo civilian || GVAR(briefingEnableShowOtherSidesDataCivilian)) then {
		_text = format ["%1<br/>Ticket count: %2 (Civilian)",_text, GVAR(tickets_civ)];
	};
	
	if (GVAR(allowCheckTicketsBase)) then {
		_text = format ["%1<br/>You can check remaining tickets from mainbase (flagpole, using ace actions).",_text];
	};
};

if (GVAR(killJIP)) then {
	_text = format [localize "STR_tunres_Respawn_Briefing_killJipEnabled",_text, GVAR(killJIP_time)];
} else {
	_text = format ["%1<br/><br/>%2",_text, localize "STR_tunres_Respawn_Briefing_killJipDisabled"];
};

_text = _text + localize "STR_tunres_Respawn_Briefing_teleportNetwork";
_text = format ["%1<br/><br/><font color='#4F4F4F' size='11'>Powered By TuntematonEngine v%2.%3.%4</font>", _text, MAJOR, MINOR, PATCH];

//player createDiaryRecord ["Diary",["Respawn info",_text]];
if !(player diarySubjectExists "Respawn info") then {
	player createDiarySubject ["Respawn info","Tun - Respawn info"];
};

player createDiaryRecord ["Respawn info",["Respawn info", _text]];