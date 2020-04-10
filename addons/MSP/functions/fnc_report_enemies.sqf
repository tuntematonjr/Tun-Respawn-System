/*
 * Author: [Tuntematon]
 * [Description]
 * Notify if ther is enemies inside max radius
 * Disable MPS if there is more enemies than friendlies inside max range
 * Disable MSP if there is even one enemy in min range
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument <OBJECT>
 * 2: Multiple input types <STRING|ARRAY|CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE|STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: nil)
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["something", player] call Tun_MSP_fnc_imanexample
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"


params ["_side", "_msp", "_contested_variable_str"];
_msp_pos = getpos _msp;

_contested_status = missionNamespace getVariable _contested_variable_str;

_areaunits_max = (allUnits inAreaArray [_msp_pos, GVAR(report_enemies_range), GVAR(report_enemies_range)]);
_enemycount_max = {[_side, side _x] call BIS_fnc_sideIsEnemy} count _areaunits_max;

//Notify if enemies near
if (!(_contested_status) && {_enemycount_max > 0}) then {
    localize "STR_Tun_MSP_FNC_enemies_near" remoteExecCall ["hint", _side];
};
