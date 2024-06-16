#include "script_component.hpp"

[{!isNull player  &&
ADDON
}, {
	if (!GVAR(enable)) exitWith { }; // Exit if not enabled
	
	[] call FUNC(briefingNotes);

	if (playerSide isEqualTo sideLogic) exitWith { }; // Exit if a virtual entity (IE zeus) 
	GVAR(selfTPmenuOpenObj) = objNull;

	if (GVAR(gearscriptType) isEqualTo 2) then {
		[] call FUNC(savegear);
	};

	private _conditio = {
		private _return = false;
		{
			private _obj = _x;
			if (player distance2D _obj < 15) then {
				private _menuOpenConditio = _obj getVariable QGVAR(teleportConditio);
				if (call compile _menuOpenConditio) then {
					_return = true;
					GVAR(selfTPmenuOpenObj) = _obj;
					break;
				};
			};
		} forEach GVAR(teleportPoints);
		_return
	};

	private _action = ["TpMenu", localize "STR_tunres_Respawn_TeleportMenu","\a3\3den\data\cfg3den\history\changeattributes_ca.paa",{ [GVAR(selfTPmenuOpenObj)] call FUNC(openTeleportMenu) }, _conditio] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;

	//Add respawn eh
	[player, "Respawn", {
		params ["_newObject","_oldObject"];
		[] call FUNC(removegear);
		player setVariable [QGVAR(isWaitingRespawn), true, true];
		[] call FUNC(waitingArea);
	}] call CBA_fnc_addBISEventHandler;

	// Add killed EH
	[player, "killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		if (player getvariable [QGVAR(isWaitingRespawn), false]) then {
			GVAR(uselesBody) = _unit;
		};
		[] call FUNC(onPlayerKilled);
	}] call CBA_fnc_addBISEventHandler;

	addMissionEventHandler ["Map", {
		params ["_mapIsOpened", "_mapIsForced"];
		[] call FUNC(updateRespawnMarkers);
	}];

	[] call FUNC(killJIP);
	[] call FUNC(updateRespawnMarkers);
	[] call FUNC(radioSettings_tfar);
}] call CBA_fnc_waitUntilAndExecute;