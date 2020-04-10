/*
 * Author: [Tuntematon]
 * [Description]
 * Notify if ther is enemies inside max radius
 * Disable MPS if there is more enemies than friendlies inside max range
 * Disable MSP if there is even one enemy in min range
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_MSP_fnc_init_contested
 */
#include "script_component.hpp"


[{
    if ( GVAR(status_east) ) then {
        if (GVAR(vehicle_east) == objNull) then {
            GVAR(status_east) = false;
            ERROR("MSP Object Disapeared (EAST)");
        } else {
            [east, GVAR(vehicle_east), "TUN_respawn_east", QGVAR(contested_east)] call FUNC(contested);
        };
    };

    if ( GVAR(status_west) ) then {
        if (GVAR(vehicle_east) == objNull) then {
            GVAR(status_west) = false;
            ERROR("MSP Object Disapeared (WEST)");
        } else {
            [west, GVAR(vehicle_west), "TUN_respawn_west", QGVAR(contested_west)] call FUNC(contested);
        };
    };

    if ( GVAR(status_guer) ) then {
        if (GVAR(vehicle_guer) == objNull) then {
            GVAR(status_guer) = false;
            ERROR("MSP Object Disapeared (RESISTANCE)");
        } else {
           [resistance, GVAR(vehicle_guer), "TUN_respawn_guerrila", QGVAR(contested_guer)] call FUNC(contested);
        };
    };

    if ( GVAR(status_civ) ) then {
        if (GVAR(vehicle_civ) == objNull) then {
            GVAR(status_civ) = false;
            ERROR("MSP Object Disapeared (CIVILIAN)");
        } else {
            [civilian, GVAR(vehicle_civ), "TUN_respawn_civilian", QGVAR(contested_civ)] call FUNC(contested);
        };
    };
}, GVAR(contested_check_interval), []] call CBA_fnc_addPerFrameHandler;


if (GVAR(report_enemies)) then {
    [{
        if ( GVAR(status_east) ) then {
            [east, GVAR(vehicle_east), QGVAR(contested_east)] call FUNC(report_enemies);
        };

        if ( GVAR(status_west) ) then {
            [west, GVAR(vehicle_west), QGVAR(contested_west)] call FUNC(report_enemies);
        };

        if ( GVAR(status_guer) ) then {
            [resistance, GVAR(vehicle_guer), QGVAR(contested_guer)] call FUNC(report_enemies);
        };

        if ( GVAR(status_civ) ) then {
            [civilian, GVAR(vehicle_civ), QGVAR(contested_civ)] call FUNC(report_enemies);
        };
    }, GVAR(report_enemies_interval), []] call CBA_fnc_addPerFrameHandler;
};