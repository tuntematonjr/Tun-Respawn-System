/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Unit Array <ARRAY>
 * 1: Delay between checks <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [allUnits, 5] call Tun_MSP_fnc_contestedCheck
 */
#include "script_component.hpp"

params ["_allunits", "_delay"];
private _unit = _allunits select 0;

LOG("ContestetCheck FNC initate" + (str [_allunits, _delay]));

if (count _allunits > 0) then {
	REM(_allunits, _unit);
	LOG("ContestetCheck FNC prepr next unit");
	[FUNC(contestedCheck), [_allunits, _delay], _delay] call CBA_fnc_waitAndExecute;
} else {
	[{ [] call FUNC(contestedSummary) }, [], _delay] call CBA_fnc_waitAndExecute;
};

if ( GVAR(status_east) && { (GVAR(vehicle_east) != objNull) } ) then {
	private _status = _unit getVariable [QGVAR(nearEast), false];
	private _statusMin = _unit getVariable [QGVAR(nearEastMin), false];
	private _distance = _unit distance GVAR(vehicle_east);
	private _isFriendly = [east, side _unit] call BIS_fnc_sideIsFriendly;

	if (_distance <= GVAR(contested_radius_max) ) then {
		if !(_status) then {
			if (_isFriendly) then {
				INC(GVAR(eastFriendlyCount));
			} else {
				INC(GVAR(eastEnemyCount));

				//check minium contest
				if (_distance <= GVAR(contested_radius_min)) then {
					if (!_statusMin) then {
					INC(GVAR(eastEnemyCountMin));
					_unit setVariable [QGVAR(nearEastMin), true];
					};
				} else {
					if (_statusMin) then {
						DEC(GVAR(eastEnemyCountMin));
						_unit setVariable [QGVAR(nearEastMin), false];
					};
				};
			};
			_unit setVariable [QGVAR(nearEast), true];
		};

	} else {
		if (_isFriendly && _status) then {
			DEC(GVAR(eastFriendlyCount));
			_unit setVariable [QGVAR(nearEast), false];
		} else {
			DEC(GVAR(eastEnemyCount));
			_unit setVariable [QGVAR(nearEast), false];
		};
		
		if (_statusMin) then {
			DEC(GVAR(eastEnemyCountMin));
			_unit setVariable [QGVAR(nearEastMin), false];
		};
	}; 
};

if ( GVAR(status_West) && { (GVAR(vehicle_west) != objNull) } ) then {
	private _status = _unit getVariable [QGVAR(nearWest), false];
	private _statusMin = _unit getVariable [QGVAR(nearWestMin), false];
	private _distance = _unit distance GVAR(vehicle_West);
	private _isFriendly = [West, side _unit] call BIS_fnc_sideIsFriendly;

	if (_distance <= GVAR(contested_radius_max) ) then {
		if !(_status) then {
			if (_isFriendly) then {
				INC(GVAR(westFriendlyCount));
			} else {
				INC(GVAR(westEnemyCount));

				//check minium contest
				if (_distance <= GVAR(contested_radius_min)) then {
					if (!_statusMin) then {
					INC(GVAR(westEnemyCountMin));
					_unit setVariable [QGVAR(nearWestMin), true];
					};
				} else {
					if (_statusMin) then {
						DEC(GVAR(westEnemyCountMin));
						_unit setVariable [QGVAR(nearWestMin), false];
					};
				};
			};
			_unit setVariable [QGVAR(nearWest), true];
		};
	} else {
		if (_isFriendly && _status) then {
			DEC(GVAR(westFriendlyCount));
			_unit setVariable [QGVAR(nearWest), false];
		} else {
				DEC(GVAR(westEnemyCount));
			_unit setVariable [QGVAR(nearWest), false];
		};
		
		if (_statusMin) then {
			DEC(GVAR(eastEnemyCountMin));
			_unit setVariable [QGVAR(nearWestMin), false];
		};
	}; 
};

if ( GVAR(status_guer) && { (GVAR(vehicle_guer) != objNull) } ) then {
	private _status = _unit getVariable [QGVAR(nearGuer), false];
	private _statusMin = _unit getVariable [QGVAR(nearGuerMin), false];
	private _distance = _unit distance GVAR(vehicle_guer);
	private _isFriendly = [resistance, side _unit] call BIS_fnc_sideIsFriendly;

	if (_distance <= GVAR(contested_radius_max) ) then {
		if !(_status) then {
			if (_isFriendly) then {
				INC(GVAR(guerFriendlyCount));
			} else {
				INC(GVAR(guerEnemyCount));

				//check minium contest
				if (_distance <= GVAR(contested_radius_min)) then {
					if (!_statusMin) then {
					INC(GVAR(guerEnemyCountMin));
					_unit setVariable [QGVAR(nearGuerMin), true];
					};
				} else {
					if (_statusMin) then {
						DEC(GVAR(guerEnemyCountMin));
						_unit setVariable [QGVAR(nearGuerMin), false];
					};
				};
			};
			_unit setVariable [QGVAR(nearGuer), true];
		};

	} else {
		if (_isFriendly && _status) then {
			DEC(GVAR(guerFriendlyCount));
			_unit setVariable [QGVAR(nearGuer), false];
		} else {
			DEC(GVAR(guerEnemyCount));
				_unit setVariable [QGVAR(nearGuer), false];
		};
		
		if (_statusMin) then {
			DEC(GVAR(eastEnemyCountMin));
			_unit setVariable [QGVAR(nearGuerMin), false];
		};
	}; 
};

if ( GVAR(status_civ) && { (GVAR(vehicle_civ) != objNull) } ) then {
	private _status = _unit getVariable [QGVAR(nearCiv), false];
	private _statusMin = _unit getVariable [QGVAR(nearCivMin), false];
	private _distance = _unit distance GVAR(vehicle_civ);
	private _isFriendly = [resistance, side _unit] call BIS_fnc_sideIsFriendly;

	//max contest range
	if (_distance <= GVAR(contested_radius_max) ) then {
		if !(_status) then {
			if (_isFriendly) then {
				INC(GVAR(civFriendlyCount));
			} else {

				INC(GVAR(civEnemyCount));

				//check minium contest
				if (_distance <= GVAR(contested_radius_min)) then {
					if (!_statusMin) then {
					INC(GVAR(civEnemyCountMin));
					_unit setVariable [QGVAR(nearCivMin), true];
					};
				} else {
					if (_statusMin) then {
						DEC(GVAR(civEnemyCountMin));
						_unit setVariable [QGVAR(nearCivMin), false];
					};
				};
			};            
			_unit setVariable [QGVAR(nearCiv), true];
		};

	} else {
		if (_isFriendly && _status) then {
			DEC(GVAR(civFriendlyCount));
			_unit setVariable [QGVAR(nearCiv), false];
		} else {
			DEC(GVAR(civEnemyCount));
			_unit setVariable [QGVAR(nearCiv), false];
		};
		
		if (_statusMin) then {
			DEC(GVAR(eastEnemyCountMin));
			_unit setVariable [QGVAR(nearCivMin), false];
		};
	}; 
};