#include "script_component.hpp"

GVAR(respawnPointsHash) = createHashMap;
GVAR(playerTicektsHash) = createHashMap;

GVAR(disconnectedPlayersHash) = createHashMapFromArray EMPTY_ARRAY_FOR_SIDES;

//Respawn waiting area unit arrays
GVAR(waitingRespawnListHash) = createHashMapFromArray EMPTY_ARRAY_FOR_SIDES;
GVAR(waitingRespawnDelayedListHash) = createHashMapFromArray EMPTY_ARRAY_FOR_SIDES;

//Total respawn count (log stuff)
GVAR(totalRespawnCountHash) = createHashMapFromArray ZEROS_FOR_SIDES;