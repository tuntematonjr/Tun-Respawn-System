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

private _vehicle = GVAR(classnamesHash) get playerSide;

private _text = "<font face='PuristaBold' size='20'>"+ LLSTRING(Briefing_Header) +"</font><br/>";

if (isClass (configFile >> "CfgVehicles" >> _vehicle)) then {

	private _values = GVAR(contestValuesHash) get playerSide;
	_values params ["_reportEnemiesInterval", "_reportEnemiesRange", "_contestedRadiusMax", "_contestedRadiusMin", "_contestedCheckInterval", "_reportEnemiesEnabled"];
	_text = format ["%1<br/>- %2",_text, LLSTRING(Briefing_MspEnabled)];

	if (_reportEnemiesEnabled) then {
		_text = format [("%1<br/><br/>- " + LLSTRING(Briefing_reportEnemiesEnabled)),_text, _reportEnemiesInterval, _reportEnemiesRange];
	} else {
		_text = format ["%1<br/><br/>- %2",_text, LLSTRING(Briefing_reportEnemiesDisabled)];
	};

	if (GVAR(allowCheckTicketsMSP)) then {
		_text = format [("%1<br/><br/>- " + LLSTRING(Briefing_CheckTicketsMsp)),_text];
	};

	_text = format ["%1<br/><br/>- "+ LLSTRING(Briefing_ContestedCheck),_text, _contestedCheckInterval, _contestedRadiusMax, _contestedRadiusMin];
	_text = format ["%1<br/><br/>- "+ LLSTRING(Briefing_MspVehicle),_text, getText (configFile >> "CfgVehicles" >> _vehicle >> "displayName")];
} else {
	_text = format ["%1<br/>- %2",_text, LLSTRING(Briefing_MspDisabled)];
};

_text = format ["%1<br/><br/><font color='#4F4F4F' size='11'>Powered By TuntematonEngine v%2.%3.%4</font>", _text, MAJOR, MINOR, PATCH];

if !(player diarySubjectExists QEGVAR(main,briefing)) then {
	player createDiarySubject [QEGVAR(main,briefing),localize "STR_tunres_respawn_Briefing_RespawnMainCategory"];
};

player createDiaryRecord [QEGVAR(main,briefing),[LLSTRING(Briefing_Category), _text]];

player createDiaryRecord [QEGVAR(main,briefing),[LLSTRING(Briefing_AreaContestCheckCategory),
LLSTRING(Briefing_AreaContestCheckText) +"
<br/><br/><font size=20><execute expression=' [true] call "+QFUNC(checkContestZoneMarkersBriefing)+"'>"+ LLSTRING(Briefing_EnableAreaContestCheck) +"</execute></font>
<br/><br/><font size=20><execute expression=' [false] call "+QFUNC(checkContestZoneMarkersBriefing)+"'>"+ LLSTRING(Briefing_DisableAreaContestCheck) +"</execute></font>"
]];