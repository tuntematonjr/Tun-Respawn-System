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
 * ["something", player] call Tun_Respawn_fnc_addActionsPlayer
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
params ["_object"];

private _actionPath = [_object] call FUNC(addMainAction);

if (GVAR(allowCheckTicketsBase)) then {
	[_object, true, nil, _actionPath] call FUNC(addCheckTicketCountAction);
};

private _timer_action = {
    _wait_time = ((missionNamespace getVariable format ["Tun_Respawn_wait_time_%1", playerSide]) - cba_missiontime);
    format ["STR_Tun_MSP_remaining_time" call BIS_fnc_localize, [_wait_time] call CBA_fnc_formatElapsedTime] call CBA_fnc_notify;
};

//private _timer_condition = { alive _target && {_target getVariable QGVAR(side) == playerSide}};
private _chekTime = ["Check Respawn Time", "Check Respawn Time", "\a3\modules_f_curator\data\portraitskiptime_ca.paa", _timer_action, {true}] call ace_interact_menu_fnc_createAction;
[_object, 0, _actionPath, _chekTime] call ace_interact_menu_fnc_addActionToObject;

// Add tp action
private _conditio =  "count (missionNamespace getVariable ['tun_respawn_teleportPoints', []]) > 1" ;
[_object, "true", "STR_Tun_Respawn_MainBaseText" call BIS_fnc_localize, false, nil, [playerSide], true, _conditio, false, _actionPath] call FUNC(addCustomTeleporter);