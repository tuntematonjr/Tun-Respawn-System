/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument <OBJECT>
 * 2: Multiple input types <STRING|ARRAY|CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE|STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: nil)
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["something", player] call Tun_MSP_fnc_add_eh
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"

{
    _x params ["_vehicle", "_side"];

    //Add side variable for vehicle classname
    if (isServer) then {
        [_vehicle, "init", {
            params ["_entity"];
            _entity setVariable [QGVAR(side), _side, true];
            }, true, [], true] call CBA_fnc_addClassEventHandler;
    };

    //EH if msp is destroyed

    [_vehicle, "killed", {
        params ["_unit", "_killer", "_instigator", "_useEffects"];

        if ( local _unit && { _unit getVariable [QGVAR(isMSP), false] } ) then {
            private ["_markername", "_originalpos", "_status"];

            {
                 deleteVehicle _x;
            } forEach (_unit getVariable QGVAR(objects));

            _side = _unit getVariable QGVAR(side);

            switch (_side) do {
                case east: {
                    _status = QGVAR(status_east);
                    GVAR(vehicle_east) = objNull;
                    _module = tun_respawn_respawnpos_east;
                };

                case west: {
                    _status = QGVAR(status_west);
                    GVAR(vehicle_west) = objNull;
                    _module = tun_respawn_respawnpos_west;
                };

                case resistance: {
                    _status = QGVAR(status_guer);
                    GVAR(vehicle_guer) = objNull;
                    _module = tun_respawn_respawnpos_guer;
                };

                case civilian: {
                    _status = QGVAR(status_civ);
                    GVAR(vehicle_civ) = objNull;
                    _module = tun_respawn_respawnpos_civ;
                };

                default { };
            };

            //Do marker update
            [_side, false] call FUNC(update_respawn_point);

            localize "STR_Tun_MSP_destroyed" remoteExecCall ["hint", _side];

            missionNamespace setVariable [_status, false, true];
        };
    }, true, [], true] call CBA_fnc_addClassEventHandler;
} forEach [[GVAR(clasnames_west), west], [GVAR(clasnames_east), east], [GVAR(clasnames_resistance), resistance], [GVAR(clasnames_civilian), civilian]];