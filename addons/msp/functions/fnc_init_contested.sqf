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
 * [] call tunres_MSP_fnc_init_contested
 */
#include "script_component.hpp"

[{cba_missiontime > GVAR(contested_check_interval)}, {
    [{
        if !(GVAR(disableContestedCheck)) then {
            [] call FUNC(contestedCheck);
        };
        
    }, GVAR(contested_check_interval), []] call CBA_fnc_addPerFrameHandler;

    if (GVAR(report_enemies)) then {
        [{
            private _hash = GVAR(contestedCheckHash);
            {
                _x params ["_side", "_isContested", "_status"];
                if (_status) then {
                    private _enemyCount = (_hash get _side) select 0;
                    if (_enemyCount > 0 && !_isContested) then {
                        private _whoToNotify = [_side] call FUNC(whoToNotify);
                        if (count _whoToNotify > 0 ) then {
                            (localize "STR_tunres_MSP_FNC_enemies_near") remoteExecCall ["CBA_fnc_notify", _whoToNotify];
                        };
                    }; 
                };

            } forEach [
                [west, GVAR(contested_west), GVAR(status_west)],
                [east, GVAR(contested_east), GVAR(contested_east)],
                [resistance, GVAR(contested_east), GVAR(contested_east)],
                [civilian, GVAR(contested_east), GVAR(contested_east)]];
        }, GVAR(report_enemies_interval), []] call CBA_fnc_addPerFrameHandler;
    };
}] call CBA_fnc_waitUntilAndExecute;