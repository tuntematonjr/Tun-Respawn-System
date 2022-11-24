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

if (_markername == "none") exitWith { hint "STR_Tun_Respawn_Module_RespanPos_novalue" call BIS_fnc_localize; false }; // Exit if no side
private _marker = "";
private _marker1 = "";

if (getMarkerColor _markername == "") then {
	_marker = [_markername, getPos _logic, "icon", [1, 1], "PERSIST", "TYPE:", "respawn_inf"] call CBA_fnc_createMarker;
	_marker setMarkerAlpha 0;
	_marker setMarkerText "Respawn";

	_marker1 = [format["%1_mainbase",_markername], getPos _logic, "icon", [1, 1], "PERSIST", "TYPE:", "mil_start"] call CBA_fnc_createMarker;
	_marker1 setMarkerAlpha 0;
	_marker1 setMarkerText "Main Base";
} else {
	hint format [("STR_Tun_Respawn_Module_RespanPos_MultipleMarkers" call BIS_fnc_localize), _markername];
};

private _pos = getPos _logic;
private ["_side"];
private _flag = objNull;

switch (_markername) do {
	case "tun_respawn_west": {
		_markername setMarkerColor "ColorWEST";
		_marker1 setMarkerColor "ColorWEST";
		missionNamespace setVariable [QGVAR(respawnpos_west), [_markername, _logic, _pos], true];
		missionNamespace setVariable [QGVAR(enabled_west),true, true];
		_flag = "Flag_Blue_F" createVehicle _pos;
		GVAR(flag_west_spawn) = _flag;
		publicVariable QGVAR(flag_west_spawn);
		_side = west;
	};

	case "tun_respawn_east": {
		_markername setMarkerColor "ColorEAST";
		_marker1 setMarkerColor "ColorEAST";
		missionNamespace setVariable [QGVAR(respawnpos_east), [_markername, _logic, _pos], true];
		missionNamespace setVariable [QGVAR(enabled_east),true, true];
		_flag = "Flag_Red_F" createVehicle _pos;
		GVAR(flag_east_spawn) = _flag;
		publicVariable QGVAR(flag_east_spawn);
		_side = east;
	};

	case "tun_respawn_guerrila": {
		_markername setMarkerColor "ColorGUER";
		_marker1 setMarkerColor "ColorGUER";
		missionNamespace setVariable [QGVAR(respawnpos_guer), [_markername, _logic, _pos], true];
		missionNamespace setVariable [QGVAR(enabled_guer),true, true];
		_flag = "Flag_Green_F" createVehicle _pos;
		GVAR(flag_guerrila_spawn) = _flag;
		publicVariable QGVAR(flag_guerrila_spawn);
		_side = resistance;
	};

	case "tun_respawn_civilian": {
		_markername setMarkerColor "ColorCIV";
		_marker1 setMarkerColor "ColorCIV";
		missionNamespace setVariable [QGVAR(respawnpos_civ), [_markername, _logic, _pos], true];
		missionNamespace setVariable [QGVAR(enabled_civ),true, true];
		_flag = "Flag_White_F" createVehicle _pos;
		GVAR(flag_civilian_spawn) = _flag;
		publicVariable QGVAR(flag_civilian_spawn);
		_side = civilian;
	};
};

//Create base ace action for flagpoles
[_flag] remoteExecCall [QFUNC(createFlagActionBase), _side, true];

// Add tp action
private _conditio =  "count (missionNamespace getVariable ['tun_respawn_teleportPoints', []]) > 1" ;
[_flag, "true", "STR_Tun_Respawn_MainBaseText" call BIS_fnc_localize, false, nil, [_side], true, _conditio, false, nil, ["Tun_baseAction"]] remoteExecCall [QFUNC(addCustomTeleporter), _side, true];


if (GVAR(allowCheckTicketsBase)) then {
	[_flag, true, nil, ["Tun_baseAction"]] remoteExecCall [QFUNC(addCheckTicketCountAction), _side, true];
};

// Module function is executed by spawn command, so returned value is not necessary, but it's good practice.
true