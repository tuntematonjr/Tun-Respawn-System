#include "script_component.hpp"

#undef PREP
#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction

PREP(ace_actions);
PREP(add_EH);
PREP(contestedCheck);
PREP(contestedSummary);
PREP(create_msp_props);
PREP(init_contested);
PREP(initate_msp_action);
PREP(report_enemies);
PREP(update_status);
PREP(briefingNotes);