#include "script_component.hpp"
#include "XEH_prep.sqf"

if (isServer) then {
    missionNamespace setVariable [QGVAR(disableContestedCheck), false, true];

    missionNamespace setVariable [QGVAR(contested_east), false, true];
    missionNamespace setVariable [QGVAR(contested_west), false, true];
    missionNamespace setVariable [QGVAR(contested_guer), false, true];
    missionNamespace setVariable [QGVAR(contested_civ), false, true];

    missionNamespace setVariable [QGVAR(status_east), false, true];
    missionNamespace setVariable [QGVAR(status_west), false, true];
    missionNamespace setVariable [QGVAR(status_guer), false, true];
    missionNamespace setVariable [QGVAR(status_civ), false, true];

    missionNamespace setVariable [QGVAR(vehicle_east), objNull, true];
    missionNamespace setVariable [QGVAR(vehicle_west), objNull, true];
    missionNamespace setVariable [QGVAR(vehicle_guer), objNull, true];
    missionNamespace setVariable [QGVAR(vehicle_civ), objNull, true];

    missionNamespace setVariable [QGVAR(nearUnitsEast), [], true];
    missionNamespace setVariable [QGVAR(nearUnitsEastMin), [], true];

    missionNamespace setVariable [QGVAR(nearUnitsWest), [], true];
    missionNamespace setVariable [QGVAR(nearUnitsWestMin), [], true];

    missionNamespace setVariable [QGVAR(nearUnitsGuer), [], true];
    missionNamespace setVariable [QGVAR(nearUnitsGuerMin), [], true];

    missionNamespace setVariable [QGVAR(nearUnitsCiv), [], true];
    missionNamespace setVariable [QGVAR(nearUnitsCivMin), [], true];

    missionNamespace setVariable [QGVAR(enemyCountEast), 0, true];
    missionNamespace setVariable [QGVAR(enemyCountMinEast), 0, true];
    missionNamespace setVariable [QGVAR(friendlyCountEast), 0, true];

    missionNamespace setVariable [QGVAR(enemyCountWest), 0, true];
    missionNamespace setVariable [QGVAR(enemyCountMinWest), 0, true];
    missionNamespace setVariable [QGVAR(friendlyCountWest), 0, true];

    missionNamespace setVariable [QGVAR(enemyCountGuer), 0, true];
    missionNamespace setVariable [QGVAR(enemyCountMinGuer), 0, true];
    missionNamespace setVariable [QGVAR(friendlyCountGuer), 0, true];

    missionNamespace setVariable [QGVAR(enemyCountCiv), 0, true];
    missionNamespace setVariable [QGVAR(enemyCountMinCiv), 0, true];
    missionNamespace setVariable [QGVAR(friendlyCountCiv), 0, true];

    GVAR(contestedCheckHash) = createHashMap;;
};