/*
 * Author: [Tuntematon]
 * [Description]
 * Create action to teleport to MSP at main base flagpole AKA original spawn poin
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_MSP_fnc_pole_actions
 */
#include "script_component.hpp"

_action = {
    [true] call FUNC(move_player);
};

if (tun_respawn_enabled_west) then {
    _condition = format ["%1 && !%2", QGVAR(status_west), QGVAR(contested_west)];
    [tun_respawn_flag_west_spawn, [localize "STR_Tun_MSP_Move_To_MSP_Action", _action, [], 10, true, true, "", _condition]] remoteExecCall ["addAction", west, true];
};

if (tun_respawn_enabled_east) then {
    _condition = format ["%1 && !%2", QGVAR(status_east), QGVAR(contested_east)];
    [tun_respawn_flag_east_spawn, [localize "STR_Tun_MSP_Move_To_MSP_Action", _action, [], 10, true, true, "", _condition]] remoteExecCall ["addAction", east, true];
};

if (tun_respawn_enabled_guer) then {
    _condition = format ["%1 && !%2", QGVAR(status_guer), QGVAR(contested_guer)];
    [tun_respawn_flag_guerrila_spawn, [localize "STR_Tun_MSP_Move_To_MSP_Action", _action, [], 10, true, true, "", _condition]] remoteExecCall ["addAction", resistance, true];
};

if (tun_respawn_enabled_civ) then {
    _condition = format ["%1 && !%2", QGVAR(status_civ), QGVAR(contested_civ)];
    [tun_respawn_flag_civilian_spawn, [localize "STR_Tun_MSP_Move_To_MSP_Action", _action, [], 10, true, true, "", _condition]] remoteExecCall ["addAction", civilian, true];
};