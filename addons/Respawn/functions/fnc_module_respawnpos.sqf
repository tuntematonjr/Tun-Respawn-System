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

_logic = param [0,objNull,[objNull]];

_markername = _logic getVariable ["respawn_side","none"];

if (_markername == "none") exitWith { hint localize "STR_Tun_Respawn_Module_RespanPos_novalue"; false }; // Exit if no side


if (getMarkerColor _markername == "") then {
	_marker = [_markername, getPos _logic, "icon", [1, 1], "PERSIST", "TYPE:", "respawn_inf"] call CBA_fnc_createMarker;
	_marker setMarkerAlpha 0;
	_marker setMarkerText "Respawn";
} else {
	hint format [(localize "STR_Tun_Respawn_Module_RespanPos_MultipleMarkers"), _markername];
};

_pos = getPos _logic;

switch (_markername) do {
	case "tun_respawn_west": {
		_markername setMarkerColor "ColorWEST";
		missionNamespace setVariable [QGVAR(respawnpos_west), [_markername, _logic, _pos], true];
		missionNamespace setVariable [QGVAR(enabled_west),true, true];

		GVAR(flag_west_spawn) = "Flag_Blue_F" createVehicle _pos;
	};

	case "tun_respawn_east": {
		_markername setMarkerColor "ColorEAST";
		missionNamespace setVariable [QGVAR(respawnpos_east), [_markername, _logic, _pos], true];
		missionNamespace setVariable [QGVAR(enabled_east),true, true];

		GVAR(flag_east_spawn) = "Flag_Red_F" createVehicle _pos;
	};

	case "tun_respawn_guerrila": {
		_markername setMarkerColor "ColorGUER";
		missionNamespace setVariable [QGVAR(respawnpos_guer), [_markername, _logic, _pos], true];
		missionNamespace setVariable [QGVAR(enabled_guer),true, true];

		GVAR(flag_guerrila_spawn) = "Flag_Green_F" createVehicle _pos;
	};

	case "tun_respawn_civilian": {
		_markername setMarkerColor "ColorCIV";
		missionNamespace setVariable [QGVAR(respawnpos_civ), [_markername, _logic, _pos], true];
		missionNamespace setVariable [QGVAR(enabled_civ),true, true];

		GVAR(flag_civilian_spawn) = "Flag_White_F" createVehicle _pos;
	};
};

// Module function is executed by spawn command, so returned value is not necessary, but it's good practice.
true