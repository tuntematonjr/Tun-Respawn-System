/*
 * Author: [Tuntematon]
 * [Description]
 * Add init EH and killed EH to MSP
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunres_MSP_fnc_addEventHandlers
 */
#include "script_component.hpp"
{
	private _side = _x;
	private _vehicle = GVAR(classnamesHash) get _side;

	//check that class exist
	if (isClass (configFile >> "CfgVehicles" >> _vehicle)) then {
		//Add side variable for vehicle classname
		if (isServer) then {
			[_vehicle, "InitPost", {
				params ["_entity"];
				private _side = sideEmpty;
				{
					if (_y isEqualTo (typeOf _entity)) then {
						_side = _x;
						break;
					};
				} forEach GVAR(classnamesHash);

				private _values = GVAR(contestValuesHash) get _side;
				private _reportEnemiesRange = _values param [1];
				private _contestedRadiusMax = _values param [2];
				private _contestedRadiusMin = _values param [3];
				
				AAR_UPDATE(_entity,"Is active MSP",false);
				AAR_UPDATE(_entity,"Is contested",false);
				AAR_UPDATE(_entity,"Enemies near",false);
				AAR_UPDATE(_entity,"Report enemies radius",_reportEnemiesRange);
				AAR_UPDATE(_entity,"Contested radius max",_contestedRadiusMax);
				AAR_UPDATE(_entity,"Contested radius min",_contestedRadiusMin);
				AAR_UPDATE(_entity,"Enemy Count",0);
				AAR_UPDATE(_entity,"Enemy Count Min",0);
				AAR_UPDATE(_entity,"Friendly Count",0);

				_entity setVariable [QGVAR(side), _side, true];
			}, true, [], true] call CBA_fnc_addClassEventHandler;
		};

		private _mspLostEhCode = {
			params ["_unit"];
			private _side = _unit getVariable QGVAR(side);
			AAR_UPDATE(_unit,"Is active MSP","RIP");
			AAR_UPDATE(_unit,"Is contested","RIP");
			AAR_UPDATE(_unit,"Enemies near","RIP");

			if ( local _unit && { _unit getVariable [QGVAR(isMSP), false] } ) then {
				deleteVehicle (_unit getVariable QGVAR(objects));

				GVAR(deployementStatusHash) set [_side, false];
				publicVariable QGVAR(deployementStatusHash);
				GVAR(activeVehicleHash) set [_side, objNull];
				publicVariable QGVAR(activeVehicleHash);

				//Update respawn point
				[QEGVAR(respawn,updateRespawnPointEH), [_side, false]] call CBA_fnc_serverEvent;

				private _whoToNotify = [_side, 1] call FUNC(whoToNotify);
				[QEGVAR(main,doNotification), [LLSTRING(destroyed)], _whoToNotify] call CBA_fnc_targetEvent;
			};
		};

		//EH if msp is destroyed
		[_vehicle, "killed", _mspLostEhCode, true, [], true] call CBA_fnc_addClassEventHandler;

		[_vehicle, "Deleted", _mspLostEhCode, true, [], true] call CBA_fnc_addClassEventHandler;
	} else {
		if (isServer) then {
			private _errorText = format ["(tunres_MSP_fnc_addAceActions) Tried to add following classname as MSP: %1. But it does not exist",_vehicle];
			ERROR(_errorText);
		};
	};
} forEach ALL_SIDES;