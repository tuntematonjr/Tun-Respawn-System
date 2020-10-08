/*
 * Author: [Tuntematon]
 * [Description]
 * Force check contes status
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_MSP_fnc_force_contested_check
 */
#include "script_component.hpp"

private _delay = 1 / count allUnits;
[allUnits, _delay] call FUNC(contestedCheck);