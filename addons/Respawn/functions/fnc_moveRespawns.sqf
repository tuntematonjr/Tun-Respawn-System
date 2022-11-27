/*
 * Author: [Tuntematon]
 * [Description]
 * Move respawns and give gear
 *
 * Arguments:
 * 0: Side <SIDE>
 *
 * Return Value:
 * The return true when done <BOOL>
 *
 * Example:
 * ["side"] call Tun_Respawn_fnc_moveRespawns
 */
#include "script_component.hpp"
params ["_side", ["_forceAll", false, [false]]];
private ["_respawn_waitingarea", "_respawn_gearPath"];

if (!isServer) exitWith { };

private _waitingRespawnDelayedInRespawn = [];
private _totalRespawnCount = 0;
private _unitListVarName = "";
private _delayedUnitListVarName = "";
private _hash = GVAR(respawnPointsHash);
private _respawn_position = getMarkerPos ((_hash get _side) select 0);
switch (_side) do {
	case west: {
		_respawn_waitingarea = getpos (GVAR(waitingarea_west) select 1);
		_waitingRespawnDelayedInRespawn = GVAR(waitingRespawnWest);
		_totalRespawnCount = GVAR(totalRespawnCountWest);
		_unitListVarName = QGVAR(waitingRespawnWest);
		_delayedUnitListVarName = QGVAR(waitingRespawnDelayedWest);
	};

	case east: {
		_respawn_waitingarea = getpos (GVAR(waitingarea_east) select 1);
		_totalRespawnCount = GVAR(totalRespawnCountEast);
		_unitListVarName = QGVAR(waitingRespawnEast);
		_delayedUnitListVarName = QGVAR(waitingRespawnDelayedEast);
	};

	case resistance: {
		_respawn_waitingarea = getpos (GVAR(waitingarea_guer) select 1);
		_totalRespawnCount = GVAR(totalRespawnCountGuer);
		_unitListVarName = QGVAR(waitingRespawnGuer);
		_delayedUnitListVarName = QGVAR(waitingRespawnDelayedGuer);
	};

	case civilian: {
		_respawn_waitingarea = getpos (GVAR(waitingarea_civ) select 1);
		_totalRespawnCount = GVAR(totalRespawnCountCiv);
		_unitListVarName = QGVAR(waitingRespawnCiv);
		_delayedUnitListVarName = QGVAR(waitingRespawnDelayedCiv);
	};

	default {
		ERROR_MSG("Move respawn FNC missing side param!");
	};
};



private _waitingRespawn = missionNamespace getVariable _unitListVarName;
private _waitingRespawnDelayed = missionNamespace getVariable _delayedUnitListVarName;
if (count _waitingRespawn > 0 || count _waitingRespawnDelayed > 0) then {
	FILTER(_waitingRespawn,(!isnull _x && _x in allPlayers && alive _x ));
	FILTER(_waitingRespawnDelayed,(!isnull _x && _x in allPlayers && alive _x ));
	missionNamespace setVariable [_unitListVarName, _waitingRespawn, false];
	missionNamespace setVariable [_delayedUnitListVarName, _waitingRespawnDelayed, false];

	//Sort out delayed respawn play
	if (_forceAll) then {
		
		{
			private _unit = _x;
			if (_unit getVariable [QGVAR(skip_next_wave), false]) then {
				_unit setVariable [QGVAR(skip_next_wave), false, true];
				PUSH(_waitingRespawn,_unit);
			};
		} forEach _waitingRespawnDelayed;
		missionNamespace setVariable [_unitListVarName, _waitingRespawn, true];
		missionNamespace setVariable [_delayedUnitListVarName, [], true];
	};
};
if (count _waitingRespawn > 0) then {

	//move
	[{
		_args params ["_respawn_waitingarea", "_respawn_position", "_side", "_unitListVarName", "_delayedUnitListVarName"];

		private _unitList = (missionNamespace getVariable _unitListVarName);
		//when done, remove and move delayed units to main var
		if ((count _unitList) isEqualTo 0) exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;
			private _waitingRespawnDelayed = missionNamespace getVariable _delayedUnitListVarName;
			{
				private _unit = _x;
				_unit setVariable [QGVAR(skip_next_wave), false, true];
			} forEach _waitingRespawnDelayed;
			missionNamespace setVariable [_unitListVarName, _waitingRespawnDelayed, true];
			missionNamespace setVariable [_delayedUnitListVarName, [], true];
		};

		private _unit = _unitList select 0;
		
		_unitList deleteAt 0;
		if (isnull _unit || !(_unit in allPlayers) || !alive _unit ) exitWith {
			missionNamespace setVariable [_unitListVarName, _unitList, false];
		};

		_unit setVariable [QGVAR(waiting_respawn), false, true];
		private _text = "STR_Tun_Respawn_FNC_moveRespawns" call BIS_fnc_localize;
		[_unit, _respawn_position, _text, 20] call FUNC(teleport);
		remoteExecCall [QFUNC(addGear), _unit];
		[QGVAR(EH_unitRespawned), [_unit], _unit] call CBA_fnc_localEvent;
	}, 0.2, [_respawn_waitingarea, _respawn_position, _side, _unitListVarName, _delayedUnitListVarName]] call CBA_fnc_addPerFrameHandler;


	private _waitingRespawnCount = count _waitingRespawn;
	_totalRespawnCount = _totalRespawnCount + _waitingRespawnCount;
	switch (_side) do {
		case west: { missionNamespace setVariable [QGVAR(totalRespawnCountWest), _totalRespawnCount, true]; };
		case east: { missionNamespace setVariable [QGVAR(totalRespawnCountEast), _totalRespawnCount, true]; };
		case resistance: { missionNamespace setVariable [QGVAR(totalRespawnCountGuer), _totalRespawnCount, true]; };
		case civilian: { missionNamespace setVariable [QGVAR(totalRespawnCountCiv), _totalRespawnCount, true]; };
	};

	private _debugText = format ["Side %1 all respawn units moved. Respawned: %2. Total count is: %3", _side, _waitingRespawnCount, _totalRespawnCount]; 
	INFO(_debugText);

	[QGVAR(EH_moveRespawns), [_side, _waitingRespawn]] call CBA_fnc_serverEvent;
} else {
	private _waitingRespawnDelayed = missionNamespace getVariable _delayedUnitListVarName;
	if (count _waitingRespawnDelayed > 0) then {
		{
			private _unit = _x;
			_unit setVariable [QGVAR(skip_next_wave), false, true];
		} forEach _waitingRespawnDelayed;
		missionNamespace setVariable [_unitListVarName, _waitingRespawnDelayed, true];
		missionNamespace setVariable [_delayedUnitListVarName, [], true];
	};
};

true