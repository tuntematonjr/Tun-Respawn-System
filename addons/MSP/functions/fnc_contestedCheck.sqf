/*
 * Author: [Tuntematon]
 * [Description]
 * 
 * Arguments:
 * None
 * Return Value:
 * None
 *
 * Example:
 * [] call Tun_MSP_fnc_contestedCheck
 */
// private _result = diag_codePerformance [{ 
#include "script_component.hpp"

private _hash = GVAR(contestedCheckHash);
private _countestedRangeMax = GVAR(contested_radius_max);
private _countestedRangeMin = GVAR(contested_radius_min);
private _allSides = [west,east,resistance,civilian];
private _allunits = allUnits select {(side _x) in [west,east,resistance,civilian]};

{
	_x params ["_mspDeployementStatusVar", "_msp", "_contestedStatusVar", "_side"];
	private _status = missionNamespace getVariable [_mspDeployementStatusVar, false];
	
	if ( _status && { !(isNull _msp) } ) then {
		
		private _sidesToCheck = _allSides - [_side];
		private _friendlySides = [_side];
		private _enemySides = [];

		{
			private _otherSide = _x;
			if (_side getFriend _otherSide < 0.6) then {
				_enemySides pushBack _otherSide;
			} else {
				_friendlySides pushBack _otherSide;
			};
		} forEach _sidesToCheck;

		private _pos = getpos _msp;
		private _unitsInArea = _allunits inAreaArray [_pos, _countestedRangeMax, _countestedRangeMax, 0, false, (_countestedRangeMax/2)];
		private _enemiesInArea = _unitsInArea select {(side _x) in _enemySides};
		private _friendliesInArea = (count _unitsInArea) - (count _enemiesInArea);
		private _enemiesInAreaMin = count (_enemiesInArea inAreaArray [_pos, _countestedRangeMin, _countestedRangeMin, 0, false, (_countestedRangeMin/2)]);
		_enemiesInArea = count _enemiesInArea;
		_hash set [_side, [_enemiesInArea, _enemiesInAreaMin, _friendliesInArea]];
		
		private _isContested = false;
		if (_enemiesInAreaMin > 0 || _enemiesInArea > _friendliesInArea) then {
			_isContested = true;
		};
		AAR_UPDATE(_msp, "Enemy Count", _enemiesInArea);
		AAR_UPDATE(_msp, "Enemy Count Min", _enemiesInAreaMin);
		AAR_UPDATE(_msp, "Friendly Count", _friendliesInArea);
		AAR_UPDATE(_msp, "Is contested", _isContested);

		private _oldContestedStatus = missionNamespace getVariable [_contestedStatusVar, false];
		if (_oldContestedStatus isNotEqualTo _isContested) then {
			AAR_UPDATE(_msp, "Is contested", _isContested);
			missionNamespace setVariable [_contestedStatusVar, _isContested, true];
			_msp setVariable [QGVAR(isContested), _isContested, true];
			private _whoToNotify = [_side] call FUNC(whoToNotify);
			if (count _whoToNotify > 0 ) then {
				if (_isContested) then {
					[_side, false] call EFUNC(respawn,update_respawn_point);
					(call compile ("STR_Tun_MSP_FNC_Contested_hint" call BIS_fnc_localize)) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
				} else {
					[_side, true, (getPos _msp) ] call EFUNC(respawn,update_respawn_point);
					(call compile ("STR_Tun_MSP_FNC_secured_hint" call BIS_fnc_localize)) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
				};
			};
		};
		
	private _debugText = format ["Contested summary. Side: %1, NewStatus: %2, OldStatus: %6, enemyCount: %3, enemyCountMin: %4, FriendlyCount: %5",_side, _isContested, _enemiesInArea, _enemiesInAreaMin, _friendliesInArea, _oldContestedStatus];
	LOG(_debugText);
	} else {
		if (_status) then {		
			missionNamespace setVariable [_mspDeployementStatusVar, false, true];
			missionNamespace setVariable [_contestedStatusVar, false, true];
			private _text = "MSP Object Disapeared" + str _side;
			ERROR(_text);
		};
	};
} forEach [
	[QGVAR(status_east), GVAR(vehicle_east), QGVAR(contested_east), east],
	[QGVAR(status_West), GVAR(vehicle_west), QGVAR(contested_west), west],
	[QGVAR(status_guer), GVAR(vehicle_guer), QGVAR(contested_guer), resistance],
	[QGVAR(status_civ), GVAR(vehicle_civ), QGVAR(contested_civ), civilian]
];
// }, nil, 10000];

// systemChat str _result;

// diag_log _result;