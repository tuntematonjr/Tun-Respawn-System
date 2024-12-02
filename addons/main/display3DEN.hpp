class ctrlMenuStrip;
class display3DEN {
	class Controls {
		class MenuStrip: ctrlMenuStrip {
			class Items {
				class Tools {
					items[] += {QGVAR(commonToolFolder)};
				};
				class GVAR(commonToolFolder) {
					text = "Tun respawn tools";
					picture = QPATHTOF(data\afilogo.paa);
					items[] = {QGVAR(commonSettingsRespawn)}; // ADD ALL TOOLS HERE
				};
				class GVAR(commonSettingsRespawn) {
					text = "Update Mission Settings for respawn";
					action = QUOTE([] call FUNC(updateSettings););
				};
			};
		};
	};
};