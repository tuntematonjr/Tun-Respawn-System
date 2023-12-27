/*
 * Author: [Tuntematon]
 * [Description]
 * Create props around MSP. This is placeholder for now.
 *
 * Arguments:
 * 0: MSP object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_msp] call tunres_MSP_fnc_create_msp_props
 */
#include "script_component.hpp"

params ["_msp"];

//todo give user ability to chose what props will be added.

_net = "CamoNet_BLUFOR_open_F" createVehicle [0,0,0];
_net attachTo [_msp,[0,0,0]];
_net setDir 90;
_net setPos getPos _net;
_msp setVariable [QGVAR(objects), [_net], true];