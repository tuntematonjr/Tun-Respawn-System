/*
 * Author: [Tuntematon]
 * [Description]
 * Final summary for contested stuff
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_MSP_fnc_contestedSummary
 */
#include "script_component.hpp"

if ( GVAR(status_east) ) then {
	if (GVAR(vehicle_east) == objNull) then {
		GVAR(status_east) = false;
		ERROR("MSP Object Disapeared (EAST)");
	} else {

		AAR_UPDATE(GVAR(vehicle_east),"Enemy Count", GVAR(eastEnemyCount));
		AAR_UPDATE(GVAR(vehicle_east),"Enemy Count Min", GVAR(eastEnemyCountMin));
		AAR_UPDATE(GVAR(vehicle_east),"Friendly Count", GVAR(eastFriendlyCount));

		//if there is more enemis in max range or even one in min range. Disable MSP
		if ( GVAR(eastEnemyCount) > GVAR(eastFriendlyCount) || GVAR(eastEnemyCountMin) > 0 ) then {

			if (!GVAR(status_east)) then {
				missionNamespace setVariable [QGVAR(status_east), true, true];
				localize "STR_Tun_MSP_FNC_Contested_hint" remoteExecCall ["hint", east];

				[east, false] call TUN_respawn_update_respawn_point;

				AAR_UPDATE(GVAR(vehicle_east),"Is contested", true);
			};
		} else {
			if ( GVAR(status_east) ) then {
				missionNamespace setVariable [QGVAR(status_east), false, true];
				localize "STR_Tun_MSP_FNC_secured_hint" remoteExecCall ["hint", east];

				[east, true, (getPos GVAR(vehicle_east)) ] call TUN_respawn_update_respawn_point;

				AAR_UPDATE(GVAR(vehicle_east),"Is contested", false);
			};
		};
	};
};

if ( GVAR(status_west) ) then {
	if (GVAR(vehicle_west) == objNull) then {
		GVAR(status_west) = false;
		ERROR("MSP Object Disapeared (WEST)");
	} else {

		AAR_UPDATE(GVAR(vehicle_east),"Enemy Count", GVAR(westEnemyCount));
		AAR_UPDATE(GVAR(vehicle_east),"Enemy Count Min", GVAR(westEnemyCountMin));
		AAR_UPDATE(GVAR(vehicle_east),"Friendly Count", GVAR(westFriendlyCount));

		//if there is more enemis in max range or even one in min range. Disable MSP
		if ( GVAR(westEnemyCount) > GVAR(westFriendlyCount) || GVAR(westEnemyCountMin) > 0 ) then {

			if (!GVAR(status_west)) then {
				missionNamespace setVariable [QGVAR(status_west), true, true];
				localize "STR_Tun_MSP_FNC_Contested_hint" remoteExecCall ["hint", west];

				[west, false] call TUN_respawn_update_respawn_point;

				AAR_UPDATE(GVAR(vehicle_west),"Is contested", true);
			};
		} else {
			if ( GVAR(status_west) ) then {
				missionNamespace setVariable [QGVAR(status_west), false, true];
				localize "STR_Tun_MSP_FNC_secured_hint" remoteExecCall ["hint", west];

				[west, true, (getPos GVAR(vehicle_west)) ] call TUN_respawn_update_respawn_point;

				AAR_UPDATE(GVAR(vehicle_west),"Is contested", false);
			};
		};
	};
};

if ( GVAR(status_guer) ) then {
	if (GVAR(vehicle_guer) == objNull) then {
		GVAR(status_guer) = false;
		ERROR("MSP Object Disapeared (RESISTANCE)");
	} else {

		AAR_UPDATE(GVAR(vehicle_east),"Enemy Count", GVAR(guerEnemyCount));
		AAR_UPDATE(GVAR(vehicle_east),"Enemy Count Min", GVAR(guerEnemyCountMin));
		AAR_UPDATE(GVAR(vehicle_east),"Friendly Count", GVAR(guerFriendlyCount));

		//if there is more enemis in max range or even one in min range. Disable MSP
		if ( GVAR(guerEnemyCount) > GVAR(guerFriendlyCount) || GVAR(guerEnemyCountMin) > 0 ) then {

			if (!GVAR(status_guer)) then {
				missionNamespace setVariable [QGVAR(status_guer), true, true];
				localize "STR_Tun_MSP_FNC_Contested_hint" remoteExecCall ["hint", resistance];

				[resistance, false] call TUN_respawn_update_respawn_point;

				AAR_UPDATE(GVAR(vehicle_guer),"Is contested", true);
			};
		} else {
			if ( GVAR(status_guer) ) then {
				missionNamespace setVariable [QGVAR(status_guer), false, true];
				localize "STR_Tun_MSP_FNC_secured_hint" remoteExecCall ["hint", resistance];

				[resistance, true, (getPos GVAR(vehicle_guer)) ] call TUN_respawn_update_respawn_point;

				AAR_UPDATE(GVAR(vehicle_guer),"Is contested", false);
			};
		};
	};
};

if ( GVAR(status_civ) ) then {
	if (GVAR(vehicle_civ) == objNull) then {
		GVAR(status_civ) = false;
		ERROR("MSP Object Disapeared (CIVILIAN)");
	} else {

		AAR_UPDATE(GVAR(vehicle_east),"Enemy Count", GVAR(civEnemyCount));
		AAR_UPDATE(GVAR(vehicle_east),"Enemy Count Min", GVAR(civEnemyCountMin));
		AAR_UPDATE(GVAR(vehicle_east),"Friendly Count", GVAR(civFriendlyCount));

		//if there is more enemis in max range or even one in min range. Disable MSP
		if ( GVAR(civEnemyCount) > GVAR(civFriendlyCount) || GVAR(civEnemyCountMin) > 0 ) then {

			if (!GVAR(status_civ)) then {
				missionNamespace setVariable [QGVAR(status_civ), true, true];
				localize "STR_Tun_MSP_FNC_Contested_hint" remoteExecCall ["hint", civilian];

				[civilian, false] call TUN_respawn_update_respawn_point;

				AAR_UPDATE(GVAR(vehicle_civ),"Is contested", true);
			};
		} else {
			if ( GVAR(status_civ) ) then {
				missionNamespace setVariable [QGVAR(status_civ), false, true];
				localize "STR_Tun_MSP_FNC_secured_hint" remoteExecCall ["hint", civilian];

				[civilian, true, (getPos GVAR(vehicle_civ)) ] call TUN_respawn_update_respawn_point;

				AAR_UPDATE(GVAR(vehicle_civ),"Is contested", false);
			};
		};
	};
};