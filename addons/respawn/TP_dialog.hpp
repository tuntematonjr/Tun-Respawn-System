//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

class GVAR(TP_Dialog)
{
	idd = 300000;
	
	class ControlsBackground
	{
		class GVAR(tp_background) : RscBackgroundGUI
		{
			idc = -1;
			x = "safeZoneX + safeZoneW * 0.345275";
			y = "safeZoneY + safeZoneH * 0.247078";
			w = "safeZoneW * 0.309451";
			h = "safeZoneH * 0.505844";
			colorBackground[] = {GUI_BCG_MENU_RGB, 0.9};
		};
		
	};
	class Controls
	{
		class GVAR(tp_list) : RscListBox
		{
			idc = 300001;
			x = "safeZoneX + safeZoneW * 0.365905";
			y = "safeZoneY + safeZoneH * 0.291065";
			w = "safeZoneW * 0.113465";
			h = "safeZoneH * 0.417871";
			onLBSelChanged = QUOTE(ARR_3(params ['_control','_selectedIndex']; [_control,_selectedIndex] call FUNC(teleportOnLBSelChanged);));
			colorBackground[] = {0.302, 0.302, 0.302, 1};
		};
		class GVAR(tp_button) : RscButton
		{
			idc = 300002;
			x = "safeZoneX + safeZoneW * 0.58252";
			y = "safeZoneY + safeZoneH * 0.66495";
			w = "safeZoneW * 0.0515752";
			h = "safeZoneH * 0.0439865";
			text = "$STR_tunres_Respawn_tp_dialog_button";
			action = QUOTE([] spawn FUNC(teleportButton););
			SizeEx = QUOTE(GUI_TEXT_SIZE_SMALL);
			colorBackground[] = GUI_BCG_COLOR;
			colorFocused[] = GUI_BCG_COLOR;
			colorFocused2[] = GUI_BCG_COLOR;
			
		};		
		class GVAR(tp_header) : RscTitle
		{
			idc = -1;
			x = "safeZoneX + safeZoneW * 0.489685";
			y = "safeZoneY + safeZoneH * 0.291064";
			w = "safeZoneW * 0.144411";
			h = "safeZoneH * 0.0659797";
			style = ST_CENTER;
			text = "$STR_tunres_Respawn_tp_dialog_header";
			sizeEx = QUOTE(GUI_TEXT_SIZE_LARGE);
			colorText[] = GUI_TITLETEXT_COLOR;
			colorBackground[] = GUI_BCG_COLOR;
			font = "TahomaB";
			shadow = 2;
		};
		
		class GVAR(tp_minimap) : RscMapControl
		{
			idc = 300003;
			x = "safeZoneX + safeZoneW * 0.489685";
			y = "safeZoneY + safeZoneH * 0.379036";
			w = "safeZoneW * 0.144411";
			h = "safeZoneH * 0.263919";			
		};
	};
};