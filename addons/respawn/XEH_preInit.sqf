#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

//cba_missiontime time when next wave happens.
GVAR(nextWaveTimesHash) = createHashMapFromArray ZEROS_FOR_SIDES;

//Respawn wave lenght times
GVAR(waveLenghtTimesHash) = createHashMap;

//Tickets
GVAR(ticketsHash) = createHashMap;

//Waiting area stuff
GVAR(waitingAreaHash) = createHashMap;

//Which side has respawn system started
GVAR(enabledSidesHash) = createHashMapFromArray FALSES_FOR_SIDES;

//Allow respawn for each side
GVAR(allowRespawnHash) = createHashMapFromArray TRUES_FOR_SIDES;

GVAR(timerRunningHash) = createHashMapFromArray FALSES_FOR_SIDES;
ISNILS(GVAR(teleportPoints),[]);

//allowed sides to spectate 
GVAR(allowedSpectateSidesHash) = createHashMapFromArray EMPTY_ARRAY_FOR_SIDES;
GVAR(allowedSpectateCameraModes) = [];

//flag poles [mainbase,waitingrea]
GVAR(flagPolesHash) = createHashMapFromArray [[west,[objNull,objNull]],[east,[objNull,objNull]],[resistance,[objNull,objNull]],[civilian,[objNull,objNull]]];

#include "initSettings.inc.sqf"


["force_respawn", {
	private _param = toLower(_this select 0);
	private _text = "Respawned side: ";
	private _side = sideLogic;
	
	switch  ([_param] call CBA_fnc_trim) do {
		case "west": { 
			_side = west;
			_text = _text + "west";
		};
		case "east": { 
			_side = east;
			_text = _text + "east";
		};
		case "resistance": { 
			_side = resistance;
			_text = _text + "resistance";
		};
		case "civilian": { 
			_side = civilian;
			_text = _text + "civilian";
		};
		default { 
			_text = "Side was not valid, must be: west, east, resistance or civilian";
		};
	};

	if (_side isNotEqualTo sideLogic) then {
		[QGVAR(forceRespawnWaveEH), [_side]] call CBA_fnc_serverEvent;
	};

	player sideChat _text;
}, "admin"] call CBA_fnc_registerChatCommand;

["set_tickets", {
	if (GVAR(respawnType) isNotEqualTo 1) exitWith { player sideChat "Not using side tickets"; };
	private _params = (_this select 0) splitString ",";
	_params params["_param","_count"];
	_count = parseNumber ([_count] call CBA_fnc_trim); 

	if !(IS_NUMBER(_count)) exitWith {
		player sideChat "#set_tickets needs params side,count seperated by coma. example: #set_tickets west,72";
	};
	
	private _side = sideLogic;
	private _text = "Set new tickect count for ";

	switch ([_param] call CBA_fnc_trim) do {
		case "west": { 
			_side = west;
			_text = _text + "west";
		};
		case "east": { 
			_side = east;
			_text = _text + "east";
		};
		case "resistance": { 
			_side = resistance;
			_text = _text + "resistance";
		};
		case "civilian": { 
			_side = civilian;
			_text = _text + "civilian";
		};
		default { 
			_text = "Side was not valid, must be: west, east, resistance or civilian";
		};
	};

	if (_side isNotEqualTo sideLogic) then {
		[QGVAR(setTickectCountEH), [_side,_count]] call CBA_fnc_serverEvent;
	};
	player sideChat _text;
}, "admin"] call CBA_fnc_registerChatCommand;

ADDON = true;