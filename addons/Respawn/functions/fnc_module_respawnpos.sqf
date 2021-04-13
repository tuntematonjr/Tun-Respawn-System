/*
 * Author: [Tuntematon]
 * [Description]
 * Module fnc to create markers
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [_logic] call Tun_Respawn_fnc_module_respawnpos
 */
#include "script_component.hpp"

if (!isServer) exitWith { };

private _logic = param [0,objNull,[objNull]];

private  _markername = _logic getVariable ["respawn_side","none"];

if (_markername == "none") exitWith { hint "STR_Tun_Respawn_Module_RespanPos_novalue" call BIS_fnc_localize; false }; // Exit if no side


if (getMarkerColor _markername == "") then {
	_marker = [_markername, getPos _logic, "icon", [1, 1], "PERSIST", "TYPE:", "respawn_inf"] call CBA_fnc_createMarker;
	_marker setMarkerAlpha 0;
	_marker setMarkerText "Respawn";
} else {
	hint format [("STR_Tun_Respawn_Module_RespanPos_MultipleMarkers" call BIS_fnc_localize), _markername];
};

private _pos = getPos _logic;
private ["_side"];
private _flag = objNull;

switch (_markername) do {
	case "tun_respawn_west": {
		_markername setMarkerColor "ColorWEST";
		missionNamespace setVariable [QGVAR(respawnpos_west), [_markername, _logic, _pos], true];
		missionNamespace setVariable [QGVAR(enabled_west),true, true];
		_flag = "Flag_Blue_F" createVehicle _pos;
		GVAR(flag_west_spawn) = _flag;
		_side = west;
	};

	case "tun_respawn_east": {
		_markername setMarkerColor "ColorEAST";
		missionNamespace setVariable [QGVAR(respawnpos_east), [_markername, _logic, _pos], true];
		missionNamespace setVariable [QGVAR(enabled_east),true, true];
		_flag = "Flag_Red_F" createVehicle _pos;
		GVAR(flag_east_spawn) = _flag;
		_side = east;
	};

	case "tun_respawn_guerrila": {
		_markername setMarkerColor "ColorGUER";
		missionNamespace setVariable [QGVAR(respawnpos_guer), [_markername, _logic, _pos], true];
		missionNamespace setVariable [QGVAR(enabled_guer),true, true];
		_flag = "Flag_Green_F" createVehicle _pos;
		GVAR(flag_guerrila_spawn) = _flag;
		_side = resistance;
	};

	case "tun_respawn_civilian": {
		_markername setMarkerColor "ColorCIV";
		missionNamespace setVariable [QGVAR(respawnpos_civ), [_markername, _logic, _pos], true];
		missionNamespace setVariable [QGVAR(enabled_civ),true, true];
		_flag = "Flag_White_F" createVehicle _pos;
		GVAR(flag_civilian_spawn) = _flag;
		_side = civilian;
	};
};

private _conditio =  "count (missionNamespace [QGVAR(teleportPoints), []]) > 1" ;
[_flag, "true", "STR_Tun_Respawn_MainBaseText" call BIS_fnc_localize, false, nil, [_side], false, _conditio ] remoteExecCall [QFUNC(addCustomTeleporter), _side, true];

if (GVAR(allowCheckTicketsBase)) then {
	[_flag, false] remoteExecCall [QFUNC(addCheckTicketCountAction), _side, true];
};

// Module function is executed by spawn command, so returned value is not necessary, but it's good practice.
true