#include "script_component.hpp"
//only executed on server

if (AAR_IS_ENABLED) then {
	LOG("AAR eventit tulille");
	[QGVAR(AAR_EventEH), {
		params ["_text","_instigator","_target","_poi"];
		[_text,_instigator,_target,_poi] call afi_aar2_fnc_addCustomEvent;
		LOG("AAR custom eventti lisätty");
	}] call CBA_fnc_addEventHandler;

	
	[QGVAR(AAR_UpdateEH), {
		params ["_obj","_varName","_value"];
		[_obj, _varName, _value] call afi_aar2_fnc_addcustomdata;
	}] call CBA_fnc_addEventHandler;
};