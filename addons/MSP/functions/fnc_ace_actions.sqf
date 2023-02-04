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


private _actionMain = ["Tun_respawnAction", "Respawn Actions", "\a3\Modules_F_Curator\Data\portraitRespawnTickets_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
[_vehicle, 0, ["ACE_MainActions"], _actionMain] call ace_interact_menu_fnc_addActionToClass;

//check that class exist
if !(isClass (configFile >> "CfgVehicles" >> _vehicle)) exitWith {
	private _errorText = format ["(Tun_MSP_fnc_ace_actions) Tried to add following classname as MSP: %1. But it does not exist",_vehicle];
	ERROR(_errorText);
};

//create msp action
_create_condition = { alive _target && {_target getVariable QGVAR(side) == playerSide} && { driver _target == player} && { speed player == 0 } && {!(missionNamespace getVariable [format ["%1_%2", QGVAR(status), playerSide], false])}};;
_createMSP = ["Set up MSP", "Set up MSP", "\a3\3den\data\cfgwaypoints\unload_ca.paa", {[_target, true] spawn FUNC(initate_msp_action);}, _create_condition, {}, [], [0, 0, 0], 2, [false, true, false, false, false]] call ace_interact_menu_fnc_createAction;

//remove msp action
_remove_condition = { alive _target && {_target getVariable QGVAR(side) == playerSide} && {_target getVariable [QGVAR(isMSP), false]} };
_removeMSP = ["Pack MSP", "Pack MSP", "\a3\3den\data\cfgwaypoints\load_ca.paa", {[_target, false] spawn FUNC(initate_msp_action);}, _remove_condition, {}, [], [0, 0, 0], 2, [false, true, false, false, false]] call ace_interact_menu_fnc_createAction;

//remaining time for respawn.

_timer_action = {
    _wait_time = ((missionNamespace getVariable format ["Tun_Respawn_wait_time_%1", playerSide]) - cba_missiontime);
    format ["STR_Tun_MSP_remaining_time" call BIS_fnc_localize, [_wait_time] call CBA_fnc_formatElapsedTime] call CBA_fnc_notify;
};
_timer_condition = { alive _target && {_target getVariable QGVAR(side) == playerSide}};
_chekTime = ["Check Respawn Time", "Check Respawn Time", "\a3\modules_f_curator\data\portraitskiptime_ca.paa", _timer_action, _timer_condition] call ace_interact_menu_fnc_createAction;

//Ace inteaction
[_vehicle, 1, ["ACE_SelfActions"], _createMSP] call ace_interact_menu_fnc_addActionToClass;
[_vehicle, 0, ["ACE_MainActions","Tun_respawnAction"], _removeMSP] call ace_interact_menu_fnc_addActionToClass;
[_vehicle, 0, ["ACE_MainActions","Tun_respawnAction"], _chekTime] call ace_interact_menu_fnc_addActionToClass;

//TP. I hate this system already.
[_vehicle, "Init", {
	params ["_entity"];

	private _variable = switch (playerSide) do {
		case west: { "tun_msp_vehicle_west"; };
		case east: { "tun_msp_vehicle_east"; };
		case resistance: { "tun_msp_vehicle_guer"; };
		case civilian: { "tun_msp_vehicle_civ"; };
	};
	private _menu_condition = "alive _target  && {_target getVariable ['tun_msp_isMSP', false]} && {!(_target getVariable ['tun_msp_isContested', false])}";
	private _tp_conditionText = " private _msp = missionNamespace getVariable ['%1', objNull]; private _status = _msp getVariable ['tun_msp_isContested', false]; (_target != _msp && _obj getVariable ['tun_msp_isMSP', false] && !_status) ";

	_tp_condition = format [_tp_conditionText, _variable];
	[_entity, _tp_condition, "STR_Tun_MSP_TpText" call BIS_fnc_localize, false, nil, [playerSide], true, _menu_condition, false] call Tun_Respawn_fnc_addCustomTeleporter;

}, false, [], true] call CBA_fnc_addClassEventHandler;

if (GVAR(allowCheckTicketsMSP)) then {
	_remaining_action = {
		[playerSide] call EFUNC(respawn,checkTicketCount);
	};
	_remaining_condition = { alive _target && {_target getVariable QGVAR(side) == playerSide}};
	_remainingTickets = ["STR_Tun_Respawn_CheckTickets" call BIS_fnc_localize, "STR_Tun_Respawn_CheckTickets" call BIS_fnc_localize, "\a3\modules_f_curator\data\portraitmissionname_ca.paa", _remaining_action, _remaining_condition] call ace_interact_menu_fnc_createAction;
	[_vehicle, 0, ["ACE_MainActions","Tun_respawnAction"], _remainingTickets] call ace_interact_menu_fnc_addActionToClass;
};