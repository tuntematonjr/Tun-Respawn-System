/*
 * Author: [Tuntematon]
 * [Description]
 * Module fnc to wainting area point
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * The return true when done <BOOL>
 *
 * Example:
 * [Logic] call tunres_Respawn_fnc_moduleWaitingArea
 */
#include "script_component.hpp"

if (!isServer) exitWith { };

private _logic = param [0,objNull,[objNull]];

private _markername = _logic getVariable ["respawn_side","none"];
private _flagTexture = _logic getVariable ["flag_texture",""];

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
private _flag = objNull;
private _side = nil;

switch (_markername) do {
	case "respawn_west": {
		_side = west;
		_flag = "Flag_Blue_F" createVehicle _pos;
	};

	case "respawn_east": {
		_side = east;
		_flag = "Flag_Red_F" createVehicle _pos;
	};

	case "respawn_guerrila": {
		_side = resistance;
		_flag = "Flag_Green_F" createVehicle _pos;
	};

	case "respawn_civilian": {
		_side = civilian;
		_flag = "Flag_White_F" createVehicle _pos;
	};

	default {
		_side = sideLogic;
	}
};

if (_side isEqualTo sideLogic) then {
	ERROR("Module has side logic for some fucking reason.")
};

//Set flag texure, if given texture exist
if (fileExists _flagTexture) then {
	_flag setFlagTexture _flagTexture;
};

//Start timer for this side
[{ ADDON }, {
	[_this] call FUNC(timer);
}, _side] call CBA_fnc_waitUntilAndExecute;


private _values = GVAR(flagPoles) get _side;
_values set [1, _flag];
GVAR(flagPoles) set [_side, _values];
publicVariable QGVAR(flagPoles);

GVAR(waitingArea) set [_side, [_markername, _logic, _pos]];
publicVariable QGVAR(waitingArea);
// Module function is executed by spawn command, so returned value is not necessary, but it's good practice.
true