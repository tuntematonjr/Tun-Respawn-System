#include "script_component.hpp"

#undef PREP
#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction

PREP(ace_actions);
PREP(add_EH);
PREP(contested);
PREP(create_msp_props);
PREP(force_contested_check);
PREP(init_contested);
PREP(initate_msp_action);
PREP(move_player);
PREP(pole_actions);
PREP(report_enemies);
PREP(update_respawn_point);
PREP(update_status);


