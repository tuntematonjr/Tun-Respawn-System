/*
 * Author: [Tuntematon]
 * [Description]
 *
 * Arguments:
 * 0: Side <SIDE>
 *
 * Return Value:
 * The return array who gets notification <ARRAY>
 *
 * Example:
 * [west] call tunres_MSP_fnc_whoToNotify
 */
#include "script_component.hpp"
params [["_side", nil, [west]], ["_type", 1]];
private _whoToNotify = [];
if (_type isEqualTo 0) then {
	{
		private _group = _x;
		private _leader = leader _group;
		if (side _group isEqualTo _side && {isPlayer _leader}) then {
			_whoToNotify pushBack _leader;
		};
	} forEach allGroups;
} else {
	_whoToNotify = [_side];
};

_whoToNotify