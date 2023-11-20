#include "script_component.hpp"

class CfgPatches
{
    class Tun_Main
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.94;
        requiredAddons[] = {"cba_main","cba_xeh","cba_settings","A3_Data_F","A3_Structures_F_Mil_Flags"};
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

class CfgVehicles
{
	class FlagCarrierCore;
	class FlagCarrier : FlagCarrierCore
	{
        class ACE_Actions {
            class Tun_respawn_BaseAceAction {
                displayName = "Main";
                condition = "true";
                statement = "true";
                position = "[0,-0.35,-2.4]";
                distance = 9;
            };
        };
	};
};