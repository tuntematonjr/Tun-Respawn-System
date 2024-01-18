#include "script_component.hpp"
//only executed on server

private _emptyFalseArray = [[west,false],[east,false],[resistance,false],[civilian,false]];

missionNamespace setVariable [QGVAR(disableContestedCheck), false, true];

//Contested status
GVAR(contestedStatus) = createHashMapFromArray _emptyFalseArray;
publicVariable QGVAR(contestedStatus);

//MSP status. If true, msp is setup
GVAR(deployementStatus) = createHashMapFromArray _emptyFalseArray;
publicVariable QGVAR(deployementStatus);

//MSP vehicle
GVAR(activeVehicle) = createHashMapFromArray [[west, objNull],[east, objNull],[resistance, objNull],[civilian, objNull]];
publicVariable QGVAR(activeVehicle);

//Contested stuff
GVAR(contestedCheckHash) = createHashMapFromArray [[west,[0,0,0]],[east,[0,0,0]],[resistance,[0,0,0]],[civilian,[0,0,0]]];