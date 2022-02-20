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
#include "script_component.hpp"

private _debugTime = diag_tickTime;

private _countestedRangeMax = GVAR(contested_radius_max);
private _countestedRangeMin = GVAR(contested_radius_min);
	
if ( GVAR(status_east) && { (GVAR(vehicle_east) != objNull) } ) then {
	private _pos = getPosWorld GVAR(vehicle_east);
	private _unitsInArea = allUnits inAreaArray [_pos, _countestedRangeMax, _countestedRangeMax, 0, false, (_countestedRangeMax/2)];
	private _unitsInAreaMin = _unitsInArea inAreaArray [_pos, _countestedRangeMin, _countestedRangeMin, 0, false, (_countestedRangeMin/2)];
	_unitsInArea = _unitsInArea select { (side _x) in [west,east,resistance,civilian] };
	_unitsInAreaMin = _unitsInAreaMin select { (side _x) in [west,east,resistance,civilian] };
	GVAR(nearUnitsEast) = _unitsInArea;
	GVAR(nearUnitsEastMin) = _unitsInAreaMin;
};

if ( GVAR(status_West) && { (GVAR(vehicle_west) != objNull) } ) then {
	private _pos = getPosWorld GVAR(vehicle_west);
	private _unitsInArea = allUnits inAreaArray [_pos, _countestedRangeMax, _countestedRangeMax, 0, false, (_countestedRangeMax/2)];
	private _unitsInAreaMin = _unitsInArea inAreaArray [_pos, _countestedRangeMin, _countestedRangeMin, 0, false, (_countestedRangeMin/2)];
	_unitsInArea = _unitsInArea select { (side _x) in [west,east,resistance,civilian] };
	_unitsInAreaMin = _unitsInAreaMin select { (side _x) in [west,east,resistance,civilian] };
	GVAR(nearUnitsWest) = _unitsInArea;
	GVAR(nearUnitsWestMin) = _unitsInAreaMin;
};

if ( GVAR(status_guer) && { (GVAR(vehicle_guer) != objNull) } ) then {
	private _pos = getPosWorld GVAR(vehicle_guer);
	private _unitsInArea = allUnits inAreaArray [_pos, _countestedRangeMax, _countestedRangeMax, 0, false, (_countestedRangeMax/2)];
	private _unitsInAreaMin = _unitsInArea inAreaArray [_pos, _countestedRangeMin, _countestedRangeMin, 0, false, (_countestedRangeMin/2)];
	_unitsInArea = _unitsInArea select { (side _x) in [west,east,resistance,civilian] };
	_unitsInAreaMin = _unitsInAreaMin select { (side _x) in [west,east,resistance,civilian] };
	GVAR(nearUnitsGuer) = _unitsInArea;
	GVAR(nearUnitsGuerMin) = _unitsInAreaMin;
};

if ( GVAR(status_civ) && { (GVAR(vehicle_civ) != objNull) } ) then {
	private _pos = getPosWorld GVAR(vehicle_civ);
	private _unitsInArea = allUnits inAreaArray [_pos, _countestedRangeMax, _countestedRangeMax, 0, false, (_countestedRangeMax/2)];
	private _unitsInAreaMin = _unitsInArea inAreaArray [_pos, _countestedRangeMin, _countestedRangeMin, 0, false, (_countestedRangeMin/2)];
	_unitsInArea = _unitsInArea select { (side _x) in [west,east,resistance,civilian] };
	_unitsInAreaMin = _unitsInAreaMin select { (side _x) in [west,east,resistance,civilian] };
	GVAR(nearUnitsCiv) = _unitsInArea;
	GVAR(nearUnitsCivMin) = _unitsInAreaMin;
};

[] call FUNC(contestedSummary);

private _debugText = format ["Contested check spent time: %1", (diag_tickTime -_debugTime) ];
LOG(_debugText);