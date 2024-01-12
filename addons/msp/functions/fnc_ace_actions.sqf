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
 * [] call tunres_MSP_fnc_ace_actions
 */
#include "script_component.hpp"
if (playerSide isEqualTo sideLogic) exitWith { }; // Exit if a virtual entity (IE zeus)

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

private _actionMain = ["tunres_respawnAction", "Respawn Actions", "\a3\Modules_F_Curator\Data\portraitRespawnTickets_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
[_vehicle, 0, ["ACE_MainActions"], _actionMain] call ace_interact_menu_fnc_addActionToClass;

//check that class exist
if (isClass (configFile >> "CfgVehicles" >> _vehicle)) then {
	//create msp action
	private _create_condition = { alive _target && {_target getVariable QGVAR(side) isEqualTo playerSide} && { driver _target isEqualTo player} && { speed player isEqualTo 0 } && {!(missionNamespace getVariable [format ["%1_%2", QGVAR(status), playerSide], false])}};
	_createMSP = ["Set up MSP", "Set up MSP", "\a3\3den\data\cfgwaypoints\unload_ca.paa", {[_target, true] spawn FUNC(initate_msp_action);}, _create_condition, {}, [], [0, 0, 0], 2, [false, true, false, false, false]] call ace_interact_menu_fnc_createAction;

	//remove msp action
	private _remove_condition = { alive _target && {_target getVariable QGVAR(side) isEqualTo playerSide} && {_target getVariable [QGVAR(isMSP), false]} };
	_removeMSP = ["Pack MSP", "Pack MSP", "\a3\3den\data\cfgwaypoints\load_ca.paa", {[_target, false] spawn FUNC(initate_msp_action);}, _remove_condition, {}, [], [0, 0, 0], 2, [false, true, false, false, false]] call ace_interact_menu_fnc_createAction;

	private _aliveAndSameSideConditio = { alive _target && {_target getVariable QGVAR(side) isEqualTo playerSide}};

	//check time
	private _chekTime = ["Check Respawn Time", "Check Respawn Time", "\a3\modules_f_curator\data\portraitskiptime_ca.paa", EFUNC(respawn,remainingWaitTimeNotification), _aliveAndSameSideConditio] call ace_interact_menu_fnc_createAction;

	//Check contest area
	private _checkArea = ["Check contest area", "Check contest area", "\a3\modules_f_curator\data\portraitskiptime_ca.paa", {[_target] call FUNC(contestZoneMarkers);}, _aliveAndSameSideConditio] call ace_interact_menu_fnc_createAction;

	//Ace inteaction
	[_vehicle, 1, ["ACE_SelfActions"], _createMSP] call ace_interact_menu_fnc_addActionToClass;
	[_vehicle, 0, ["ACE_MainActions","tunres_respawnAction"], _removeMSP] call ace_interact_menu_fnc_addActionToClass;
	[_vehicle, 0, ["ACE_MainActions","tunres_respawnAction"], _chekTime] call ace_interact_menu_fnc_addActionToClass;
	[_vehicle, 0, ["ACE_MainActions","tunres_respawnAction"], _checkArea] call ace_interact_menu_fnc_addActionToClass;

	//TP. I hate this system already.
	[_vehicle, "InitPost", {
		params ["_entity"];

		private _variable = switch (playerSide) do {
			case west: { "tunres_msp_vehicle_west" };
			case east: { "tunres_msp_vehicle_east" };
			case resistance: { "tunres_msp_vehicle_guer" };
			case civilian: { "tunres_msp_vehicle_civ" };
		};
		private _menu_condition = "alive _target  && {_target getVariable ['tunres_msp_isMSP', false]} && {!(_target getVariable ['tunres_msp_isContested', false])}";
		private _tp_conditionText = " private _msp = missionNamespace getVariable ['%1', objNull]; private _status = _msp getVariable ['tunres_msp_isContested', false]; (_target isNotEqualTo _msp && _obj getVariable ['tunres_msp_isMSP', false] && !_status) ";

		_tp_conditionText = format [_tp_conditionText, _variable];
		[_entity, _tp_conditionText, localize "STR_tunres_MSP_TpText", false, nil, [playerSide], true, _menu_condition, false, ["ACE_MainActions","tunres_respawnAction"]] call tunres_Respawn_fnc_addCustomTeleporter;

	}, false, [], true] call CBA_fnc_addClassEventHandler;

	if (GVAR(allowCheckTicketsMSP)) then {
		private _remaining_action = {
			[playerSide] call EFUNC(respawn,checkTicketCount);
		};
		private _remaining_condition = { alive _target && {_target getVariable QGVAR(side) isEqualTo playerSide}};
		_remainingTickets = [localize "STR_tunres_Respawn_CheckTickets", localize "STR_tunres_Respawn_CheckTickets", "\a3\modules_f_curator\data\portraitmissionname_ca.paa", _remaining_action, _remaining_condition] call ace_interact_menu_fnc_createAction;
		[_vehicle, 0, ["ACE_MainActions","tunres_respawnAction"], _remainingTickets] call ace_interact_menu_fnc_addActionToClass;
	};
} else {
	private _errorText = format ["(tunres_MSP_fnc_ace_actions) Tried to add following classname as MSP: %1. But it does not exist",_vehicle];
	ERROR(_errorText);
};
