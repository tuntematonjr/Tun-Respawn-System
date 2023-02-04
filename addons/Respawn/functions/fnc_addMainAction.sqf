﻿/*
 * Author: [Tuntematon & Nurmi]
 * [Description]
 *
 * Arguments:
 * 0: OBJECT <OBJECT>
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [OBJECT] call Tun_Respawn_fnc_addMainAction

 */
#include "script_component.hpp"
params [["_object", nil,[objNull]]];

//Get parent action
private _parentAction = [_object] call FUNC(getParentAction);

//Get object hight, so we can get an offset for the actions (only if no parent action exists)
private _offSet = [];
if (count _parentAction == 0) then {
	_offSet = [_object] call FUNC(getOffSet);
	_parentAction = ["Tun_respawnMain"];
	private _actionBase = ["Tun_respawnMain", "Main", "", {true}, {true}, nil, nil, _offSet] call ace_interact_menu_fnc_createAction;
	[_object, 0, [], _actionBase] call ace_interact_menu_fnc_addActionToObject;
};


private _actionPath = _parentAction + ["Tun_respawnAction"];

//Add main action
private _actionMain = ["Tun_respawnAction", "Respawn Actions", "\a3\modules_f\data\portraitrespawn_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
[_object, 0, _parentAction, _actionMain] call ace_interact_menu_fnc_addActionToObject;

_actionPath
//\a3\Modules_F_Curator\Data\iconRespawnTickets_ca.paa
//\a3\Modules_F_Curator\Data\portraitRespawnTickets_ca.paa

