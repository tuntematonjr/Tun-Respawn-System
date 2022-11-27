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
 * ["something", player] call Tun_Main_fnc_briefingNotes
 */
#include "script_component.hpp"

private _text = "<font face='PuristaBold' size='20'>Respawn settings</font><br/>";

if (EGVAR(respawn,briefingEnableShowRespawnType)) then {
	if ( EGVAR(respawn,forced_respawn) ) then {
		_text = format ["%1<br/>%2",_text, localize "STR_Tun_Respawn_Briefing_onlyForcedWaves"];
	};
	switch (EGVAR(respawn,respawn_type)) do {
		case localize "STR_Tun_Respawn_Type_Sidetickets": { 
			_text = format ["<br/>%1<br/>%2",_text, localize "STR_Tun_Respawn_Briefing_sidetickets"];	
		};
		case localize "STR_Tun_Respawn_Type_Default": { 
			_text = format ["<br/>%1<br/>%2",_text, localize "STR_Tun_Respawn_Briefing_default"];
		};
		case localize "STR_Tun_Respawn_Type_Playertickets": { 
			_text = format ["<br/>%1<br/>%2",_text, localize "STR_Tun_Respawn_Briefing_playertickets"];
		};
		default { };
	};
};

if (EGVAR(respawn,briefingEnableShowTime)) then {
	_text = format ["%1<br/><br/><font face='PuristaBold' size='15'>Wave interval</font>",_text];
	if (playerSide isEqualTo west || EGVAR(respawn,briefingEnableShowOtherSidesDataWest)) then {
		_text = format ["%1<br/>For West is %2min",_text, EGVAR(respawn,time_west)];
	};

	if (playerSide isEqualTo east || EGVAR(respawn,briefingEnableShowOtherSidesDataEast)) then {
		_text = format ["%1<br/>For East is %2min",_text, EGVAR(respawn,time_east)];
	};

	if (playerSide isEqualTo resistance || EGVAR(respawn,briefingEnableShowOtherSidesDataResistance)) then {
		_text = format ["%1<br/>For Resistance is %2min",_text, EGVAR(respawn,time_guer)];
	};

	if (playerSide isEqualTo civilian || EGVAR(respawn,briefingEnableShowOtherSidesDataCivilian)) then {
		_text = format ["%1<br/>For Civilian is %2min",_text, EGVAR(respawn,time_civ)];
	};

	private _delayedRespawn = EGVAR(respawn,delayed_respawn);
	if (_delayedRespawn > 0) then {
		private _respawnTime = switch (playerSide) do {
			case west: { EGVAR(respawn,time_west) };
			case east: { EGVAR(respawn,time_west) };
			case resistance: { EGVAR(respawn,time_west) };
			case civilian: { EGVAR(respawn,time_west) };
		};
		
		_respawnTime = _respawnTime * 60;
		private _delayedTime = [(_respawnTime * (_delayedRespawn /100)), "M:SS"] call CBA_fnc_formatElapsedTime;
		_respawnTime = [_respawnTime, "M:SS"] call CBA_fnc_formatElapsedTime;
		_text = format [localize "STR_Tun_Respawn_Briefing_DelayedRespawn",_text, _delayedTime, _delayedRespawn, _respawnTime, "%"];
	} else {
		_text = _text + localize "STR_Tun_Respawn_Briefing_DelayedRespawnOff";
		
	};
};

if (EGVAR(respawn,briefingEnableShowTickets) && { EGVAR(respawn,briefingEnableShowRespawnType) isNotEqualTo localize "STR_Tun_Respawn_Type_Default"}) then {
	_text = format ["%1<br/><br/><font face='PuristaBold' size='15'>Tickets</font>",_text];
	if (playerSide isEqualTo west || EGVAR(respawn,briefingEnableShowOtherSidesDataWest)) then {
		_text = format ["%1<br/>Ticket count: %2 (West)",_text, EGVAR(respawn,tickets_west)];
	};

	if (playerSide isEqualTo east || EGVAR(respawn,briefingEnableShowOtherSidesDataEast)) then {
		_text = format ["%1<br/>Ticket count: %2 (East)",_text, EGVAR(respawn,tickets_east)];
	};

	if (playerSide isEqualTo resistance || EGVAR(respawn,briefingEnableShowOtherSidesDataResistance)) then {
		_text = format ["%1<br/>Ticket count: %2 (Resistance)",_text, EGVAR(respawn,tickets_guer)];
	};

	if (playerSide isEqualTo civilian || EGVAR(respawn,briefingEnableShowOtherSidesDataCivilian)) then {
		_text = format ["%1<br/>Ticket count: %2 (Civilian)",_text, EGVAR(respawn,tickets_civ)];
	};
	
	if (EGVAR(respawn,allowCheckTicketsBase)) then {
		_text = format ["%1<br/>You can check remaining tickets from mainbase (flagpole, using ace actions).",_text];
	};
	
	if (EGVAR(msp,allowCheckTicketsMSP)) then {
		_text = format ["%1<br/>You can check remaining tickets from MSP (using ace actions).",_text];
	};
};

if (EGVAR(respawn,killJIP)) then {
	_text = format [localize "STR_Tun_Respawn_Briefing_killJipEnabled",_text, EGVAR(respawn,killJIP_time)];
} else {
	_text = format ["%1<br/><br/>%2",_text, localize "STR_Tun_Respawn_Briefing_killJipDisabled"];
};

private _vehicle = switch (playerSide) do {
	case west: { EGVAR(msp,clasnames_west) };
	case east: { EGVAR(msp,clasnames_east) };
	case resistance: { EGVAR(msp,clasnames_resistance) };
	case civilian: { EGVAR(msp,clasnames_civilian) };
	default { "No side" };
};

if (EGVAR(msp,enable)) then {
	_text = format ["%1<br/><br/><font face='PuristaBold' size='20'>MSP settings</font><br/>",_text];
	if (isClass (configFile >> "CfgVehicles" >> _vehicle)) then {
		_text = format ["%1<br/>%2",_text, localize "STR_Tun_Respawn_Briefing_MspEnabled"];
		if (EGVAR(msp,report_enemies)) then {
			_text = format [localize "STR_Tun_Respawn_Briefing_reportEnemiesEnabled",_text, EGVAR(msp,report_enemies_interval), EGVAR(msp,report_enemies_range)];
		} else {
			_text = format ["%1<br/> %2",_text, localize "STR_Tun_Respawn_Briefing_reportEnemiesDisabled"];
		};

		_text = format [localize "STR_Tun_Respawn_Briefing_ContestedCheck",_text, EGVAR(msp,contested_check_interval), EGVAR(msp,contested_radius_max), EGVAR(msp,contested_radius_min)];
		_text = format [localize "STR_Tun_Respawn_Briefing_MspVehicle",_text, getText (configFile >> "CfgVehicles" >> _vehicle >> "displayName")];
	} else {
		_text = format ["%1<br/>%2",_text, localize "STR_Tun_Respawn_Briefing_MspDisabled"];
	};
};

_text = _text + localize "STR_Tun_Respawn_Briefing_teleportNetwork";
_text = format ["%1<br/><br/><font color='#4F4F4F' size='11'>Powered By TuntematonEngine v%2.%3.%4</font>", _text, MAJOR, MINOR, PATCHLVL];

player createDiaryRecord ["Diary",["Respawn info",_text]];
player createDiarySubject ["Respawn info","Tun - Respawn info"];
player createDiaryRecord ["Respawn info",["Tun - Respawn info",_text]];

