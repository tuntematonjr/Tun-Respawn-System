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
 * ["something", player] call Tun_Respawn_fnc_briefingNotes
 */
#include "script_component.hpp"

private _text = "<font face='PuristaBold' size='30'>Respawn settings</font><br/>";

if (GVAR(briefingEnableShowRespawnType)) then {
	if ( GVAR(forced_respawn) ) then {
		_text = format ["%1<br/>Mission uses only forced respawn waves. So no respawn timer.",_text];
	} else {
		_text = format ["%1<br/>Respawn type is: %2",_text, GVAR(respawn_type)];
		_text = format ["%1<br/>    -%2",_text, "STR_Tun_Respawn_CBA_tooltip_respawntypes" call BIS_fnc_localize];
	};
};

if (GVAR(briefingEnableShowTickets)) then {

	_text = format ["%1<br/><br/><font face='PuristaBold' size='17'>Ticket counts</font><br/>",_text];
	if (playerSide isEqualTo west || GVAR(briefingEnableShowOtherSidesDataWest)) then {
		_text = format ["%1<br/>- Ticket count for west is: %2",_text, GVAR(tickets_west)];
	};

	if (playerSide isEqualTo east || GVAR(briefingEnableShowOtherSidesDataEast)) then {
		_text = format ["%1<br/>- Ticket count for east is: %2",_text, GVAR(tickets_east)];
	};

	if (playerSide isEqualTo resistance || GVAR(briefingEnableShowOtherSidesDataResistance)) then {
		_text = format ["%1<br/>- Ticket count for resistance is: %2",_text, GVAR(tickets_guer)];
	};

	if (playerSide isEqualTo civilian || GVAR(briefingEnableShowOtherSidesDataCivilian)) then {
		_text = format ["%1<br/>- Ticket count for civilian is: %2",_text, GVAR(tickets_civ)];
	};

	_text = format ["%1<br/>- Tickets can be checked from base: %2",_text, GVAR(allowCheckTicketsBase)];
};

if (GVAR(briefingEnableShowTime) ) then {

	_text = format ["%1<br/><br/><font face='PuristaBold' size='17'>Wave intervals</font><br/>",_text];
	if (playerSide isEqualTo west || GVAR(briefingEnableShowOtherSidesDataWest)) then {
		_text = format ["%1<br/>- Wave interval for west is: %2min",_text, GVAR(time_west)];
	};

	if (playerSide isEqualTo east || GVAR(briefingEnableShowOtherSidesDataEast)) then {
		_text = format ["%1<br/>- Wave interval for east is: %2min",_text, GVAR(time_east)];
	};

	if (playerSide isEqualTo resistance || GVAR(briefingEnableShowOtherSidesDataResistance)) then {
		_text = format ["%1<br/>- Wave interval for resistance is: %2min",_text, GVAR(time_guer)];
	};

	if (playerSide isEqualTo civilian || GVAR(briefingEnableShowOtherSidesDataCivilian)) then {
		_text = format ["%1<br/>- Wave interval for civilian is: %2min",_text, GVAR(time_civ)];
	};
};

_text = format ["%1<br/><br/>Delayed respawn percent is: %2%",_text, GVAR(delayed_respawn)];
_text = format ["%1<br/>    -%2",_text, "STR_Tun_Respawn_CBA_tooltip_delayed_respawn" call BIS_fnc_localize];

_text = format ["%1<br/><br/>- Kill JIP: %2",_text, GVAR(killJIP)];
if (GVAR(killJIP)) then {
	_text = format ["%1<br/>- Kill JIP after: %2 min",_text, GVAR(killJIP_time)];
	_text = format ["%1<br/>    - JIP players will be killed and move to respawn after this time. If player disconnected earlier, it wont use ticket.",_text];
};

if !(tun_msp_enable) then {
	_text = format ["%1<br/><br/><font color='#4F4F4F' size='11'>Powered By TuntematonEngine v%2.%3.%4</font>", _text, MAJOR, MINOR, PATCHLVL];
};

player createDiaryRecord ["Diary",["Respawn info",_text]];
player createDiarySubject ["Respawn info","Tun - Respawn info"];
player createDiaryRecord ["Respawn info",["Tun - Respawn info",_text]];