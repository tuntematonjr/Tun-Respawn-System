/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0:  OBJ to be added base ace actions <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [flagPole] call tunres_Respawn_fnc_addActionsPlayer
 */
#include "script_component.hpp"

params ["_object"];

private _actionPath = [_object] call FUNC(addMainAction);

if (GVAR(allowCheckTicketsBase)) then {
	[_object, true, nil, _actionPath] call FUNC(addCheckTicketCountAction);
};

//private _timer_condition = { alive _target && {_target getVariable QGVAR(side) isEqualTo playerSide}};
private _chekTime = ["Check Respawn Time", LLSTRING(AceAction_CheckNextWaveTime), "\a3\modules_f_curator\data\portraitskiptime_ca.paa", FUNC(remainingWaitTimeNotification), {true}] call ace_interact_menu_fnc_createAction;
[_object, 0, _actionPath, _chekTime] call ace_interact_menu_fnc_addActionToObject;

// Add tp action
private _conditio =  "count (missionNamespace getVariable ['tunres_respawn_teleportPoints', []]) > 1" ;
[_object, "true", LLSTRING(MainBaseText), false, nil, [playerSide], true, _conditio, false, _actionPath] call FUNC(addCustomTeleporter);
