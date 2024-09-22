/*
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
 * [OBJECT] call tunres_Respawn_fnc_addMainAction

 */
#include "script_component.hpp"
params [["_object", nil,[objNull]]];

//Get parent action
private _parentAction = [_object] call FUNC(getParentAction);

if (count _parentAction isEqualTo 0) then {
	private _offSet = [_object] call FUNC(getOffSet);
	_parentAction = ["tunres_respawn_BaseAceAction"];
	private _actionBase = ["tunres_respawn_BaseAceAction", LLSTRING(AceAction_Main), "", {true}, {true}, nil, nil, _offSet, 8] call ace_interact_menu_fnc_createAction;
	[_object, 0, [], _actionBase] call ace_interact_menu_fnc_addActionToObject;
};

private _actionPath = _parentAction + [QEGVAR(main,respawnAction)];

//Add main action
private _actionMain = [QEGVAR(main,respawnAction), LELSTRING(msp,AceAction_RespawnActions), "\a3\modules_f\data\portraitrespawn_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
[_object, 0, _parentAction, _actionMain] call ace_interact_menu_fnc_addActionToObject;

_actionPath