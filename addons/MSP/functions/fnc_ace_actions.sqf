/*
 * Author: [Tuntematon]
 * [Description]
 * Create ace actions to MSP vehicles
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_MSP_fnc_ace_actions
 */
#include "script_component.hpp"


private _vehicle = switch (playerSide) do {

	case west: {
		GVAR(clasnames_west);
	};

	case east: {
		GVAR(clasnames_east);
	};

	case resistance: {
		GVAR(clasnames_resistance);
	};

	case civilian: {
		GVAR(clasnames_civilian);
	};

	default {
		""
	};
};



//create msp action
_create_condition = { alive _target && {_target getVariable QGVAR(side) == playerSide} && { driver _target == player} && { speed player == 0 } && {!(missionNamespace getVariable format ["%1_%2", QGVAR(status), playerSide])}};
_createMSP = ["Set up MSP", "Set up MSP", "", {[_target, true] spawn FUNC(initate_msp_action);}, _create_condition, {}, [], [0, 0, 0], 2, [false, true, false, false, false]] call ace_interact_menu_fnc_createAction;

//remove msp action
_remove_condition = { alive _target && {_target getVariable QGVAR(side) == playerSide} && {_target getVariable [QGVAR(isMSP), false]} };
_removeMSP = ["Pack MSP", "Pack MSP", "", {[_target, false] spawn FUNC(initate_msp_action);}, _remove_condition, {}, [], [0, 0, 0], 2, [false, true, false, false, false]] call ace_interact_menu_fnc_createAction;

//remaining time for respawn.

_timer_action = {
    _wait_time = ((missionNamespace getVariable format ["Tun_Respawn_wait_time_%1", playerSide]) - cba_missiontime);
    hint format [localize "STR_Tun_MSP_remaining_time", [_wait_time] call CBA_fnc_formatElapsedTime];
};
_timer_condition = { alive _target && {_target getVariable QGVAR(side) == playerSide}};
_chekTime = ["Check Respawn Time", "Check Respawn Time", "", _timer_action, _timer_condition] call ace_interact_menu_fnc_createAction;

//Move to base
_move_condition = { alive _target && {_target getVariable QGVAR(side) == playerSide } && {_target getVariable [QGVAR(isMSP), false]} };
_movetobase_actio = {
	[false] call FUNC(move_player);
};

_movetobase = ["Move to base", localize "STR_Tun_MSP_Move_To_BASE_Action", "", _movetobase_actio, _move_condition] call ace_interact_menu_fnc_createAction;


//Ace inteaction
[_vehicle, 1, ["ACE_SelfActions"], _createMSP] call ace_interact_menu_fnc_addActionToClass;
[_vehicle, 0, ["ACE_MainActions"], _removeMSP] call ace_interact_menu_fnc_addActionToClass;
[_vehicle, 0, ["ACE_MainActions"], _chekTime] call ace_interact_menu_fnc_addActionToClass;
[_vehicle, 0, ["ACE_MainActions"], _movetobase] call ace_interact_menu_fnc_addActionToClass;