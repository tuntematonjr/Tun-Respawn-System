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
 * [] call tunres_MSP_fnc_startContestedChecks
 */
#include "script_component.hpp"

if (!isServer) then {};

[{cba_missiontime > GVAR(contestedCheckInterval)}, {
    [{
        if !(GVAR(disableContestedCheck)) then {
            
            {
                private _side = _x;
                private _mspDeployementStatus = GVAR(deployementStatus) get _side;
                if (_mspDeployementStatus) then {
                    [_side] call FUNC(contestedCheck);
                };
            } forEach [west,east,resistance,civilian];
        };
    }, GVAR(contestedCheckInterval), []] call CBA_fnc_addPerFrameHandler;

    //Report enemies loop thing
    if (GVAR(reportEnemiesEnabled)) then {
        [{
            private _hash = GVAR(contestedCheckHash);
            {
                private _side = _x;
                private _contestedStatus = GVAR(contestedStatus) get _side;
                private _mspStatus = GVAR(deployementStatus) get _side;
                if (_mspStatus) then {
                    private _enemyCount = (_hash get _side) select 0;
                    if (_enemyCount > 0 && !_contestedStatus) then {
                        private _whoToNotify = [_side, GVAR(reportEnemiesNotification)] call FUNC(whoToNotify);
                        if (count _whoToNotify > 0 ) then {
                            (localize "STR_tunres_MSP_FNC_enemies_near") remoteExecCall ["CBA_fnc_notify", _whoToNotify];
                        };
                    }; 
                };
            } forEach [west,east,resistance,civilian];
        }, GVAR(reportEnemiesInterval), []] call CBA_fnc_addPerFrameHandler;
    };
}] call CBA_fnc_waitUntilAndExecute;
