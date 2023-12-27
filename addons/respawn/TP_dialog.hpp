//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

class RscListBox;
class RscButton;
class RscText;
class RscMapControl;

// Default grid
#define GUI_GRID_WAbs			((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs			(GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W			(GUI_GRID_WAbs / 40)
#define GUI_GRID_H			(GUI_GRID_HAbs / 25)
#define GUI_GRID_X			(safezoneX)
#define GUI_GRID_Y			(safezoneY + safezoneH - GUI_GRID_HAbs)

// Default text sizes
#define GUI_TEXT_SIZE_SMALL		(GUI_GRID_H * 0.8)
#define GUI_TEXT_SIZE_MEDIUM		(GUI_GRID_H * 1)
#define GUI_TEXT_SIZE_LARGE		(GUI_GRID_H * 1.2)

// Pixel grid
#define pixelScale	0.50
#define GRID_W (pixelW * pixelGrid * pixelScale)
#define GRID_H (pixelH * pixelGrid * pixelScale)

//GUI color
#define GUI_USER_COLORBACKGROUND	{ 		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])", 		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])", 		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])", 		1 	}

class TP_Dialog
{
	idd = 300000;
	
	class ControlsBackground
	{
		class tunres_respawn_tp_background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.3;
			y = safeZoneY + safeZoneH * 0.25;
			w = safeZoneW * 0.4;
			h = safeZoneH * 0.5;
			style = 0;
			text = "";
			colorBackground[] = {0.102, 0.102, 0.102, 0.8};
			colorText[] = {0.2431,0.1725,0.3333,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};
		
	};
	class Controls
	{
		class tunres_respawn_tp_list : RscListBox
		{
			idc = 300001;
			x = safeZoneX + safeZoneW * 0.325;
			y = safeZoneY + safeZoneH * 0.275;
			w = safeZoneW * 0.175;
			h = safeZoneH * 0.425;
			onLBSelChanged = "params ['_control', '_selectedIndex']; [_control, _selectedIndex] call tunres_Respawn_fnc_teleportOnLBSelChanged";
		};
		class tunres_respawn_tp_button : RscButton
		{
			idc = 300002;
			x = safeZoneX + safeZoneW * 0.625;
			y = safeZoneY + safeZoneH * 0.67592593;
			w = safeZoneW * 0.05;
			h = safeZoneH * 0.05;
			text = "$STR_tunres_Respawn_tp_dialog_button";
			action = "[] call tunres_Respawn_fnc_teleportButton";
			SizeEx = GUI_TEXT_SIZE_SMALL;
			colorBackground[] = GUI_USER_COLORBACKGROUND;
			colorFocused[] = GUI_USER_COLORBACKGROUND;
			colorFocused2[] = GUI_USER_COLORBACKGROUND;
			
		};		
		class tunres_respawn_tp_header : RscText
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.50520834;
			y = safeZoneY + safeZoneH * 0.27592593;
			w = safeZoneW * 0.1796875;
			h = safeZoneH * 0.08611112;
			style = 2;
			text = "$STR_tunres_Respawn_tp_dialog_header";
			colorBackground[] = GUI_USER_COLORBACKGROUND;
			colorText[] = {1,1,1,1};
			font = "TahomaB";
			SizeEx = GUI_TEXT_SIZE_LARGE;
			shadow = 2;
		};
		
		class tunres_respawn_tp_minimap : RscMapControl
		{
			idc = 300003;
			x = safeZoneX + safeZoneW * 0.51875;
			y = safeZoneY + safeZoneH * 0.375;
			w = safeZoneW * 0.1625;
			h = safeZoneH * 0.275;			
		};
	};
};