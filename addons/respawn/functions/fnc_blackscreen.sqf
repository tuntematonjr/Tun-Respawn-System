/*
 * Author: [Tuntematon]
 * [Description]
 * Create black screen and text. Disables player moving during that time.
 *
 *
 * Arguments:
 * 0: Text <STRING>
 * 1: Duration <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Hi World", 15] call tunres_Respawn_fnc_blackscreen
 */
#include "script_component.hpp"
params [["_text",""],["_duration", 10]];

["",-1, -1, 1] spawn BIS_fnc_dynamicText;

[format ["<t color='#0800ff' size = '2'> %1</t>", _text],-1, -1, _duration] spawn BIS_fnc_dynamicText;

_camera = "camera" camCreate [(getPos player select 0),(getPos player select 1),100];
_camera cameraEffect ["internal","back"];
_camera camSetFov 0.700;
_camera camSetTarget player;
_camera camCommit 0;


[{camCommitted (_this select 2)}, {
	_this params ["_text", "_duration", "_camera"];

	playSound "scoreAdded";
	cutText["", "BLACK FADED", 999];

	[{
		player cameraEffect ["terminate","back"];
		camDestroy _camera;
		cutText["", "BLACK IN", 5];
	}, [], _duration] call CBA_fnc_waitAndExecute;

}, [_text, _duration, _camera]] call CBA_fnc_waitUntilAndExecute;