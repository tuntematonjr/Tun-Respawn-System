/*
 * Author: [Tuntematon]
 * [Description]
 * Notify if ther is enemies inside max radius
 * Disable msp if there is more enemies than friendlies inside max range
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

private _FilteredUnits = [];
[{
    _FilteredUnits = allunits select { side _x in [west,east,resistance,civilian] };
    private _delay = GVAR(contested_check_interval) / (count _FilteredUnits + 1);
    [FUNC(contestedCheck), [_FilteredUnits, _delay], _delay] call CBA_fnc_waitAndExecute;
}, GVAR(contested_check_interval), []] call CBA_fnc_addPerFrameHandler;


if (GVAR(report_enemies)) then {
    [{
        if ( GVAR(status_east) ) then {
             private _status = (GVAR(enemyCountEast) <= GVAR(friendlyCountEast) && GVAR(enemyCountEast) > 0 );
            [_status, GVAR(vehicle_east), east] call FUNC(report_enemies);
        };

        if ( GVAR(status_west) ) then {
             private _status = (GVAR(enemyCountWest) <= GVAR(friendlyCountWest) && GVAR(enemyCountWest) > 0 );
            [_status, GVAR(vehicle_west), west] call FUNC(report_enemies);
        };

        if ( GVAR(status_guer) ) then {
            private _status = (GVAR(enemyCountGuer) <= GVAR(friendlyCountGuer) && GVAR(enemyCountGuer) > 0 );
            [_status, GVAR(vehicle_guer), resistance] call FUNC(report_enemies);
        };

        if ( GVAR(status_civ) ) then {
             private _status = (GVAR(enemyCountCiv) <= GVAR(friendlyCountCiv) && GVAR(enemyCountCiv) > 0 );
            [_status, GVAR(vehicle_civ), civilian] call FUNC(report_enemies);
        };
    }, GVAR(report_enemies_interval), []] call CBA_fnc_addPerFrameHandler;
};