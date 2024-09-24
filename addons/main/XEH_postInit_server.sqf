#include "script_component.hpp"
//only executed on server

private _aarEnabled = !isNil "afi_aar2";
GVAR(AAR_Enabled) = _aarEnabled;
publicVariable QGVAR(AAR_Enabled);

if (_aarEnabled) then { 
	[QGVAR(AAR_EventEH), {
		params ["_text","_instigator","_target","_poi"];
		[_text,_instigator,_target,_poi] call afi_aar2_fnc_addCustomEvent;
	}] call CBA_fnc_addEventHandler;

	[QGVAR(AAR_UpdateEH), {
		params ["_obj","_varName","_value"];
		[_obj, _varName, _value] call afi_aar2_fnc_addcustomdata;
	}] call CBA_fnc_addEventHandler;
};