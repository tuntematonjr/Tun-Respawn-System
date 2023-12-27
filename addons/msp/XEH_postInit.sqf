#include "script_component.hpp"

if !(GVAR(enable)) exitWith { INFO("TUN Mobile Respawn Point Disabled"); };
INFO("TUN Mobile Respawn Point Enabled");

[] call FUNC(add_EH);