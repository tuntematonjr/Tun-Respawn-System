#include "script_component.hpp"

[{
	TRACE_2("post init player",[] call ace_common_fnc_player,!isNull ([] call ace_common_fnc_player));
	!isNull ([] call ace_common_fnc_player) &&
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

	private _action = ["TpMenu", LLSTRING(TeleportMenu),"\a3\3den\data\cfg3den\history\changeattributes_ca.paa",{ [GVAR(selfTPmenuOpenObj)] call FUNC(openTeleportMenu) }, _conditio] call ace_interact_menu_fnc_createAction;
	[(typeOf player), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;

	private _player = [] call ace_common_fnc_player;
	//Add respawn eh
	[_player, "Respawn", {
		params ["_newObject","_oldObject"];
		LOG("Respawn EH");
		[_newObject] call FUNC(removegear);
		_newObject setVariable [QGVAR(isWaitingRespawn), true, true];
		[_newObject] call FUNC(waitingArea);
	}] call CBA_fnc_addBISEventHandler;

	// Add killed EH
	[_player, "killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		if (_unit getVariable [QGVAR(isWaitingRespawn), false]) then {	
			[GVAR(waitingAreaPFH)] call CBA_fnc_removePerFrameHandler;
			GVAR(waitingAreaPFH) = nil;
			GVAR(uselesBody) = _unit;
		};
		LOG("Killed EH");
		TRACE_1("EH Killed",_unit);
		[_unit] call FUNC(onPlayerKilled);
	}] call CBA_fnc_addBISEventHandler;

	addMissionEventHandler ["Map", {
		params ["_mapIsOpened", "_mapIsForced"];
		[] call FUNC(updateRespawnMarkers);
	}];

	[] call FUNC(moveJIP);
	[] call FUNC(updateRespawnMarkers);
	[] call FUNC(radioSettings_tfar);
}] call CBA_fnc_waitUntilAndExecute;

[QGVAR(startSpectatorEH), {
	[] call FUNC(startSpectator);
}] call CBA_fnc_addEventHandler;

[QGVAR(setPlayerRespawnTimeEH), {
	params [["_time", 1, [1]]];
	TRACE_1("set respa time",_time);
	setPlayerRespawnTime _time;
}] call CBA_fnc_addEventHandler;