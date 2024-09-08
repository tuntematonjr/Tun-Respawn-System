#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

//Msp classnames
GVAR(classnamesHash) = createHashMap;

#include "initSettings.inc.sqf"

ADDON = true;