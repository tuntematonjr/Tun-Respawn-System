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


[{
    private _delay = GVAR(contested_check_interval) / (count allUnits + 1);
    [FUNC(contestedCheck), [allunits, _delay], _delay] call CBA_fnc_waitAndExecute;
}, GVAR(contested_check_interval), []] call CBA_fnc_addPerFrameHandler;


if (GVAR(report_enemies)) then {
    [{
        if ( GVAR(status_east) ) then {
            [GVAR(eastEnemyCount), GVAR(vehicle_east), east] call FUNC(report_enemies);
        };

        if ( GVAR(status_west) ) then {
            [GVAR(westEnemyCount), GVAR(vehicle_west), west] call FUNC(report_enemies);
        };

        if ( GVAR(status_guer) ) then {
            [GVAR(guerEnemyCount), GVAR(vehicle_guer), resistance] call FUNC(report_enemies);
        };

        if ( GVAR(status_civ) ) then {
            [GVAR(civEnemyCountMin), GVAR(vehicle_civ), civilian] call FUNC(report_enemies);
        };
    }, GVAR(report_enemies_interval), []] call CBA_fnc_addPerFrameHandler;
};

