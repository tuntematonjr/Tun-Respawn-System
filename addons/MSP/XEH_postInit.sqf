#include "script_component.hpp"
if !(GVAR(enable) && Tun_respawn_enable) exitWith { INFO("TUN Mobile Respawn Point Disabled"); };
INFO("TUN Mobile Respawn Point Enabled");

[] call FUNC(add_EH);

if (isServer) then {
    [] call FUNC(pole_actions);
    [] call FUNC(init_contested);

};

if (hasInterface) then {
    [] call FUNC(ace_actions);
};