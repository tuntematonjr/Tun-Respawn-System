/*
 * Author: [Tuntematon]
 * [Description]
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
 * ["something", player] call TUN_Respawn_fnc_imanexample
 *
 * Public: [Yes/No]
 */
#include "script_component.hpp"
params [["_text",""],["_duration", 10]];

["",-1, -1, 1] spawn BIS_fnc_dynamicText;

[format ["<t color='#0800ff' size = '2'> %1</t>", _text],-1, -1, _duration] spawn BIS_fnc_dynamicText;

_camera = "camera" camCreate [(getPos player select 0),(getPos player select 1),100];
_camera cameraEffect ["internal","back"];
_camera camSetFOV 0.700;
_camera camSetTarget player;
_camera camCommit 0;


[{camCommitted (_this select 2)}, {
	_this params ["_text", "_duration", "_camera"];

	playSound "scoreAdded";
	cutText["", "BLACK FADED", 999];
	//["<t color='#0800ff' size = '2'>"+ _text +"</t>",-1, -1, _duration] spawn BIS_fnc_dynamicText;

	[{
		player cameraEffect ["terminate","back"];
		camDestroy _camera;
		cutText["", "BLACK IN", 5];
	}, [], _duration] call CBA_fnc_waitAndExecute;

}, [_text, _duration, _camera]] call CBA_fnc_waitUntilAndExecute;


