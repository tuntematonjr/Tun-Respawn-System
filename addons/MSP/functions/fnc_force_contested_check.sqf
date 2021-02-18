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

private _FilteredUnits = allunits select { side _x in [west,east,resistance,civilian] };
private _delay = 1 / count _FilteredUnits;
[_FilteredUnits, _delay] call FUNC(contestedCheck);