#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"cba_main","cba_xeh","cba_settings","ace_common","ace_main","A3_Data_F","A3_Structures_F_Mil_Flags"};
		author = "Tuntematon";
		authorUrl = "https://github.com/tuntematonjr/Tun-Respawn-System";
		VERSION_CONFIG;
	};
};

// configs go here
#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"

// information on the whole mod (only needed once)
class CfgMods {
	class PREFIX {
		dir = "@tun_respawn_system";
		name = "Tun Respawn System";
		
		author = "Tuntematon";					// probably shown somewhere in the mods menu, but probably ignored by CBA/HEMTT

		picture		 = "data\afilogo.paa";	   // Picture displayed from the expansions menu. Optimal size is 2048x1024
		hideName		= "false";			  // Hide the extension name in main menu and extension menu
		hidePicture	 = "false";			  // Hide the extension picture in the extension menu

		action		  = "https://github.com/tuntematonjr/Tun-Respawn-System"; // Website URL, that can accessed from the expansions menu 
		actionName	  = "Github";			  // label of button/tooltip in extension menu
		description	 = "It's unclear where this will show"; // Probably in context with action

		// Color used for DLC stripes and backgrounds (RGBA)
		dlcColor[] =
		{
			1,
			0.0,
			0.86,
			1
		};
	};
};
// Configs go here

