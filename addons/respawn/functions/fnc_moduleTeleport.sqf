/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * The return true when done <BOOL>
 *
 * Example:
 * [Logic]call tunres_Respawn_fnc_moduleTeleport
 */
#include "script_component.hpp"

private _logic = param [0,objNull,[objNull]];

if (isServer) then { 
	private _obj = _logic getVariable [QGVAR(teleportPointOBJ), "FlagPole_F"];
	_obj = _obj createVehicle getPosASL _logic;
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
		private _statement = {
			params ["_logic"];

			private _obj = _logic getVariable [QGVAR(teleportObject), objNull];
			private _createMarker = _logic getVariable QGVAR(teleportCreateMarker);
			private _tpConditio = _logic getVariable QGVAR(teleportConditio);
			private _menuOpenConditio = _logic getVariable QGVAR(teleportmenuOpenConditio);
			private _useAceAction = _logic getVariable QGVAR(teleportUseAceAction);
			private _name = _logic getVariable QGVAR(teleportName);
			private _markerIcon = _logic getVariable [QGVAR(teleportMarkerIcon), "hd_start"];
			private _allowCheckTickets = _logic getVariable [QGVAR(tunres_respawn_teleportCheckTickets), false];
			
			private _actionPath = [];

			if (_useAceAction) then {
				_actionPath = [_obj] call FUNC(addMainAction);
			};

			[_obj, _tpConditio, _name, _createMarker, _markerIcon, [playerSide], _useAceAction, _menuOpenConditio, _allowCheckTickets, _actionPath] call FUNC(addCustomTeleporter);
		};
		
		[
			{
				params ["_logic"];
				_logic getVariable [QGVAR(teleportObject), objNull] isNotEqualTo objNull
			},
			_statement,
			[_logic]
		] call CBA_fnc_waitUntilAndExecute;
	};
};

true
