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
 * [Logic] call Tun_Respawn_fnc_module_respawnpos
 */
#include "script_component.hpp"

if (!isServer) exitWith { };

private _logic = param [0,objNull,[objNull]];

private  _markername = _logic getVariable ["respawn_side","none"];
private _pos = getPos _logic;
if (_markername isEqualTo "none") exitWith { hint "STR_Tun_Respawn_Module_RespanPos_novalue" call BIS_fnc_localize; false }; // Exit if no side
private _marker = "";

if (getMarkerColor _markername isEqualTo "") then {
	_marker = createMarker [_markername, _pos];
	_marker setMarkerType "Empty";

} else {
	hint format [("STR_Tun_Respawn_Module_RespanPos_MultipleMarkers" call BIS_fnc_localize), _markername];
};

private ["_side", "_color"];
private _flag = objNull;

switch (_markername) do {
	case "tun_respawn_west": {	
		missionNamespace setVariable [QGVAR(enabled_west),true, true];
		_flag = "Flag_Blue_F" createVehicle _pos;
		GVAR(flag_west_spawn) = _flag;
		publicVariable QGVAR(flag_west_spawn);
		_side = west;
		_color = "ColorWEST";
	};

	case "tun_respawn_east": {
		missionNamespace setVariable [QGVAR(enabled_east),true, true];
		_flag = "Flag_Red_F" createVehicle _pos;
		GVAR(flag_east_spawn) = _flag;
		publicVariable QGVAR(flag_east_spawn);
		_side = east;
		_color = "ColorEAST";
	};

	case "tun_respawn_guerrila": {
		missionNamespace setVariable [QGVAR(enabled_guer),true, true];
		_flag = "Flag_Green_F" createVehicle _pos;
		GVAR(flag_guerrila_spawn) = _flag;
		publicVariable QGVAR(flag_guerrila_spawn);
		_side = resistance;
		_color = "ColorGUER";
	};

	case "tun_respawn_civilian": {
		missionNamespace setVariable [QGVAR(enabled_civ),true, true];
		_flag = "Flag_White_F" createVehicle _pos;
		GVAR(flag_civilian_spawn) = _flag;
		publicVariable QGVAR(flag_civilian_spawn);
		_side = civilian;
		_color = "ColorCIV";

	};
};

GVAR(respawnPointsHash) set [_side, [_markername, _pos]];
["RespawnPosLocal", _pos, "Respawn", "respawn_inf", _color, 1] remoteExecCall [QFUNC(createLocalMarker), _side, true];
["MainBaseLocal", _pos, "Main Base", "mil_start", _color] remoteExecCall [QFUNC(createLocalMarker), _side, true];

[_flag] remoteExecCall [QFUNC(addActionsPlayer), _side, true];

// Module function is executed by spawn command, so returned value is not necessary, but it's good practice.
true