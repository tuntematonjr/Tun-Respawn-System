#include "script_component.hpp"

GVAR(respawnPointsHash) = createHashMap;
GVAR(playerTicektsHash) = createHashMap;

//Respawn waiting area unit arrays
GVAR(waitingRespawnListHash) = createHashMapFromArray EMPTY_ARRAY_FOR_SIDES;
GVAR(waitingRespawnDelayedListHash) = createHashMapFromArray EMPTY_ARRAY_FOR_SIDES;

//Total respawn count (log stuff)
GVAR(totalRespawnCountHash) = createHashMapFromArray ZEROS_FOR_SIDES;

//flag poles [mainbase,waitingrea]
GVAR(flagPolesHash) = createHashMapFromArray [[west,[objNull,objNull]],[east,[objNull,objNull]],[resistance,[objNull,objNull]],[civilian,[objNull,objNull]]];

//waiting respawn counts
GVAR(waitingRespawnCountHash) = createHashMapFromArray [[west,[0,0]],[east,[0,0]],[resistance,[0,0]],[civilian,[0,0]]];
publicVariable QGVAR(waitingRespawnCountHash);