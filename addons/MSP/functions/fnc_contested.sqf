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
 * [west, _msp, ] call Tun_MSP_fnc_contested
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"

params [["_side", nil, [west]], ["_msp", nil, [objNull]], ["_sidemarker", nil, [""]], ["_contested_variable_str", nil, [""]]];

_msp_pos = getpos _msp;

_contested_status = missionNamespace getVariable _contested_variable_str;

_areaunits_max = (allUnits inAreaArray [_msp_pos, GVAR(contested_radius_max), GVAR(contested_radius_max)]);
_friendlycount = {[_side, side _x] call BIS_fnc_sideIsFriendly} count _areaunits_max;
_enemycount_max = {[_side, side _x] call BIS_fnc_sideIsEnemy} count _areaunits_max;
_side = _msp getVariable QGVAR(side);

_enemycount_min = {[_side, side _x] call BIS_fnc_sideIsEnemy} count (_areaunits_max inAreaArray [_msp_pos, GVAR(contested_radius_min), GVAR(contested_radius_min)]);


//if there is more enemis in max range or even one in min range. Disable MSP
if ( _friendlycount < _enemycount_max || _enemycount_min > 0) then {
    if (!_contested_status) then {
        missionNamespace setVariable [_contested_variable_str, true, true];
        localize "STR_Tun_MSP_FNC_Contested_hint" remoteExecCall ["hint", _side];

        [_side, false] call FUNC(update_respawn_point);

        AAR_UPDATE(_msp,"Is contested", true);
    };
} else {
    if ( _contested_status ) then {
       missionNamespace setVariable [_contested_variable_str, false, true];
       localize "STR_Tun_MSP_FNC_secured_hint" remoteExecCall ["hint", _side];

       [_side, true, _msp_pos] call FUNC(update_respawn_point);

       AAR_UPDATE(_msp,"Is contested", false);
    };
};