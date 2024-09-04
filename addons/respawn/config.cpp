#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {QGVAR(moduleWaitingArea), QGVAR(moduleRespawnPoint), QGVAR(moduleTeleportPoint)};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"tunres_main","A3_Modules_F","3DEN","ace_interaction","ace_interact_menu"};
        authors[] = {"Tuntematon"}; // sub array of authors, considered for the specific addon, can be removed or left empty {}
        VERSION_CONFIG;
    };
};

class CfgFactionClasses
{
    class NO_CATEGORY;
    class tunres_Respawn : NO_CATEGORY
    {
        displayName = "$STR_tunres_Respawn_Module_category";
    };
};

// configs go here
#include "CfgEventHandlers.hpp"
#include "\a3\ui_f\hpp\definecommoncolors.inc"
#include "RscCommon.hpp"
#include "TP_dialog.hpp"
#include "CfgVehicles.hpp"

// class CfgRespawnTemplates {
//     class ADDON {
//         displayName = "Tun wave respawn";
//         //onPlayerKilled = QFUNC(respawnTemplate);
//         //onPlayerRespawn = QFUNC(respawnTemplate);
//         respawnTypes[] = {3};
//         respawnDelay = 99999;
//         respawnOnStart = 0;
//         respawnTemplates[] = {  };
//         disabledAI = 1;
//         respawn = 3;
//     };
// };