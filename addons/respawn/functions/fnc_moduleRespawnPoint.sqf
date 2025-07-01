/*
 * Author: [Tuntematon]
 * [Description]
 * Module fnc to mainbase respawn point
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * The return true when done <BOOL>
 *
 * Example:
 * [Logic] call tunres_Respawn_fnc_moduleRespawnPoint
 */
#include "script_component.hpp"

if (!isServer) exitWith { };

private _logic = param [0,objNull,[objNull]];

private _markername = _logic getVariable [QGVAR(respawnSide),"none"];
private _flagTexture = _logic getVariable [QGVAR(flagTexture),""];

private _pos = getPosASL _logic;
if (_markername isEqualTo "none") exitWith { hint LLSTRING(Module_RespanPos_novalue); false }; // Exit if no side
private _marker = "";

if (getMarkerColor _markername isEqualTo "") then {
	_marker = createMarker [_markername, _pos];
	_marker setMarkerType "Empty";

} else {
	private _errorText = LLSTRING(Module_RespanPos_MultipleMarkers);
	hint format [_errorText, _markername];
};

private ["_side", "_color"];
private _flag = objNull;

switch (_markername) do {
	case QGVAR(west): {
		_flag = "Flag_Blue_F" createVehicle _pos;
		_side = west;
		_color = "ColorWEST";
	};

	case QGVAR(east): {
		_flag = "Flag_Red_F" createVehicle _pos;
		_side = east;
		_color = "ColorEAST";
	};

	case QGVAR(resistance): {
		_flag = "Flag_Green_F" createVehicle _pos;
		_side = resistance;
		_color = "ColorGUER";
	};

	case QGVAR(civilian): {
		_flag = "Flag_White_F" createVehicle _pos;
		_side = civilian;
		_color = "ColorCIV";
	};
};

private _values = GVAR(flagPolesHash) get _side;
_values set [0, _flag];
GVAR(flagPolesHash) set [_side, _values];
publicVariable QGVAR(flagPolesHash);

//Set flag texure, if given texture exist
if (fileExists _flagTexture) then {
	_flag setFlagTexture _flagTexture;
};

GVAR(enabledSidesHash) set [_side, true];
publicVariable QGVAR(enabledSidesHash);

GVAR(respawnPointsHash) set [_side, [_markername, _pos]];
publicVariable QGVAR(respawnPointsHash);

[QGVAR(RespawnPosLocal), _pos, LLSTRING(RespawnPoint), "respawn_inf", _color, 1, 100] remoteExecCall [QFUNC(createLocalMarker), _side, true];
[QGVAR(MainBaseLocal), _pos, LLSTRING(MainBase), "mil_start", _color, 0, 100] remoteExecCall [QFUNC(createLocalMarker), _side, true];

[_flag] remoteExecCall [QFUNC(addActionsPlayer), _side, true];

// Module function is executed by spawn command, so returned value is not necessary, but it's good practice.
true
