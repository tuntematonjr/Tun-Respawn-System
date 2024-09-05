class Extended_PreInit_EventHandlers {
    class ADDON {
        serverInit = QUOTE(call COMPILE_FILE(XEH_preInit_server));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        clientInit = QUOTE(call COMPILE_FILE(XEH_postInit_client));
    };
};