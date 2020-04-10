/*
 * Author: [Tuntematon]
 * [Description]
 * Force check contes status
 *
 * Arguments:
 * Side
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_MSP_fnc_force_contested_check
 */
#include "script_component.hpp"
params ["_side"];

switch (_side) do {

    case east: {
        [east, GVAR(vehicle_east), "TUN_respawn_east", QGVAR(contested_east)] call FUNC(contested);
    };

    case west: {
        [west, GVAR(vehicle_west), "TUN_respawn_west", QGVAR(contested_west)] call FUNC(contested);
    };

    case resistance: {
        [resistance, GVAR(vehicle_guer), "TUN_respawn_guerrila", QGVAR(contested_guer)] call FUNC(contested);
    };

    case civilian: {
        [civilian, GVAR(vehicle_civ), "TUN_respawn_civilian", QGVAR(contested_civ)] call FUNC(contested);
    };

    default
    {
        /* STATEMENT */
    };
};