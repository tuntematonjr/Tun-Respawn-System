#include "script_component.hpp"

class CfgPatches
{
    class Tun_Main
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.94;
        requiredAddons[] = {"cba_main","cba_xeh","cba_settings"};
        author = "Tuntematon";
        authorUrl = "https://armafinland.fi/";
    };
};

class Extended_PreInit_EventHandlers {
    class Tun_Main {
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );
    };
};

class Extended_PostInit_EventHandlers {
    class Tun_Main {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};