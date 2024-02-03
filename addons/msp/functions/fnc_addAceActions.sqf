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
 * [] call tunres_MSP_fnc_addAceActions
 */
#include "script_component.hpp"
if (playerSide isEqualTo sideLogic || !hasInterface) exitWith { }; // Exit if a virtual entity (IE zeus)

private _vehicle = GVAR(classnames) get playerSide;

private _actionMain = ["tunres_respawnAction", "Respawn Actions", "\a3\Modules_F_Curator\Data\portraitRespawnTickets_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
[_vehicle, 0, ["ACE_MainActions"], _actionMain] call ace_interact_menu_fnc_addActionToClass;

//check that class exist
if (isClass (configFile >> "CfgVehicles" >> _vehicle)) then {
	//create msp action
	private _create_condition = { alive _target &&
								{_target getVariable QGVAR(side) isEqualTo playerSide} &&
								{ driver _target isEqualTo player} &&
								{ speed player isEqualTo 0 } &&
								{!((GVAR(deployementStatus) getOrDefault [playerSide, false]))}
								};
	_createMSP = ["Set up MSP", "Set up MSP", "\a3\3den\data\cfgwaypoints\unload_ca.paa", {[_target, true] call FUNC(startUpdateDeployementStatus);}, _create_condition, {}, [], [0, 0, 0], 2, [false, true, false, false, false]] call ace_interact_menu_fnc_createAction;

	//remove msp action
	private _remove_condition = { alive _target && {_target getVariable QGVAR(side) isEqualTo playerSide} && {_target getVariable [QGVAR(isMSP), false]} };
	_removeMSP = ["Pack MSP", "Pack MSP", "\a3\3den\data\cfgwaypoints\load_ca.paa", {[_target, false] call FUNC(startUpdateDeployementStatus);}, _remove_condition, {}, [], [0, 0, 0], 2, [false, true, false, false, false]] call ace_interact_menu_fnc_createAction;

	private _aliveAndSameSideConditio = { alive _target && {_target getVariable QGVAR(side) isEqualTo playerSide}};

	//check time
	private _chekTime = ["Check Respawn Time", "Check Respawn Time", "\a3\modules_f_curator\data\portraitskiptime_ca.paa", EFUNC(respawn,remainingWaitTimeNotification), _aliveAndSameSideConditio] call ace_interact_menu_fnc_createAction;

	//Check contest area
	private _checkArea = ["Check contest area", "Check contest area", "a3\ui_f\data\igui\cfg\simpletasks\types\map_ca.paa", {[_target] call FUNC(createContestZoneMarkers);}, _aliveAndSameSideConditio] call ace_interact_menu_fnc_createAction;

	//Ace inteaction
	[_vehicle, 1, ["ACE_SelfActions"], _createMSP] call ace_interact_menu_fnc_addActionToClass;
	[_vehicle, 0, ["ACE_MainActions","tunres_respawnAction"], _removeMSP] call ace_interact_menu_fnc_addActionToClass;
	[_vehicle, 0, ["ACE_MainActions","tunres_respawnAction"], _chekTime] call ace_interact_menu_fnc_addActionToClass;
	[_vehicle, 0, ["ACE_MainActions","tunres_respawnAction"], _checkArea] call ace_interact_menu_fnc_addActionToClass;

	//TP. I hate this system already.
	[_vehicle, "InitPost", {
		params ["_entity"];

		private _menu_condition = "alive _target  && {_target getVariable ['tunres_msp_isMSP', false]} && {!(_target getVariable ['tunres_msp_isContested', false])}";
		private _tp_conditionText = " private _msp = "+ QGVAR(activeVehicle) +"get playerSide; private _status = _msp getVariable ['tunres_msp_isContested', false]; (_target isNotEqualTo _msp && _obj getVariable ['tunres_msp_isMSP', false] && !_status) ";

		[_entity, _tp_conditionText, localize "STR_tunres_MSP_TpText", false, nil, [playerSide], true, _menu_condition, false, ["ACE_MainActions","tunres_respawnAction"]] call EFUNC(respawn,addCustomTeleporter);

	}, false, [], true] call CBA_fnc_addClassEventHandler;

	if (GVAR(allowCheckTicketsMSP)) then {
		private _remaining_action = {
			[] call EFUNC(respawn,checkTicketCount);
		};
		private _remaining_condition = { alive _target && {_target getVariable QGVAR(side) isEqualTo playerSide}};
		_remainingTickets = [localize "STR_tunres_Respawn_CheckTickets", localize "STR_tunres_Respawn_CheckTickets", "\a3\modules_f_curator\data\portraitmissionname_ca.paa", _remaining_action, _remaining_condition] call ace_interact_menu_fnc_createAction;
		[_vehicle, 0, ["ACE_MainActions","tunres_respawnAction"], _remainingTickets] call ace_interact_menu_fnc_addActionToClass;
	};
} else {
	private _errorText = format ["(tunres_MSP_fnc_addAceActions) Tried to add following classname as MSP: %1. But it does not exist",_vehicle];
	ERROR(_errorText);
};
