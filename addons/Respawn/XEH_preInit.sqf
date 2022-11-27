#include "script_component.hpp"
#include "XEH_prep.sqf"

//Remaining time for wave.
ISNILS(GVAR(wait_time_west),0);
ISNILS(GVAR(wait_time_east),0);
ISNILS(GVAR(wait_time_guer),0);
ISNILS(GVAR(wait_time_civ),0);

ISNILS(GVAR(totalRespawnCountWest),0);
ISNILS(GVAR(totalRespawnCountEast),0);
ISNILS(GVAR(totalRespawnCountGuer),0);
ISNILS(GVAR(totalRespawnCountCiv),0);

ISNILS(GVAR(allow_respawn_west),true);
ISNILS(GVAR(allow_respawn_east),true);
ISNILS(GVAR(allow_respawn_guer),true);
ISNILS(GVAR(allow_respawn_civ),true);

ISNILS(GVAR(waitingRespawnWest),[]);
ISNILS(GVAR(waitingRespawnEast),[]);
ISNILS(GVAR(waitingRespawnGuer),[]);
ISNILS(GVAR(waitingRespawnCiv),[]);

ISNILS(GVAR(waitingRespawnDelayedWest),[]);
ISNILS(GVAR(waitingRespawnDelayedEast),[]);
ISNILS(GVAR(waitingRespawnDelayedGuer),[]);
ISNILS(GVAR(waitingRespawnDelayedCiv),[]);

ISNILS(GVAR(disconnected_players),[]);

ISNILS(GVAR(timer_running),[]);
ISNILS(GVAR(teleportPoints),[]);

//allowed sides to spectate !WIP! Currentlu forced all
ISNILS(GVAR(spectate_west),true);
ISNILS(GVAR(spectate_east),true);
ISNILS(GVAR(spectate_independent),true);
ISNILS(GVAR(spectate_civilian),true);

ISNILS(GVAR(endRespawns),false);

if (isServer) then {
    GVAR(respawnPointsHash) = createHashMap
};