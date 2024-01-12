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
 * ["side"] call tunres_Respawn_fnc_doRespawnWave
 */
#include "script_component.hpp"
params [["_side", nil, [west]], ["_forceAll", false, [false]]];
private ["_respawn_waitingarea", "_respawn_gearPath"];

if (!isServer) exitWith { };

private _totalRespawnCountHash = GVAR(totalRespawnCount);
private _totalRespawnCount = _totalRespawnCountHash get _side;
private _respawnPointsHash= GVAR(respawnPointsHash);
private _respawn_position = getMarkerPos ((_respawnPointsHash get _side) select 0);
private _waitingRespawnHash = GVAR(waitingRespawnList);
private _waitingRespawnDelayedHash = GVAR(waitingRespawnDelayedList);
private _waitingRespawn = _waitingRespawnHash get _side;
private _waitingRespawnDelayed = _waitingRespawnDelayedHash get _side;

if (count _waitingRespawn > 0 || count _waitingRespawnDelayed > 0) then {

	//Filter ghost units out
	FILTER(_waitingRespawn,(!isnull _x && _x in allPlayers && alive _x ));
	FILTER(_waitingRespawnDelayed,(!isnull _x && _x in allPlayers && alive _x ));

	//If forced all, clears delayed respawn
	if (_forceAll) then {
		{
			private _unit = _x;
			if (_unit getVariable [QGVAR(skip_next_wave), false]) then {
				_unit setVariable [QGVAR(skip_next_wave), false, true];
				PUSH(_waitingRespawn,_unit);
			};
		} forEach _waitingRespawnDelayed;
		_waitingRespawnDelayed = [];
	};

	_waitingRespawnHash set [_side, _waitingRespawn];
	_waitingRespawnDelayedHash set [_side, _waitingRespawnDelayed];
};

if (count _waitingRespawn > 0) then {

	//move
	[{
		_args params ["_respawn_position", "_side"];
		private _waitingRespawnHash = GVAR(waitingRespawnList);
		private _unitList = _waitingRespawnHash get _side;

		//when done, remove and move delayed units to main var
		if ((count _unitList) isEqualTo 0) exitWith {

			[_handle] call CBA_fnc_removePerFrameHandler;

			private _waitingRespawnDelayedHash = GVAR(waitingRespawnDelayedList);
			private _waitingRespawnDelayed = _waitingRespawnDelayedHash get _side;

			{
				private _unit = _x;
				_unit setVariable [QGVAR(skip_next_wave), false, true];
			} forEach _waitingRespawnDelayed;
			
			_waitingRespawnHash set [_side, _waitingRespawnDelayed];
			_waitingRespawnDelayedHash set [_side, []];
			
			publicVariable QGVAR(waitingRespawnList);
			publicVariable QGVAR(waitingRespawnDelayedList);
		};

		private _unit = _unitList select 0;
		_unitList deleteAt 0;

		if (isnull _unit || !(_unit in allPlayers) || !alive _unit ) exitWith {
			_waitingRespawnHash set [_side, _unitList];
		};

		_unit setVariable [QGVAR(waiting_respawn), false, true];
		private _text = localize "STR_tunres_Respawn_FNC_moveRespawnText";
		
		[_unit, _respawn_position, _text, 20, true] call FUNC(teleportUnit);

		remoteExecCall [QFUNC(addGear), _unit];

		[QGVAR(EH_unitRespawned), [_unit], _unit] call CBA_fnc_localEvent;
	}, 0.2, [_respawn_position, _side]] call CBA_fnc_addPerFrameHandler;


	private _waitingRespawnCount = count _waitingRespawn;
	_totalRespawnCount = _totalRespawnCount + _waitingRespawnCount;
	_totalRespawnCountHash set [_side, _totalRespawnCount];

	private _debugText = format ["Side %1 all respawn units moved. Respawned: %2. Total count is: %3", _side, _waitingRespawnCount, _totalRespawnCount]; 
	INFO(_debugText);

	[QGVAR(EH_respawnWave), [_side, _waitingRespawn]] call CBA_fnc_serverEvent;
} else {
	//No one at respawn
	if (count _waitingRespawnDelayed > 0) then {
		{
			private _unit = _x;
			_unit setVariable [QGVAR(skip_next_wave), false, true];
		} forEach _waitingRespawnDelayed;
		_waitingRespawnHash set [_side, _waitingRespawnDelayed];
		_waitingRespawnDelayedHash set [_side, []];
		publicVariable QGVAR(waitingRespawnList);
		publicVariable QGVAR(waitingRespawnDelayedList);
	};
};

true