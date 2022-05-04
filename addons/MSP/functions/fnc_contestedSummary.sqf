/*
 * Author: [Tuntematon]
 * [Description]
 * Final summary for contested stuff
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_MSP_fnc_contestedSummary
 */
#include "script_component.hpp"

_countingUnits = {
	private _debugTime = diag_tickTime;
	params ["_msp", "_side", "_nearUnits", "_nearUnitsMin", "_status"];
	private _newStatus = false;
	private _enemyCount = 0;
	private _enemyCountMin = 0;
	private _FriendlyCount = 0;

	{
		private _testSide = _x;
		if ( [_testSide, _side] call BIS_fnc_sideIsEnemy ) then {
			private _count = _testSide countSide _nearUnits;
			ADD(_enemyCount, _count);

			private _count = _testSide countSide _nearUnitsMin;
			ADD(_enemyCountMin, _count);
			private _debugText = format ["Enemy count add: %1 [%3] (%2)",_count, _testSide, _enemyCountMin];
			LOG(_debugText);
		} else {
			private _count = _testSide countSide _nearUnits;
			ADD(_FriendlyCount, _count);
			private _debugText = format ["Friendly count add: %1 (%2)",_count, _testSide];
			LOG(_debugText);
		};
	} forEach [west, east, resistance, civilian];

	private _debugText = format ["Enemy count total: %1 [%2] --- Friendly count: %3",_enemyCount, _enemyCountMin, _FriendlyCount];
	LOG(_debugText);
	AAR_UPDATE(_msp, "Enemy Count", _enemyCount);
	AAR_UPDATE(_msp, "Enemy Count Min", _enemyCountMin);
	AAR_UPDATE(_msp, "Friendly Count", _FriendlyCount);
	
	//Notification
	private _whoToNotify = [];
	if (GVAR(contestedNotification) isEqualTo 0) then {
		{
			private _group = _x;
			if (side _group isEqualTo _side) then {
				_whoToNotify pushBack leader _group;
			};
		} forEach allGroups;
	} else {
		_whoToNotify = [_side];
	};

	//if there is more enemis in max range or even one in min range. Disable MSP
	if ( _enemyCount > _FriendlyCount || _enemyCountMin > 0 ) then {
		_newStatus = true;
		if !(_status) then {
			if (count _whoToNotify > 0 ) then {
				(call compile ("STR_Tun_MSP_FNC_Contested_hint" call BIS_fnc_localize)) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
			};
			[_side, false] call TUN_respawn_fnc_update_respawn_point;
			AAR_UPDATE(_msp,"Is contested", true);
		};
	} else {
		if ( _status ) then {
			if (count _whoToNotify > 0 ) then {
				(call compile ("STR_Tun_MSP_FNC_secured_hint" call BIS_fnc_localize)) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
			};
			[_side, true, (getPos _msp) ] call TUN_respawn_fnc_update_respawn_point;
			AAR_UPDATE(_msp,"Is contested", false);
		};
	};

	private _debugText = format ["Contested summary. Side: %1, NewStatus: %2, enemyCount: %3, enemyCountMin: %4, FriendlyCount: %5",_side, _newStatus, _enemyCount, _enemyCountMin, _FriendlyCount];
	LOG(_debugText);
	private _debugText = format ["Contested summary count units spent time: %1", (diag_tickTime -_debugTime) ];
	LOG(_debugText);
	[QGVAR(EH_contestedUpdate), [_newStatus, _enemyCount, _enemyCountMin, _FriendlyCount]] call CBA_fnc_globalEvent;
	[_newStatus, _enemyCount, _enemyCountMin, _FriendlyCount]
};

