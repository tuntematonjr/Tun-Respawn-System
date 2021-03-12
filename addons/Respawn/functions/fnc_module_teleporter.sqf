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
 * ["something", player] call Tun_Respawn_fnc_module_teleporter
 */
#include "script_component.hpp"

private _logic = param [0,objNull,[objNull]];

if (isServer) then { 
	private _obj = _logic getVariable [QGVAR(teleportPointOBJ), "FlagPole_F"];
	_obj = _obj createVehicle getpos _logic;
	_logic setVariable [QGVAR(teleportObject), _obj, true];
};

if (hasInterface) then {

	private _enabledSide = switch (playerSide) do {
		case west: { _logic getVariable [QGVAR(teleportEnableWest), false] };
		case east: { _logic getVariable [QGVAR(teleportEnableEast), false] };
		case resistance: { _logic getVariable [QGVAR(teleportEnableResistance), false] };
		case civilian: { _logic getVariable [QGVAR(teleportEnableCivilian), false] };
		default { false };
	};

	if ( _enabledSide ) then {

		GVAR(teleportPoints) pushBackUnique _logic;

		private _createMarker = _logic getVariable QGVAR(teleportCreateMarker);
		private _menuOpenConditio = _logic getVariable QGVAR(teleportmenuOpenConditio);
		private _useAceAction = _logic getVariable QGVAR(teleportUseAceAction);

		if (_createMarker) then {
			private _text = _logic getVariable QGVAR(teleportName);
			private _markerName = format["tun_respawn_%1",_text];
			private _markerIcon= _logic getVariable [QGVAR(teleportMarkerIcon), "hd_start"];
			private _marker = [_markerName, getpos _logic, "ICON", [1, 1], "TYPE:", _markerIcon, "TEXT:", _text] call CBA_fnc_createMarker;
			_logic setVariable [QGVAR(markerName), _marker];
		};

		private _statement = {
			params ["_logic", "_menuOpenConditio", "_useAceAction"];
			private _obj = _logic getVariable [QGVAR(teleportObject), objNull];
			[_obj, _menuOpenConditio, _useAceAction] call FUNC(addTeleportAction);
		};
		
		[
			{
				params ["_logic"];
				_logic getVariable [QGVAR(teleportObject), objNull] != objNull
			},
			_statement,
			[_logic, _menuOpenConditio, _useAceAction]
		] call CBA_fnc_waitUntilAndExecute;
	};

};
