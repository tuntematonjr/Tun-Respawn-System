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

if (count _allunits > 0) then {
	REM(_allunits, _unit);

	[FUNC(contestedCheck), [_allunits, _delay], _delay] call CBA_fnc_waitAndExecute;
} else {
	[{ [] call FUNC(contestedSummary) }, [], _delay] call CBA_fnc_waitAndExecute;
};

private _checkDistance = {
	params ["_msp", "_unit", "_nearUnits"];

	private _distance = _unit distance _msp;
	private _unitIsNear = false;
	private _unitIsNearMin = false;

	if (_distance <= GVAR(contested_radius_max) ) then {

		_unitIsNear = true;

		//check minium contest
		if (_distance <= GVAR(contested_radius_min)) then {
			_unitIsNearMin = true;
		};
	};

	[_unitIsNear, _unitIsNearMin]
};

//todo muuta homma toimimaan unit arraylla

if ( GVAR(status_east) && { (GVAR(vehicle_east) != objNull) } ) then {
	private _returns = [GVAR(vehicle_east), _unit, GVAR(nearUnitsEast)] call _checkDistance;
	private _unitIsNear = _returns select 0;
	private _unitIsNearMin = _returns select 1;

	if (_unitIsNear &&  !(_unit in GVAR(nearUnitsEast)) ) then {

		GVAR(nearUnitsEast) pushBackUnique _unit;

		//check minium contest
		if (_unitIsNearMin) then {
			if ( !(_unit in GVAR(nearUnitsEastMin)) && side _unit != east ) then {
				GVAR(nearUnitsEastMin) pushBackUnique _unit;
			};
		} else {
			if ( !(_unit in GVAR(nearUnitsEastMin)) && side _unit != east ) then {
				REM(GVAR(nearUnitsEastMin), _unit)
			};
		};
	};

	//If units are not in range. Remove them from list if they are still there
	if !(_unitIsNear) then {
		if (_unit in GVAR(nearUnitsEast)) then {
			REM(GVAR(nearUnitsEast), _unit)
		};

		if (_unit in GVAR(nearUnitsEastMin)) then {
			REM(GVAR(nearUnitsEastMin), _unit)
		};	
	};
};

if ( GVAR(status_West) && { (GVAR(vehicle_west) != objNull) } ) then {

	private _returns = [GVAR(vehicle_west), _unit, GVAR(nearUnitsWest)] call _checkDistance;
	private _unitIsNear = _returns select 0;
	private _unitIsNearMin = _returns select 1;

	if (_unitIsNear &&  !(_unit in GVAR(nearUnitsWest)) ) then {

		GVAR(nearUnitsWest) pushBackUnique _unit;

		//check minium contest
		if (_unitIsNearMin) then {
			if ( !(_unit in GVAR(nearUnitsWestMin)) && side _unit != west ) then {
				GVAR(nearUnitsWestMin) pushBackUnique _unit;
			};
		} else {
			if (_unit in GVAR(nearUnitsWestMin) && side _unit != west ) then {
				REM(GVAR(nearUnitsWestMin), _unit)
			};
		};
	};

	//If units are not in range. Remove them from list if they are still there
	if !(_unitIsNear) then {
		if (_unit in GVAR(nearUnitsWest)) then {
			REM(GVAR(nearUnitsWest), _unit)
		};

		if (_unit in GVAR(nearUnitsWestMin)) then {
			REM(GVAR(nearUnitsWestMin), _unit)
		};	
	};
};

if ( GVAR(status_guer) && { (GVAR(vehicle_guer) != objNull) } ) then {
	private _returns = [GVAR(vehicle_guer), _unit, GVAR(nearUnitsGuer)] call _checkDistance;
	private _unitIsNear = _returns select 0;
	private _unitIsNearMin = _returns select 1;

	if (_unitIsNear &&  !(_unit in GVAR(nearUnitsGuer)) ) then {

		GVAR(nearUnitsGuer) pushBackUnique _unit;

		//check minium contest
		if (_unitIsNearMin) then {
			if ( !(_unit in GVAR(nearUnitsGuerMin)) && side _unit != resistance ) then {
				GVAR(nearUnitsGuerMin) pushBackUnique _unit;
			};
		} else {
			if (_unit in GVAR(nearUnitsGuerMin) && side _unit != resistance ) then {
				REM(GVAR(nearUnitsGuerMin), _unit)
			};
		};
	};

	//If units are not in range. Remove them from list if they are still there
	if !(_unitIsNear) then {
		if (_unit in GVAR(nearUnitsGuer)) then {
			REM(GVAR(nearUnitsGuer), _unit)
		};

		if (_unit in GVAR(nearUnitsGuerMin)) then {
			REM(GVAR(nearUnitsGuerMin), _unit)
		};	
	};
};

if ( GVAR(status_civ) && { (GVAR(vehicle_civ) != objNull) } ) then {
	private _returns = [GVAR(vehicle_civ), _unit, GVAR(nearUnitsCiv)] call _checkDistance;
	private _unitIsNear = _returns select 0;
	private _unitIsNearMin = _returns select 1;

	if (_unitIsNear &&  !(_unit in GVAR(nearUnitsCiv)) ) then {

		GVAR(nearUnitsCiv) pushBackUnique _unit;

		//check minium contest
		if (_unitIsNearMin) then {
			if ( !(_unit in GVAR(nearUnitsCivMin)) && side _unit != civilian ) then {
				GVAR(nearUnitsCivMin) pushBackUnique _unit;
			};
		} else {
			if (_unit in GVAR(nearUnitsCivMin) && side _unit != civilian ) then {
				REM(GVAR(nearUnitsCivMin), _unit)
			};
		};
	};

	//If units are not in range. Remove them from list if they are still there
	if !(_unitIsNear) then {
		if (_unit in GVAR(nearUnitsCiv)) then {
			REM(GVAR(nearUnitsCiv), _unit)
		};

		if (_unit in GVAR(nearUnitsCivMin)) then {
			REM(GVAR(nearUnitsCivMin), _unit)
		};	
	};
};