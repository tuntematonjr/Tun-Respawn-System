#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"TunRes_main","tunres_Respawn","ace_interaction","ace_interact_menu"};
        authors[] = {"Tuntematon"}; // sub array of authors, considered for the specific addon, can be removed or left empty {}
        VERSION_CONFIG;
    };
};

// configs go here
#include "CfgEventHandlers.hpp"