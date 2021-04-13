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
    hint format ["STR_Tun_MSP_remaining_time" call BIS_fnc_localize, [_wait_time] call CBA_fnc_formatElapsedTime];
};
_timer_condition = { alive _target && {_target getVariable QGVAR(side) == playerSide}};
_chekTime = ["Check Respawn Time", "Check Respawn Time", "", _timer_action, _timer_condition] call ace_interact_menu_fnc_createAction;

//Ace inteaction
[_vehicle, 1, ["ACE_SelfActions"], _createMSP] call ace_interact_menu_fnc_addActionToClass;
[_vehicle, 0, ["ACE_MainActions"], _removeMSP] call ace_interact_menu_fnc_addActionToClass;
[_vehicle, 0, ["ACE_MainActions"], _chekTime] call ace_interact_menu_fnc_addActionToClass;

//TP. I hate this system already.
[_vehicle, "InitPost", {
	params ["_targetobject"];

	private _menu_condition =  "alive _target  && {_target getVariable ['tun_msp_isMSP', false]}";
	private _tp_condition =  "
		private _msp = objNull;
		private _status = true; 
		switch (playerSide) do {
			case west: {
				_msp = missionNamespace getVariable ['tun_msp_vehicle_west', objNull];
				_status = missionNamespace getVariable ['tun_msp_contested_west', true];
			};

			case east: {
				_msp = missionNamespace getVariable ['tun_msp_vehicle_east', objNull];
				_status = missionNamespace getVariable ['tun_msp_contested_east', true];
			};

			case resistance: {
				_msp = missionNamespace getVariable ['tun_msp_vehicle_guer', objNull];
				_status = missionNamespace getVariable ['tun_msp_contested_guer', true];
			};

			case civilian: {
				_msp = missionNamespace getVariable ['tun_msp_vehicle_civ', objNull];
				_status = missionNamespace getVariable ['tun_msp_contested_civ', true];
			};
		};

		(_msp getVariable ['tun_msp_isMSP', false] && !_status)
	";
	[_targetobject, _tp_condition, "STR_Tun_MSP_TpText" call BIS_fnc_localize, false, nil, [playerSide], true, _menu_condition] call Tun_Respawn_fnc_addCustomTeleporter;

}, false, [], true] call CBA_fnc_addClassEventHandler;


if (GVAR(allowCheckTicketsMSP)) then {
	_remaining_action = {
		[playerSide] call FUNC(checkTicketCount);
	};
	_remaining_condition = { alive _target && {_target getVariable QGVAR(side) == playerSide}};
	_remainingTickets = ["STR_Tun_Respawn_CheckTickets" call BIS_fnc_localize, "STR_Tun_Respawn_CheckTickets" call BIS_fnc_localize, "", _remaining_action, _remaining_condition] call ace_interact_menu_fnc_createAction;
	[_vehicle, 0, ["ACE_MainActions"], _remainingTickets] call ace_interact_menu_fnc_addActionToClass;
};