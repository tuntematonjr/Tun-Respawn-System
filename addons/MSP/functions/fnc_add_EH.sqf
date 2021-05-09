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
 * [] call Tun_MSP_fnc_add_eh
 */
#include "script_component.hpp"

{
    private _vehicle = _x;

    //Add side variable for vehicle classname
    if (isServer) then {
        [_vehicle, "Init", {
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
                default { };
            };

            _entity setVariable [QGVAR(side), _side, true];
        }, true, [], true] call CBA_fnc_addClassEventHandler;
    };

    //EH if msp is destroyed
    [_vehicle, "killed", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];

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
            private _side = _unit getVariable QGVAR(side);
            [_side, false] remoteExecCall ["Tun_respawn_fnc_update_respawn_point", 2];

            ("STR_Tun_MSP_destroyed" call BIS_fnc_localize) remoteExecCall ["CBA_fnc_notify", _side];
        };
    }, true, [], true] call CBA_fnc_addClassEventHandler;

    [_vehicle, "Deleted", {
        params ["_unit"];

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
            private _side = _unit getVariable QGVAR(side);
            [_side, false] remoteExecCall ["Tun_respawn_fnc_update_respawn_point", 2];

            ("STR_Tun_MSP_destroyed" call BIS_fnc_localize) remoteExecCall ["CBA_fnc_notify", _side];
        };
    }, true, [], true] call CBA_fnc_addClassEventHandler;
} forEach [GVAR(clasnames_west), GVAR(clasnames_east), GVAR(clasnames_resistance), GVAR(clasnames_civilian)];