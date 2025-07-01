/*
 * Author: [Tuntematon]
 * [Description]
 * Notify if ther is enemies inside max radius
 * Disable msp if there is more enemies than friendlies inside max range
 * Disable MSP if there is even one enemy in min range
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tunres_MSP_fnc_startContestedChecks
 */
#include "script_component.hpp"
params ["_side", "_start"];
if (!isServer) exitWith {};

if (_start) then {
	if (GVAR(contestCheckRunningHash) getOrDefault [_side, false]) exitWith {
		ERROR("Tried to start contested check, while it was already on!!");
	};

	private _values = GVAR(contestValuesHash) get _side;
	private _reportEnemiesInterval = _values select 0;
	private _contestedCheckInterval = _values select 4;
	private _reportEnemiesEnabled = _values select 5;

	private _handleContest = [{
		_args params ["_side"];
		if !(GVAR(disableContestedCheck)) then {
			private _mspDeployementStatus = GVAR(deployementStatusHash) get _side;
			if (_mspDeployementStatus) then {
				[_side] call FUNC(contestedCheck);
			} else {
				ERROR("Tried to run contested check, while msp was not deployed!!");
			};
		};
	}, _contestedCheckInterval, _side] call CBA_fnc_addPerFrameHandler;

	//Report enemies loop thing
	private _handleReport = nil;
	if (_reportEnemiesEnabled) then {
		_handleReport = [{
			_args params ["_side"];
			//So that this does not run, when contest update is offline
			if !(GVAR(disableContestedCheck)) then {
				private _side = _args;
				private _hash = GVAR(contestedCheckHash);
				private _contestedStatus = GVAR(contestedStatusHash) get _side;
				private _mspStatus = GVAR(deployementStatusHash) get _side;
				if (_mspStatus) then {
					private _enemyCount = (_hash get _side) select 0;
					if (_enemyCount > 0 && !_contestedStatus) then {
						private _whoToNotify = [_side, GVAR(reportEnemiesNotification)] call FUNC(whoToNotify);
						if (_whoToNotify isNotEqualTo [] ) then {
							[QEGVAR(main,doNotification), [(LLSTRING(FNC_enemies_near))], _whoToNotify] call CBA_fnc_targetEvent;
						};
					}; 
				} else {
					ERROR("Tried to run report enemies, while msp was not deployed!!");
				};
			};
		}, _reportEnemiesInterval, _side] call CBA_fnc_addPerFrameHandler;
	};
	GVAR(contestHandlesHash) set [_side,[_handleContest,_handleReport]];
} else {

	if !(GVAR(contestCheckRunningHash) getOrDefault [_side, false]) exitWith {
		ERROR("Tried to stop contested check, while it was already off!!");
	};

	private _values = GVAR(contestHandlesHash) get _side;
	{
		private _handle = _x;
		if (!isNil {_handle}) then {
			[_handle] call CBA_fnc_removePerFrameHandler;
		};
	} forEach _values;
};

GVAR(contestCheckRunningHash) set [_side, _start];
