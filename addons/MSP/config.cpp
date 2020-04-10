#include "script_component.hpp"

class CfgPatches
{
    class tun_msp
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.94;
        requiredAddons[] = {"A3_Modules_F","3DEN","cba_main","cba_xeh","cba_settings","Tun_Respawn","ace_interaction","ace_interact_menu"};
        author[] = {"Tuntematon"};
        authorUrl = "https://armafinland.fi/";
    };
};

class Extended_PostInit_EventHandlers {
    class tun_msp {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_PreInit_EventHandlers {
    class tun_msp {
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );
    };
};

class Extended_PreStart_EventHandlers {
    class tun_msp {
        init = QUOTE( call COMPILE_FILE(XEH_preStart) );
    };
};