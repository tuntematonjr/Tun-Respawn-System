/*
 * Author: [Tuntematon]
 * [Description]
 * Module fnc to create markers
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * The return true when done <BOOL>
 *
 * Example:
 * [Logic] call tunres_Respawn_fnc_module_waitingarea
 */
#include "script_component.hpp"

if (!isServer) exitWith { };

private _logic = param [0,objNull,[objNull]];

private _markername = _logic getVariable ["respawn_side","none"];

if (_markername isEqualTo "none") exitWith {  // Exit if no side
	private _errorText = localize "STR_tunres_Respawn_Module_WaitingArea_novalue";
    ERROR_MSG(_errorText); 
	false 
};

if (getMarkerColor _markername isEqualTo "") then {
	_marker = [_markername, getPos _logic, "icon", [1, 1], "PERSIST", "TYPE:", "Empty"] call CBA_fnc_createMarker;
	_marker setMarkerAlpha 0;
} else {
	private _errorText = format [(localize "STR_tunres_Respawn_Module_WaitingArea_MultipleMarkers"), _markername];
    ERROR_MSG(_errorText);
};

private _pos = getPos _logic;
private "_side";

switch (_markername) do {
	case "respawn_west": {
		_side = west;
		GVAR(flag_west) = "Flag_Blue_F" createVehicle _pos;
		[{ ADDON } , {
			[west] call FUNC(timer);
		}] call CBA_fnc_waitUntilAndExecute;
	};

	case "respawn_east": {
		_side = east;
		GVAR(flag_east) = "Flag_Red_F" createVehicle _pos;
		[{ ADDON }, {
			[east] call FUNC(timer);
		}] call CBA_fnc_waitUntilAndExecute;
	};

	case "respawn_guerrila": {
		_side = resistance;

		GVAR(flag_guerrila) = "Flag_Green_F" createVehicle _pos;
		[{ ADDON }, {
			[resistance] call FUNC(timer);
		}] call CBA_fnc_waitUntilAndExecute;
	};

	case "respawn_civilian": {
		_side = civilian;
		GVAR(flag_civilian) = "Flag_White_F" createVehicle _pos;
		[{ ADDON }, {
			[civilian] call FUNC(timer);
		}] call CBA_fnc_waitUntilAndExecute;
	};

	default {
		_side = sideLogic;
	}
};

if (_side == sideLogic) then {
	ERROR("Module has side logic for some fucking reason.")
};
GVAR(waitingArea) set [_side, [_markername, _logic, _pos]];
publicVariable QGVAR(waitingArea);
// Module function is executed by spawn command, so returned value is not necessary, but it's good practice.
true

