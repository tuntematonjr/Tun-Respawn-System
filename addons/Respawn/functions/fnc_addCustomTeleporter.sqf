/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Target object <OBJECT>
 * 1: Condition for allow tp there, must return true or false <STRING> (default: "true")
 * 2: TP name <STRING>
 * 3: Create marker <BOOL> (default: true)
 * 4: Marker icon <STRING> (default: "hd_start")
 * 5: Array of enabled sides <ARRAY> (default: [])
 * 6: Use ace action. False to use addAction <BOOL> (default: true)
 * 7: TP menu open conditio, must return true or false <STRING> (default: "true")
 *
 * Return Value:
 * none
 *
 * Example:
 * [this, "true", "TP 1", true, "hd_start", [west, resistance], true, "true"] call Tun_Respawn_fnc_addCustomTeleporter
 */
 if (hasInterface) then {

	#include "script_component.hpp"

	params [["_obj", objNull, [objNull]], ["_conditio", "true", [""]], ["_name", "", [""]], ["_createMarker", true, [true]], ["_markerIcon", "hd_start", [""]], ["_enabledSides", [], [[]]], ["_useAceAction", true, [true]], ["_menuOpenConditio", "true", [""]]];

	if ( playerSide in _enabledSides ) then {
	
		_obj setVariable [QGVAR(teleportConditio), _conditio];
		_obj setVariable [QGVAR(teleportName), _name];

		GVAR(teleportPoints) pushBackUnique _obj;

		if (_createMarker) then {
			private _markerName = format["tun_respawn_%1",_name];
			private _marker = [_markerName, getpos _obj, "ICON", [1, 1], "TYPE:", _markerIcon, "TEXT:", _name] call CBA_fnc_createMarker;
			_obj setVariable [QGVAR(markerName), _marker];
		};

		[_obj, _conditio, _useAceAction] call FUNC(addTeleportAction);
	};
};