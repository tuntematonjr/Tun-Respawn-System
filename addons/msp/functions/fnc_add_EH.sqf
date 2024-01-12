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
 * [] call tunres_MSP_fnc_add_eh
 */
#include "script_component.hpp"

{
    private _vehicle = _x;
    //check that class exist
    if (isClass (configFile >> "CfgVehicles" >> _vehicle)) then {
        //Add side variable for vehicle classname
        if (isServer) then {
            [_vehicle, "InitPost", {
                params ["_entity"];

                AAR_UPDATE(_entity,"Is active MSP", false);
                AAR_UPDATE(_entity,"Is contested", false);
                AAR_UPDATE(_entity,"Enemies near", false);
                AAR_UPDATE(_entity,"Report enemies radius", GVAR(report_enemies_range));
                AAR_UPDATE(_entity,"Contested radius max", GVAR(contested_radius_max));
                AAR_UPDATE(_entity,"Contested radius min", GVAR(contested_radius_min));
                AAR_UPDATE(_entity,"Enemy Count", 0);
                AAR_UPDATE(_entity,"Enemy Count Min", 0);
                AAR_UPDATE(_entity,"Friendly Count", 0);

                private _side = switch (typeOf _entity) do {
                    case GVAR(clasnames_west): { west };
                    case GVAR(clasnames_east): { east };
                    case GVAR(clasnames_resistance): { resistance };
                    case GVAR(clasnames_civilian): { civilian };
                };

                _entity setVariable [QGVAR(side), _side, true];
            }, true, [], true] call CBA_fnc_addClassEventHandler;
        };

        private _mspLostEhCode = {
            params ["_unit"];
            private _side = _unit getVariable QGVAR(side);
            AAR_UPDATE(_unit,"Is active MSP", "RIP");
            AAR_UPDATE(_unit,"Is contested", "RIP");
            AAR_UPDATE(_unit,"Enemies near", "RIP");

            if ( local _unit && { _unit getVariable [QGVAR(isMSP), false] } ) then {
                {
                    deleteVehicle _x;
                } forEach (_unit getVariable QGVAR(objects));

                switch (_side) do {
                    case east: {
                        missionNamespace setVariable [QGVAR(status_east), false, true];
                        GVAR(vehicle_east) = objNull;
                    };

                    case west: {
                        missionNamespace setVariable [QGVAR(status_west), false, true];
                        GVAR(vehicle_west) = objNull;
                    };

                    case resistance: {
                        missionNamespace setVariable [QGVAR(status_guer), false, true];
                        GVAR(vehicle_guer) = objNull;
                    };

                    case civilian: {
                        missionNamespace setVariable [QGVAR(status_civ), false, true];
                        GVAR(vehicle_civ) = objNull;
                    };

                    default { };
                };
                
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
            private _errorText = format ["(tunres_MSP_fnc_ace_actions) Tried to add following classname as MSP: %1. But it does not exist",_vehicle];
            ERROR(_errorText);
        };
    };
} forEach [GVAR(clasnames_west), GVAR(clasnames_east), GVAR(clasnames_resistance), GVAR(clasnames_civilian)];