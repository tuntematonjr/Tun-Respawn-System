#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

//Msp classnames
GVAR(classnamesHash) = createHashMap;

//reportEnemiesInterval 0 - reportEnemiesRange 1 - contestedRadiusMax 2 - contestedRadiusMin 3 - contestedCheckInterval 4 - reportEnemiesEnabled 5
GVAR(contestValuesHash) = createHashMapFromArray [[west,[0,0,0,0,0,false]],[east,[0,0,0,0,0,false]],[resistance,[0,0,0,0,0,false]],[civilian,[0,0,0,0,0,false]]];

#include "initSettings.inc.sqf"

ADDON = true;
