/*
 * Author: [Tuntematon]
 * [Description]
 * Initate ace action from MSP. Either to setup or pack it.
 *
 * Arguments:
 * 0: MSP vehicle <OBJECT>
 * 1: True: Setup MSP. False: Pack msp <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [msp, true] call tunres_MSP_fnc_startUpdateDeployementStatus
 */
#include "script_component.hpp"

params ["_target", "_setup"];
private ["_text", "_time", "_conditio"];

if (_setup) then {
    [_target] call FUNC(createContestZoneMarkers);
    _text = localize "STR_tunres_MSP_fnc_startUpdateDeployementStatus_setting";
    _conditio = {
                    private _msp = (_args select 0);
                    driver _msp isEqualTo player &&
                    alive _msp &&
                    !(GVAR(deployementStatus) get playerSide)
                };
    _time = GVAR(progresbarTimeSetup);
} else {
    _text = localize "STR_tunres_MSP_fnc_startUpdateDeployementStatus_packing";
    _conditio = {
                    private _msp = (_args select 0);
                    driver _msp isEqualTo player &&
                    alive _msp &&
                    (GVAR(deployementStatus) get playerSide)
                };
    _time = GVAR(progresbarTimePack);
};

private _code = {
                    _args call FUNC(updateDeployementStatus);
                    openMap false;
                };

[_time, [_target, _setup], _code, {hint "Aborted!";}, _text, _conditio, ["notOnMap","isnotinside"]] call ace_common_fnc_progressBar;