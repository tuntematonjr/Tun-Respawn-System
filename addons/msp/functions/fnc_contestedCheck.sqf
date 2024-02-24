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
 * [] call tunres_MSP_fnc_contestedCheck
 */
// private _result = diag_codePerformance [{ 
#include "script_component.hpp"
params[["_side", nil,[west]],["_mspSetup", false]];

if (!isServer) then {};
private _oldAllowRespawnStatus = GVAR(allowRespawn) get _side;
GVAR(allowRespawn) set [_side, false];

private _values = GVAR(contestValues) get _side;
private _contestedRadiusMax = _values param [2];
private _contestedRadiusMin = _values param [3];

private _hash = GVAR(contestedCheckHash);
private _allUnits = units west + units east + units resistance + units civilian;

private _mspDeployementStatus = GVAR(deployementStatus) get _side;
private _msp = GVAR(activeVehicle) get _side;

if ( _mspDeployementStatus && { !(isNull _msp) } ) then {
	
	private _sidesToCheck = [west,east,resistance,civilian] - [_side];
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
	private _unitsInArea = _allunits inAreaArray [_pos, _contestedRadiusMax, _contestedRadiusMax, 0, false, (_contestedRadiusMax/2)];
	private _enemiesInArea = _unitsInArea select {(side _x) in _enemySides};
	private _friendliesInArea = (count _unitsInArea) - (count _enemiesInArea);
	private _enemiesInAreaMin = count (_enemiesInArea inAreaArray [_pos, _contestedRadiusMin, _contestedRadiusMin, 0, false, (_contestedRadiusMin/2)]);
	_enemiesInArea = count _enemiesInArea;
	_hash set [_side, [_enemiesInArea, _enemiesInAreaMin, _friendliesInArea]];
	
	private _isContested = false;
	if (_enemiesInAreaMin > 0 || _enemiesInArea > _friendliesInArea) then {
		_isContested = true;
	};
	AAR_UPDATE(_msp,"Enemy Count",_enemiesInArea);
	AAR_UPDATE(_msp,"Enemy Count Min",_enemiesInAreaMin);
	AAR_UPDATE(_msp,"Friendly Count",_friendliesInArea);
	AAR_UPDATE(_msp,"Is contested",_isContested);

	private _oldContestedStatus = GVAR(contestedStatus) get _side;
	if (_oldContestedStatus isNotEqualTo _isContested) then {
		AAR_UPDATE(_msp,"Is contested",_isContested);
		GVAR(contestedStatus) set [_side, _isContested];
		publicVariable QGVAR(contestedStatus);
		_msp setVariable [QGVAR(isContested), _isContested, true];
		private _whoToNotify = [_side, GVAR(contestedNotification)] call FUNC(whoToNotify);
		if (_whoToNotify isNotEqualTo [] ) then {
			if (_isContested) then {
				[_side, false] call EFUNC(respawn,updateRespawnPoint);
				(call compile (localize "STR_tunres_MSP_FNC_Contested_hint")) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
			} else {
				[_side, true, (getPos _msp) ] call EFUNC(respawn,updateRespawnPoint);
				(call compile (localize "STR_tunres_MSP_FNC_secured_hint")) remoteExecCall ["CBA_fnc_notify", _whoToNotify];
			};
		};
	};
	[QGVAR(EH_mspStatusUpdate), [_side, _isContested, _oldContestedStatus, _enemiesInArea, _enemiesInAreaMin, _friendliesInArea,  _mspSetup]] call CBA_fnc_globalEvent;
	private _debugText = format ["Contested summary. Side: %1, NewStatus: %2, OldStatus: %3, enemyCount: %4, enemyCountMin: %5, FriendlyCount: %6, Was MSP setup: %7",_side, _isContested, _oldContestedStatus, _enemiesInArea, _enemiesInAreaMin, _friendliesInArea,  _mspSetup];
	LOG(_debugText);
} else {
	if (_mspDeployementStatus) then {
		GVAR(deployementStatus) set [_side, false];
		publicVariable QGVAR(deployementStatus);
		GVAR(contestedStatus) set [_side, false];
		publicVariable QGVAR(contestedStatus);
		private _text = "MSP Object Disapeared" + str _side;
		ERROR(_text);
	};
};

GVAR(allowRespawn) set [_side, _oldAllowRespawnStatus];