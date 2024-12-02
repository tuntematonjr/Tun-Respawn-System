#define MAINPREFIX x
#define PREFIX tunres

#include "script_version.hpp"

#define VERSION MAJOR.MINOR
#define VERSION_AR MAJOR,MINOR,PATCH,BUILD

#define REQUIRED_VERSION 2.18

#ifdef COMPONENT_BEAUTIFIED
	#define COMPONENT_NAME QUOTE(tunres - COMPONENT_BEAUTIFIED)
#else
	#define COMPONENT_NAME QUOTE(tunres - COMPONENT)
#endif

//This forces debug on everything.
// #define DEBUG_ENABLED_MAIN