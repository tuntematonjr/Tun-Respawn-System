/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument <OBJECT>
 * 2: Multiple input types <STRING|ARRAY|CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE|STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: nil)
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * ["something", player] call TUN_Respawn_fnc_killJIP
 *
 * Public: [Yes/No]
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
			player setDammage 1;
		}, [], 1] call CBA_fnc_waitAndExecute;
	};
}] call CBA_fnc_waitUntilAndExecute;