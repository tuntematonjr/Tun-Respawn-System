#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

//cba_missiontime time when next wave happens.
GVAR(nextWaveTimesHash) = createHashMapFromArray ZEROS_FOR_SIDES;

//Respawn wave lenght times
GVAR(waveLenghtTimesHash) = createHashMap;

//Tickets
GVAR(ticketsHash) = createHashMap;

//Waiting area stuff
GVAR(waitingAreaHash) = createHashMap;

//Which side has respawn system started
GVAR(enabledSidesHash) = createHashMapFromArray FALSES_FOR_SIDES;

//Allow respawn for each side
GVAR(allowRespawnHash) = createHashMapFromArray TRUES_FOR_SIDES;

GVAR(timerRunningHash) = createHashMapFromArray FALSES_FOR_SIDES;
ISNILS(GVAR(teleportPoints),[]);

//allowed sides to spectate 
GVAR(allowedSpectateSidesHash) = createHashMapFromArray EMPTY_ARRAY_FOR_SIDES;
GVAR(allowedSpectateCameraModes) = [];

//flag poles [mainbase,waitingrea]
GVAR(flagPolesHash) = createHashMapFromArray [[west,[objNull,objNull]],[east,[objNull,objNull]],[resistance,[objNull,objNull]],[civilian,[objNull,objNull]]];

#include "initSettings.inc.sqf"

ADDON = true;