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

private _vehicle = GVAR(classnamesHash) get playerSide;

private _actionMain = [QEGVAR(main,respawnAction), LLSTRING(AceAction_RespawnActions), "\a3\Modules_F_Curator\Data\portraitRespawnTickets_ca.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
[_vehicle, 0, ["ACE_MainActions"], _actionMain] call ace_interact_menu_fnc_addActionToClass;

//check that class exist
if (isClass (configFile >> "CfgVehicles" >> _vehicle)) then {
	//create msp action
	private _create_condition = { alive _target &&
								{_target getVariable QGVAR(side) isEqualTo playerSide} &&
								{ driver _target isEqualTo player} &&
								{ speed player isEqualTo 0 } &&
								{!((GVAR(deployementStatusHash) getOrDefault [playerSide, false]))}
								};
	_createMSP = ["Set up MSP", LLSTRING(AceAction_DeployMSP), "\a3\3den\data\cfgwaypoints\unload_ca.paa", {[_target, true] call FUNC(startUpdateDeployementStatus);}, _create_condition, {}, [], [0, 0, 0], 2, [false, true, false, false, false]] call ace_interact_menu_fnc_createAction;

	//remove msp action
	private _remove_condition = { alive _target && {_target getVariable QGVAR(side) isEqualTo playerSide} && {_target getVariable [QGVAR(isMSP), false]} };
	_removeMSP = ["Pack MSP", LLSTRING(AceAction_PackMSP), "\a3\3den\data\cfgwaypoints\load_ca.paa", {[_target, false] call FUNC(startUpdateDeployementStatus);}, _remove_condition, {}, [], [0, 0, 0], 2, [false, true, false, false, false]] call ace_interact_menu_fnc_createAction;

	private _aliveAndSameSideConditio = {alive _target && {_target getVariable QGVAR(side) isEqualTo playerSide}};
	private _aliveAndSameSideAndIsMSPConditio = {alive _target && {_target getVariable QGVAR(side) isEqualTo playerSide} && _target getVariable [QGVAR(isMSP), false]};

	//check time
	private _chekTime = ["Check Respawn Time", LELSTRING(respawn,AceAction_CheckNextWaveTime), "\a3\modules_f_curator\data\portraitskiptime_ca.paa", EFUNC(respawn,remainingWaitTimeNotification), _aliveAndSameSideConditio] call ace_interact_menu_fnc_createAction; 

	//Check contest area
	private _checkArea = ["Check contest area", LLSTRING(AceAction_CheckMspContestedArea), "a3\ui_f\data\igui\cfg\simpletasks\types\map_ca.paa", {[_target] call FUNC(checkContestZoneArea);}, _aliveAndSameSideConditio] call ace_interact_menu_fnc_createAction;

	//Check if contested
	private _checkContest= ["Check if MSP contested", LLSTRING(AceAction_CheckIfMspContested), "", {
		private _text = localize ([LSTRING(NotContested),LSTRING(IsContested)] select (_target getVariable [QGVAR(isContested), false]));
		[QEGVAR(main,doNotification), [_text]] call CBA_fnc_localEvent;
	}, _aliveAndSameSideAndIsMSPConditio] call ace_interact_menu_fnc_createAction;

	//Ace inteaction
	[_vehicle, 1, ["ACE_SelfActions"], _createMSP] call ace_interact_menu_fnc_addActionToClass;
	[_vehicle, 0, ["ACE_MainActions",QEGVAR(main,respawnAction)], _removeMSP] call ace_interact_menu_fnc_addActionToClass;
	[_vehicle, 0, ["ACE_MainActions",QEGVAR(main,respawnAction)], _chekTime] call ace_interact_menu_fnc_addActionToClass;
	[_vehicle, 0, ["ACE_MainActions",QEGVAR(main,respawnAction)], _checkArea] call ace_interact_menu_fnc_addActionToClass;
	[_vehicle, 0, ["ACE_MainActions",QEGVAR(main,respawnAction)], _checkContest] call ace_interact_menu_fnc_addActionToClass;

	//TP. I hate this system already.
	[_vehicle, "InitPost", {
		params ["_entity"];
		private _menu_condition = toString {alive _target  && {_target getVariable [QGVAR(isMSP), false]} && {!(_target getVariable [QGVAR(isContested), false])}};
		private _tp_conditionText = toString {private _msp = GVAR(activeVehicleHash) get playerSide; private _status = _msp getVariable [QGVAR(isContested), false]; (_target isNotEqualTo _msp && _obj getVariable [QGVAR(isMSP), false] && !_status)};

		[_entity, _tp_conditionText, LLSTRING(TpText), false, nil, [playerSide], true, _menu_condition, false, ["ACE_MainActions",QEGVAR(main,respawnAction)]] call EFUNC(respawn,addCustomTeleporter);
	}, false, [], true] call CBA_fnc_addClassEventHandler;

	if (GVAR(allowCheckTicketsMSP) && EGVAR(respawn,respawnType) isNotEqualTo 0) then {
		private _remaining_action = {
			[] call EFUNC(respawn,checkTicketCount);
		};
		private _remaining_condition = { alive _target && {_target getVariable QGVAR(side) isEqualTo playerSide}};
		private _remainingTickets = [localize "STR_tunres_respawn_CheckTickets", localize "STR_tunres_respawn_CheckTickets", "\a3\modules_f_curator\data\portraitmissionname_ca.paa", _remaining_action, _remaining_condition] call ace_interact_menu_fnc_createAction;
		[_vehicle, 0, ["ACE_MainActions",QEGVAR(main,respawnAction)], _remainingTickets] call ace_interact_menu_fnc_addActionToClass;
	};
} else {
	private _errorText = format ["(tunres_MSP_fnc_addAceActions) Tried to add following classname as MSP: %1. But it does not exist",_vehicle];
	ERROR(_errorText);
};
