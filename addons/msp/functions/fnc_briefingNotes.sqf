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

if (playerSide isEqualTo sideLogic || !hasInterface) exitWith { };  // Exit if a virtual entity (IE zeus)

private _vehicle = GVAR(classnames) get playerSide;

private _text = "<font face='PuristaBold' size='20'>MSP settings</font><br/>";

if (isClass (configFile >> "CfgVehicles" >> _vehicle)) then {

	_text = format ["%1<br/>%2",_text, localize "STR_tunres_Respawn_Briefing_MspEnabled"];

	if (GVAR(reportEnemiesEnabled)) then {
		_text = format [localize "STR_tunres_Respawn_Briefing_reportEnemiesEnabled",_text, GVAR(reportEnemiesInterval), GVAR(reportEnemiesRange)];
	} else {
		_text = format ["%1<br/> %2",_text, localize "STR_tunres_Respawn_Briefing_reportEnemiesDisabled"];
	};

	if (GVAR(allowCheckTicketsMSP)) then {
		_text = format ["%1<br/>You can check remaining tickets from MSP (using ace actions).",_text];
	};

	_text = format [localize "STR_tunres_Respawn_Briefing_ContestedCheck",_text, GVAR(contestedCheckInterval), GVAR(contestedRadiusMax), GVAR(contestedRadiusMin)];
	_text = format [localize "STR_tunres_Respawn_Briefing_MspVehicle",_text, getText (configFile >> "CfgVehicles" >> _vehicle >> "displayName")];
} else {
	_text = format ["%1<br/>%2",_text, localize "STR_tunres_Respawn_Briefing_MspDisabled"];
};

_text = format ["%1<br/><br/><font color='#4F4F4F' size='11'>Powered By TuntematonEngine v%2.%3.%4</font>", _text, MAJOR, MINOR, PATCH];

//player createDiaryRecord ["Diary",["Respawn info",_text]];
if !(player diarySubjectExists "Respawn info") then {
	player createDiarySubject ["Respawn info","Tun - Respawn info"];
};

player createDiaryRecord ["Respawn info",["MSP info", _text]];