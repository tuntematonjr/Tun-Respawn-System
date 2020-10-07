/*
 * Author: [Tuntematon]
 * [Description]
 * Notify if ther is enemies inside max radius
 * Disable MPS if there is more enemies than friendlies inside max range
 * Disable MSP if there is even one enemy in min range
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
 * ["something", player] call Tun_MSP_fnc_imanexample
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"


params ["_count", "_msp", "_side"];

//Notify if enemies near
if ( _count > 0 ) then {
    localize "STR_Tun_MSP_FNC_enemies_near" remoteExecCall ["hint", _side];

    if (_msp getvariable [QGVAR(enemies_near), false]) then {
    	_msp setVariable [QGVAR(enemies_near), true, true];
		AAR_UPDATE(_msp,"Enemies near", true);
    };
} else {
	if (_msp getvariable [QGVAR(enemies_near), true]) then {
		_msp setVariable [QGVAR(enemies_near), false, true];
		AAR_UPDATE(_msp,"Enemies near", false);
	};
};



