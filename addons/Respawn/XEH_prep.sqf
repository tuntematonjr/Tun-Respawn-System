#include "script_component.hpp"

#undef PREP
#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction

PREP(addGear);
PREP(blackscreen);
PREP(force_Respawn);
PREP(killed);
PREP(killJIP);
PREP(marker_update);
PREP(module_respawnpos);
PREP(module_waitingarea);
PREP(moveRespawns);
PREP(removegear);
PREP(savegear);
PREP(startSpectator);
PREP(ticketCountterPlayer);
PREP(ticketCountterSide);
PREP(timer);
PREP(waitingArea);