#include "script_component.hpp"
//only executed on server

missionNamespace setVariable [QGVAR(disableContestedCheck), false, true];

//Contested status
GVAR(contestedStatusHash) = createHashMapFromArray FALSES_FOR_SIDES;
publicVariable QGVAR(contestedStatusHash);

//MSP status. If true, msp is setup
GVAR(deployementStatusHash) = createHashMapFromArray FALSES_FOR_SIDES;
publicVariable QGVAR(deployementStatusHash);

//MSP vehicle
GVAR(activeVehicleHash) = createHashMapFromArray [[west, objNull],[east, objNull],[resistance, objNull],[civilian, objNull]];
publicVariable QGVAR(activeVehicleHash);

//Contested stuff
GVAR(contestedCheckHash) = createHashMapFromArray [[west,[0,0,0]],[east,[0,0,0]],[resistance,[0,0,0]],[civilian,[0,0,0]]];


GVAR(contestHandlesHash) = createHashMap;
GVAR(contestCheckRunningHash) = createHashMapFromArray FALSES_FOR_SIDES;
