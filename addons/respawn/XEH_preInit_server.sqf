#include "script_component.hpp"

GVAR(respawnPointsHash) = createHashMap;

GVAR(disconnectedPlayers) = createHashMapFromArray EMPTY_ARRAY_FOR_SIDES;

//Respawn waiting area unit arrays
GVAR(waitingRespawnList) = createHashMapFromArray EMPTY_ARRAY_FOR_SIDES;
GVAR(waitingRespawnDelayedList) = createHashMapFromArray EMPTY_ARRAY_FOR_SIDES;

//Total respawn count (log stuff)
GVAR(totalRespawnCount) = createHashMapFromArray ZEROS_FOR_SIDES;