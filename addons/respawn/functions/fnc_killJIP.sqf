/*
 * Author: [Tuntematon]
 * [Description]
 * Kill jip after time. Set in CBA settings
 *
 * Arguments:
 * Nones
 *
 * Return Value:
 * Nones
 *
 * Example:
 * [] call tunres_Respawn_fnc_killJIP
 */
#include "script_component.hpp"
if (!hasInterface) exitWith { };

[{!isNull player}, {
	if (cba_missiontime > (GVAR(killJIP_time) * 60) && GVAR(killJIP)) then {
		[{
			[player, "Respawn", {
				params ["_newObject","_oldObject"];
				deleteVehicle _oldObject;
				player removeEventHandler ["Respawn", _thisID];
			}] call CBA_fnc_addBISEventHandler;


			player allowDamage true;
			player setDamage 1;
		}, [], 1] call CBA_fnc_waitAndExecute;
	};
}] call CBA_fnc_waitUntilAndExecute;