#include "\z\ace\addons\main\script_macros.hpp"

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

//
#define MARKER_NAME_CONFIG(var1) QUOTE(DOUBLES(ADDON,var1))

#define MARKER_NAME(var1) FORMAT_2("%1_%2",QUOTE(ADDON),var1)

//AAR enabled check
#define AAR_IS_ENABLED !isnil "afi_aar2"
//AAR update macro
#define AAR_UPDATE(OBJ,VARNAME,VALUE) if ( AAR_IS_ENABLED ) then { [OBJ, VARNAME, VALUE] call afi_aar2_fnc_addcustomdata; }
//AAR event
#define AAR_EVENT(TEXT,INSTIGATOR,TARGET,POI) if ( AAR_IS_ENABLED ) then { if (isServer) then { [TEXT,INSTIGATOR,TARGET,POI] call afi_aar2_fnc_addCustomEvent;} else {[TEXT,INSTIGATOR,TARGET,POI] remoteExecCall ["afi_aar2_fnc_addCustomEvent", 2]} };
