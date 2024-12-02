/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 
 *
 * Return Value:
 * 
 *
 * Example:
 * [] call tunres_main_fnc_updateSettings
 */
#include "script_component.hpp"

"Multiplayer" set3DENMissionAttribute ["Respawn",3];
"Multiplayer" set3DENMissionAttribute ["RespawnDelay",9999999];
"Multiplayer" set3DENMissionAttribute ["RespawnDialog",false];
"Multiplayer" set3DENMissionAttribute ["RespawnButton",1];
"Multiplayer" set3DENMissionAttribute ["RespawnTemplates",[]];

["Mission settings have been modified to basic respawn settings",0,9] call BIS_fnc_3DENNotification;