/*
 * Author: [Tuntematon]
 * [Description]
 * Notify if ther is enemies inside max radius
 * Disable msp if there is more enemies than friendlies inside max range
 * Disable MSP if there is even one enemy in min range
 *
 * Arguments:
 * 0: The first argument <STRING>
 * 1: The second argument <OBJECT>
 * 2: Multiple input types <STRING|ARRAY|CODE>
 * 3: Optional input <BOOL> (default: true)
 * 4: Optional input with multiple types <CODE|STRING> (default: {true})
 * 5: Not mandatory input <STRING> (default: nil)
 *
 * Return Value:
 * The return value <BOOL>
 *
 * Example:
 * [west, _msp, ] call Tun_MSP_fnc_contested
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"

params [["_side", nil, [west]], ["_msp", nil, [objNull]], ["_sidemarker", nil, [""]], ["_contested_variable_str", nil, [""]]];

_msp_pos = getpos _msp;

_contested_status = missionNamespace getVariable _contested_variable_str;

_areaunits_max = (allUnits inAreaArray [_msp_pos, GVAR(contested_radius_max), GVAR(contested_radius_max)]);
_friendlycount = {[_side, side _x] call BIS_fnc_sideIsFriendly} count _areaunits_max;
_enemycount_max = {[_side, side _x] call BIS_fnc_sideIsEnemy} count _areaunits_max;
_side = _msp getVariable QGVAR(side);

_enemycount_min = {[_side, side _x] call BIS_fnc_sideIsEnemy} count (_areaunits_max inAreaArray [_msp_pos, GVAR(contested_radius_min), GVAR(contested_radius_min)]);


//if there is more enemis in max range or even one in min range. Disable MSP
if ( _friendlycount < _enemycount_max || _enemycount_min > 0) then {
    if (!_contested_status) then {
        missionNamespace setVariable [_contested_variable_str, true, true];
        localize "STR_Tun_MSP_FNC_Contested_hint" remoteExecCall ["hint", _side];

        [_side, false] call TUN_respawn_update_respawn_point;

        AAR_UPDATE(_msp,"Is contested", true);
    };
} else {
    if ( _contested_status ) then {
       missionNamespace setVariable [_contested_variable_str, false, true];
       localize "STR_Tun_MSP_FNC_secured_hint" remoteExecCall ["hint", _side];

       [_side, true, _msp_pos] call TUN_respawn_update_respawn_point;

       AAR_UPDATE(_msp,"Is contested", false);
    };
};




private tun_minValueChange = {

};

private tun_maxValueChange = {

};


GVAR(contested_statemachine) = [allUnits, true] call CBA_statemachine_fnc_create;



[GVAR(contested_statemachine), {}, {}, {}, "InMaxArea"] call CBA_statemachine_fnc_addState;
[GVAR(contested_statemachine), {}, {}, {}, "InMinArea"] call CBA_statemachine_fnc_addState;
[GVAR(contested_statemachine), {}, {}, {}, "NotInArea"] call CBA_statemachine_fnc_addState;



[GVAR(contested_statemachine), "NotInArea", "InMinArea", { GVAR(contested_radius_min) >= [_this] call FUNC(distanceToMsp) }, _makeUnitEditable] call CBA_statemachine_fnc_addTransition;
[GVAR(contested_statemachine), "NotInArea", "InMaxArea", { GVAR(contested_radius_max) >= [_this] call FUNC(distanceToMsp) }, _makeUnitEditable] call CBA_statemachine_fnc_addTransition;

[GVAR(contested_statemachine), "InMaxArea", "InMinArea", { GVAR(contested_radius_min) >= [_this] call FUNC(distanceToMsp) }, _makeUnitEditable] call CBA_statemachine_fnc_addTransition;
[GVAR(contested_statemachine), "InMaxArea", "NotInArea", { GVAR(contested_radius_max) < [_this] call FUNC(distanceToMsp) }, _makeUnitEditable] call CBA_statemachine_fnc_addTransition;

[GVAR(contested_statemachine), "InMinArea", "InMaxArea", { GVAR(contested_radius_min) < [_this] call FUNC(distanceToMsp) && GVAR(contested_radius_max) >= [_this] call FUNC(distanceToMsp) }, _makeUnitEditable] call CBA_statemachine_fnc_addTransition;
[GVAR(contested_statemachine), "InMinArea", "NotInArea", { GVAR(contested_radius_max) < [_this] call FUNC(distanceToMsp) }, _makeUnitEditable] call CBA_statemachine_fnc_addTransition;




GVAR(eastFriendlyCount) = 0;
GVAR(westFriendlyCount) = 0;
GVAR(guerFriendlyCount) = 0;
GVAR(civFriendlyCount) = 0;

GVAR(eastEnemyCount) = 0;
GVAR(westEnemyCount) = 0;
GVAR(guerEnemyCount) = 0;
GVAR(civEnemyCount) = 0;

GVAR(eastEnemyCountMin) = 0;
GVAR(westEnemyCountMin) = 0;
GVAR(guerEnemyCountMin) = 0;
GVAR(civEnemyCountMin) = 0;



private _contestedCheck = {
    private _unit = _this;

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
};



private _delay = 0;
private _increment = GVAR(contested_check_interval) / (count allUnits + 1);
{
    private _unit = _x;
    [_contestedCheck, _unit, _delay] call CBA_fnc_waitAndExecute;
    _delay = _delay + _increment;
} forEach allunits;

private _contestedSummary = {
    if ( GVAR(status_east) ) then {
        if (GVAR(vehicle_east) == objNull) then {
            GVAR(status_east) = false;
            ERROR("MSP Object Disapeared (EAST)");
        } else {
            //if there is more enemis in max range or even one in min range. Disable MSP
            if ( GVAR(eastEnemyCount) > GVAR(eastFriendlyCount) || GVAR(eastEnemyCountMin) > 0 ) then {

                if (!GVAR(status_east)) then {
                    missionNamespace setVariable [QGVAR(status_east), true, true];
                    localize "STR_Tun_MSP_FNC_Contested_hint" remoteExecCall ["hint", east];

                    [east, false] call TUN_respawn_update_respawn_point;

                    AAR_UPDATE(GVAR(vehicle_east),"Is contested", true);
                };
            } else {
                if ( GVAR(status_east) ) then {
                    missionNamespace setVariable [QGVAR(status_east), false, true];
                    localize "STR_Tun_MSP_FNC_secured_hint" remoteExecCall ["hint", east];

                    [east, true, (getPos GVAR(vehicle_east)) ] call TUN_respawn_update_respawn_point;

                    AAR_UPDATE(GVAR(vehicle_east),"Is contested", false);
                };
            };
        };
    };

    if ( GVAR(status_west) ) then {
        if (GVAR(vehicle_west) == objNull) then {
            GVAR(status_west) = false;
            ERROR("MSP Object Disapeared (WEST)");
        } else {
            //if there is more enemis in max range or even one in min range. Disable MSP
            if ( GVAR(westEnemyCount) > GVAR(westFriendlyCount) || GVAR(westEnemyCountMin) > 0 ) then {

                if (!GVAR(status_west)) then {
                    missionNamespace setVariable [QGVAR(status_west), true, true];
                    localize "STR_Tun_MSP_FNC_Contested_hint" remoteExecCall ["hint", west];

                    [west, false] call TUN_respawn_update_respawn_point;

                    AAR_UPDATE(GVAR(vehicle_west),"Is contested", true);
                };
            } else {
                if ( GVAR(status_west) ) then {
                    missionNamespace setVariable [QGVAR(status_west), false, true];
                    localize "STR_Tun_MSP_FNC_secured_hint" remoteExecCall ["hint", west];

                    [west, true, (getPos GVAR(vehicle_west)) ] call TUN_respawn_update_respawn_point;

                    AAR_UPDATE(GVAR(vehicle_west),"Is contested", false);
                };
            };
        };
    };

    if ( GVAR(status_guer) ) then {
        if (GVAR(vehicle_guer) == objNull) then {
            GVAR(status_guer) = false;
            ERROR("MSP Object Disapeared (RESISTANCE)");
        } else {
            //if there is more enemis in max range or even one in min range. Disable MSP
            if ( GVAR(guerEnemyCount) > GVAR(guerFriendlyCount) || GVAR(guerEnemyCountMin) > 0 ) then {

                if (!GVAR(status_guer)) then {
                    missionNamespace setVariable [QGVAR(status_guer), true, true];
                    localize "STR_Tun_MSP_FNC_Contested_hint" remoteExecCall ["hint", resistance];

                    [resistance, false] call TUN_respawn_update_respawn_point;

                    AAR_UPDATE(GVAR(vehicle_guer),"Is contested", true);
                };
            } else {
                if ( GVAR(status_guer) ) then {
                    missionNamespace setVariable [QGVAR(status_guer), false, true];
                    localize "STR_Tun_MSP_FNC_secured_hint" remoteExecCall ["hint", resistance];

                    [resistance, true, (getPos GVAR(vehicle_guer)) ] call TUN_respawn_update_respawn_point;

                    AAR_UPDATE(GVAR(vehicle_guer),"Is contested", false);
                };
            };
        };
    };

    if ( GVAR(status_civ) ) then {
        if (GVAR(vehicle_civ) == objNull) then {
            GVAR(status_civ) = false;
            ERROR("MSP Object Disapeared (CIVILIAN)");
        } else {
            //if there is more enemis in max range or even one in min range. Disable MSP
            if ( GVAR(civEnemyCount) > GVAR(civFriendlyCount) || GVAR(civEnemyCountMin) > 0 ) then {

                if (!GVAR(status_civ)) then {
                    missionNamespace setVariable [QGVAR(status_civ), true, true];
                    localize "STR_Tun_MSP_FNC_Contested_hint" remoteExecCall ["hint", civilian];

                    [civilian, false] call TUN_respawn_update_respawn_point;

                    AAR_UPDATE(GVAR(vehicle_civ),"Is contested", true);
                };
            } else {
                if ( GVAR(status_civ) ) then {
                    missionNamespace setVariable [QGVAR(status_civ), false, true];
                    localize "STR_Tun_MSP_FNC_secured_hint" remoteExecCall ["hint", civilian];

                    [civilian, true, (getPos GVAR(vehicle_civ)) ] call TUN_respawn_update_respawn_point;

                    AAR_UPDATE(GVAR(vehicle_civ),"Is contested", false);
                };
            };
        };
    };
};

[_contestedSummary, [], _delay] call CBA_fnc_waitAndExecute;