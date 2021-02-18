//Exported via Arma Dialog Creator (https://github.com/kayler-renslow/arma-dialog-creator)

#include "GUIBaseClasses.hpp"
//"Default" call BIS_fnc_exportGUIBaseClasses;

class TP_Dialog
{
	idd = 300003;
	
	class ControlsBackground
	{
		class tun_respawn_tp_background
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.35;
			y = safeZoneY + safeZoneH * 0.4;
			w = safeZoneW * 0.3;
			h = safeZoneH * 0.35;
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
		class tun_respawn_tp_list : RscListBox
		{
			idc = 300001;
			x = safeZoneX + safeZoneW * 0.375;
			y = safeZoneY + safeZoneH * 0.425;
			w = safeZoneW * 0.175;
			h = safeZoneH * 0.3;
		};
		class tun_respawn_tp_button : RscButtonMenu
		{
			idc = 300002;
			x = safeZoneX + safeZoneW * 0.575;
			y = safeZoneY + safeZoneH * 0.675;
			w = safeZoneW * 0.05;
			h = safeZoneH * 0.05;
			text = "TP";
			action = "[] call Tun_Respawn_fnc_teleportButton";
		};		
		class tun_respawn_tp_header : RscText
		{
			idc = -1;
			x = safeZoneX + safeZoneW * 0.55520834;
			y = safeZoneY + safeZoneH * 0.42592593;
			w = safeZoneW * 0.0796875;
			h = safeZoneH * 0.18611112;
			style = ST_CENTER + ST_MULTI;
			text = "TUN Respawn Teleport hub WIP";
			colorBackground[] = {0.8,0.9647,0.1451,1};
			colorText[] = {0.2,0.0353,0.8549,1};
			font = "PuristaMedium";
			shadow = 0;
		};
		
	};
	
};
