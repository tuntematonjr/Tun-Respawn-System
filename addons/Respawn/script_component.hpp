#define COMPONENT respawn
#define PREFIX tun

#define MAJOR 1
#define MINOR 1
#define PATCHLVL 0
#define BUILD 19042020

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.94

/*
	#define DEBUG_ENABLED_SYS_MAIN
*/

#define DEBUG_MODE_FULL

#ifdef DEBUG_ENABLED_MAIN
	#define DEBUG_MODE_FULL
#endif

#include "\x\cba\addons\main\script_macros_common.hpp"

// Default versioning level
#define DEFAULT_VERSIONING_LEVEL 2




#define AAR_UPDATE(OBJ,VARNAME,VALUE) if (missionNamespace getVariable ["afi_aar2 ", false]) then { [OBJ, VARNAME, VALUE] call afi_aar2_fnc_addcustomdata; };