/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Flagpole <OBJECT>
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [flagPole] call Tun_Respawn_fnc_createFlagActionBase

 */
#include "script_component.hpp"

private _flag = param [0,objNull,[objNull]];

private _action = ["Tun_baseAction", "Respawn Actions","",{ }, { true }, nil, nil, [0,-0.35,-2.4]] call ace_interact_menu_fnc_createAction;
[_flag, 0, [], _action] call ace_interact_menu_fnc_addActionToObject