if ( GVAR(status_east) ) then {
	if (GVAR(vehicle_east) == objNull) then {
		GVAR(status_east) = false;
		ERROR("MSP Object Disapeared (EAST)");
	} else {

		private _msp = GVAR(vehicle_east);
		private _side = east;
		private _nearUnits = GVAR(nearUnitsEast);
		private _nearUnitsMin = GVAR(nearUnitsEastMin);
		private _status = GVAR(contested_east);

		private _returns = [_msp, _side, _nearUnits, _nearUnitsMin, _status] call _countingUnits;
		private _newStatus = _returns select 0;
		private _enemyCount = _returns select 1;
		private _enemyCountMin = _returns select 2;
		private _FriendlyCount = _returns select 3;

		GVAR(enemyCountEast) = _enemyCount;
		GVAR(enemyCountMinEast) = _enemyCountMin;
		GVAR(friendlyCountEast) = _FriendlyCount;

		missionNamespace setVariable [QGVAR(contested_east), _newStatus, true];
		_msp setVariable [QGVAR(isContested), _newStatus, true];
	};
};

if ( GVAR(status_west) ) then {
	if (GVAR(vehicle_west) == objNull) then {
		GVAR(status_west) = false;
		ERROR("MSP Object Disapeared (WEST)");
	} else {

		private _msp = GVAR(vehicle_west);
		private _side = west;
		private _nearUnits = GVAR(nearUnitsWest);
		private _nearUnitsMin = GVAR(nearUnitsWestMin);
		private _status = GVAR(contested_west);
		
		private _returns = [_msp, _side, _nearUnits, _nearUnitsMin, _status] call _countingUnits;
		private _newStatus = _returns select 0;
		private _enemyCount = _returns select 1;
		private _enemyCountMin = _returns select 2;
		private _FriendlyCount = _returns select 3;

		GVAR(enemyCountWest) = _enemyCount;
		GVAR(enemyCountMinWest) = _enemyCountMin;
		GVAR(friendlyCountWest) = _FriendlyCount;

		missionNamespace setVariable [QGVAR(contested_west), _newStatus, true];
		_msp setVariable [QGVAR(isContested), _newStatus, true];
	};
};

if ( GVAR(status_guer) ) then {
	if (GVAR(vehicle_guer) == objNull) then {
		GVAR(status_guer) = false;
		ERROR("MSP Object Disapeared (RESISTANCE)");
	} else {

		private _msp = GVAR(vehicle_guer);
		private _side = resistance;
		private _nearUnits = GVAR(nearUnitsGuer);
		private _nearUnitsMin = GVAR(nearUnitsGuerMin);
		private _status = GVAR(contested_guer);
		
		private _returns = [_msp, _side, _nearUnits, _nearUnitsMin, _status] call _countingUnits;
		private _newStatus = _returns select 0;
		private _enemyCount = _returns select 1;
		private _enemyCountMin = _returns select 2;
		private _FriendlyCount = _returns select 3;

		GVAR(enemyCountGuer) = _enemyCount;
		GVAR(enemyCountMinGuer) = _enemyCountMin;
		GVAR(friendlyCountGuer) = _FriendlyCount;

		missionNamespace setVariable [QGVAR(contested_guer), _newStatus, true];
		_msp setVariable [QGVAR(isContested), _newStatus, true];
	};
};

if ( GVAR(status_civ) ) then {
	if (GVAR(vehicle_civ) == objNull) then {
		GVAR(status_civ) = false;
		ERROR("MSP Object Disapeared (CIVILIAN)");
	} else {
		private _msp = GVAR(vehicle_civ);
		private _side = civilian;
		private _nearUnits = GVAR(nearUnitsCiv);
		private _nearUnitsMin = GVAR(nearUnitsCivMin);
		private _status = GVAR(contested_civ);
		
		private _returns = [_msp, _side, _nearUnits, _nearUnitsMin, _status] call _countingUnits;
		private _newStatus = _returns select 0;
		private _enemyCount = _returns select 1;
		private _enemyCountMin = _returns select 2;
		private _FriendlyCount = _returns select 3;

		GVAR(enemyCountCiv) = _enemyCount;
		GVAR(enemyCountMinCiv) = _enemyCountMin;
		GVAR(friendlyCountCiv) = _FriendlyCount;

		missionNamespace setVariable [QGVAR(contested_civ), _newStatus, true];
		_msp setVariable [QGVAR(isContested), _newStatus, true];
	};
};