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
#include "script_component.hpp"
params [["_side", nil,[west]]];

if (!isServer) exitWith {};
private _oldAllowRespawnStatus = EGVAR(respawn,allowRespawnHash) get _side;
EGVAR(respawn,allowRespawnHash) set [_side, false];

private _values = GVAR(contestValuesHash) get _side;
private _contestedRadiusMax = _values param [2];
private _contestedRadiusMin = _values param [3];

private _hash = GVAR(contestedCheckHash);
private _allUnits = units west + units east + units resistance + units civilian;

private _mspDeployementStatus = GVAR(deployementStatusHash) get _side;
private _msp = GVAR(activeVehicleHash) get _side;

if ( _mspDeployementStatus && { !(isNull _msp) } ) then {
	
	private _sidesToCheck = ALL_SIDES - [_side];
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

	private _pos = ASLToAGL (getPosASL _msp);
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

	private _oldContestedStatus = GVAR(contestedStatusHash) get _side;

	if (_oldContestedStatus isNotEqualTo _isContested) then {

		if (EGVAR(main,AAR_Enabled)) then {
			private _aarText = ["__%1__ MSP is no longer contested","__%1__ MSP is contested"] select _isContested;
			_aarText = format[_aarText, _side];

			AAR_EVENT(_aarText,_msp,nil,nil);
			AAR_UPDATE(_msp,"Is contested",_isContested);
		};

		GVAR(contestedStatusHash) set [_side, _isContested];
		publicVariable QGVAR(contestedStatusHash);
		[QEGVAR(respawn,updateRespawnPointEH), [_side, !_isContested, _pos]] call CBA_fnc_serverEvent;

		private _whoToNotify = [_side, GVAR(contestedNotification)] call FUNC(whoToNotify);
		if (_whoToNotify isNotEqualTo [] ) then {

			private _text = if (_isContested) then {
				LLSTRING(FNC_Contested_hint)
			} else {
				LLSTRING(FNC_secured_hint)
			};
			[QEGVAR(main,doNotification), [_text], _whoToNotify] call CBA_fnc_targetEvent;
		};
	};
	[QGVAR(EH_mspStatusUpdate), [_side, _isContested, _oldContestedStatus, _enemiesInArea, _enemiesInAreaMin, _friendliesInArea]] call CBA_fnc_globalEvent;
	private _debugText = format ["Contested summary. Side: %1, NewStatus: %2, OldStatus: %3, enemyCount: %4, enemyCountMin: %5, FriendlyCount: %6",_side, _isContested, _oldContestedStatus, _enemiesInArea, _enemiesInAreaMin, _friendliesInArea];
	INFO(_debugText);
} else {
	if (_mspDeployementStatus) then {
		GVAR(deployementStatusHash) set [_side, false];
		publicVariable QGVAR(deployementStatusHash);
		GVAR(contestedStatusHash) set [_side, false];
		publicVariable QGVAR(contestedStatusHash);
		private _text = "MSP Object Disapeared" + str _side;
		ERROR(_text);
	};
};

EGVAR(respawn,allowRespawnHash) set [_side, _oldAllowRespawnStatus];
publicVariable QEGVAR(respawn,allowRespawnHash);