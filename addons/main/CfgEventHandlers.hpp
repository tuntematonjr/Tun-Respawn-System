class Extended_PostInit_EventHandlers {
    class ADDON {
        serverInit = QUOTE(call COMPILE_FILE(XEH_postInit_server));
        clientInit = QUOTE(call COMPILE_FILE(XEH_postInit_client));
    };
};