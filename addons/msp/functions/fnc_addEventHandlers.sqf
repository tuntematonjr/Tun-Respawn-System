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
    private _vehicle = GVAR(classnames) get _side;

    //check that class exist
    if (isClass (configFile >> "CfgVehicles" >> _vehicle)) then {
        //Add side variable for vehicle classname
        if (isServer) then {
            [_vehicle, "InitPost", {
                params ["_entity"];

                AAR_UPDATE(_entity,"Is active MSP",false);
                AAR_UPDATE(_entity,"Is contested",false);
                AAR_UPDATE(_entity,"Enemies near",false);
                AAR_UPDATE(_entity,"Report enemies radius",GVAR(reportEnemiesRange));
                AAR_UPDATE(_entity,"Contested radius max",GVAR(contestedRadiusMax));
                AAR_UPDATE(_entity,"Contested radius min",GVAR(contestedRadiusMin));
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
                {
                    deleteVehicle _x;
                } forEach (_unit getVariable QGVAR(objects));

                GVAR(deployementStatus) set [_side, false];
                publicVariable QGVAR(deployementStatus);
                GVAR(activeVehicle) set [_side, objNull];
                publicVariable QGVAR(activeVehicle);

                //Do marker update                
                [_side, false] remoteExecCall ["tunres_respawn_fnc_update_respawn_point", 2];

                (localize "STR_tunres_MSP_destroyed") remoteExecCall ["CBA_fnc_notify", _side];
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
} forEach [west,east,resistance,civilian];