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
 * [] call Tun_Respawn_fnc_briefingNotes
 */
#include "script_component.hpp"

private _text = "<font face='PuristaBold' size='30'>MSP settings</font><br/>";

_text = format ["%1<br/>- Tickets can be checked from MSP: %2",_text, GVAR(allowCheckTicketsMSP)];

_text = format ["%1<br/><br/><font face='PuristaBold' size='17'>Report enemies</font><br/>",_text];
_text = format ["%1<br/>- Report enemies: %2",_text, GVAR(report_enemies)];
if (GVAR(report_enemies)) then {
	_text = format ["%1<br/>- Report enemies interval: %2",_text, GVAR(report_enemies_interval)];
	_text = format ["%1<br/>    -%2",_text, "STR_Tun_MSP_CBA_tooltip_report_enemies_interval" call BIS_fnc_localize];

	_text = format ["%1<br/>- Report enemies range: %2",_text, GVAR(report_enemies_range)];
	_text = format ["%1<br/>    -%2",_text, "STR_Tun_MSP_CBA_tooltip_report_enemies_range" call BIS_fnc_localize];
};

_text = format ["%1<br/><br/><font face='PuristaBold' size='17'>Contested settings</font><br/>",_text];
_text = format ["%1<br/>- Contested check interval: %2",_text, GVAR(contested_check_interval)];
_text = format ["%1<br/>    -%2",_text, "STR_Tun_MSP_CBA_tooltip_contested_check_interval" call BIS_fnc_localize];

_text = format ["%1<br/>- Contested range max: %2",_text, GVAR(contested_radius_max)];
_text = format ["%1<br/>    -%2",_text, "STR_Tun_MSP_CBA_tooltip_contested_max" call BIS_fnc_localize];

_text = format ["%1<br/>- Contested range min: %2",_text, GVAR(contested_radius_min)];
_text = format ["%1<br/>    -%2",_text, "STR_Tun_MSP_CBA_tooltip_contested_min" call BIS_fnc_localize];

_text = format ["%1<br/><br/><font color='#4F4F4F' size='11'>Powered By TuntematonEngine v%2.%3.%4</font>", _text, MAJOR, MINOR, PATCHLVL];

player createDiaryRecord ["Diary",["Respawn info",_text]];
player createDiarySubject ["Respawn info","Tun - Respawn info"];
player createDiaryRecord ["Respawn info",["Tun - Respawn info",_text]];