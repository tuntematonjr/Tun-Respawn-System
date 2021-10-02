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
 * ["something", player] call Tun_Respawn_fnc_module_waitingarea
 */
#include "script_component.hpp"

if (!isServer) exitWith { };

_logic = param [0,objNull,[objNull]];

_markername = _logic getVariable ["respawn_side","none"];

if (_markername == "none") exitWith { hint ("STR_Tun_Respawn_Module_WaitingArea_novalue" call BIS_fnc_localize); false }; // Exit if no side


if (getMarkerColor _markername == "") then {
	_marker = [_markername, getPos _logic, "icon", [1, 1], "PERSIST", "TYPE:", "Empty"] call CBA_fnc_createMarker;
	_marker setMarkerAlpha 0;
} else {
	hint format [( "STR_Tun_Respawn_Module_WaitingArea_MultipleMarkers" call BIS_fnc_localize), _markername];
};

_pos = getPos _logic;

switch (_markername) do {
	case "respawn_west": {
		missionNamespace setVariable [QGVAR(waitingarea_west), [_markername, _logic, _pos], true];

		GVAR(flag_west) = "Flag_Blue_F" createVehicle _pos;
		[west] call FUNC(timer);
	};

	case "respawn_east": {
		missionNamespace setVariable [QGVAR(waitingarea_east), [_markername, _logic, _pos], true];

		GVAR(flag_east) = "Flag_Red_F" createVehicle _pos;
		[east] call FUNC(timer);
	};

	case "respawn_guerrila": {
		missionNamespace setVariable [QGVAR(waitingarea_guer), [_markername, _logic, _pos], true];

		GVAR(flag_guerrila) = "Flag_Green_F" createVehicle _pos;
		[resistance] call FUNC(timer);
	};

	case "respawn_civilian": {
		missionNamespace setVariable [QGVAR(waitingarea_civ), [_markername, _logic, _pos], true];

		GVAR(flag_civilian) = "Flag_White_F" createVehicle _pos;
		[civilian] call FUNC(timer);
	};
};

// Module function is executed by spawn command, so returned value is not necessary, but it's good practice.
true