class Extended_PostInit_EventHandlers {
	class ADDON {
		serverInit = QUOTE(call COMPILE_FILE(XEH_postInit_server));
		clientInit = QUOTE(call COMPILE_FILE(XEH_postInit_client));
	};
};
class Extended_PreStart_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preStart));
	};
};

class Extended_PreInit_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};
