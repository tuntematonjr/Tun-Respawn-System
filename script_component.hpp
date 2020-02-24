#define COMPONENT Respawn
#define PREFIX Tun

#define MAJOR 1
#define MINOR 0
#define PATCHLVL 0
#define BUILD 24022020

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.56

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

