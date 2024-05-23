class CfgVehicles
{
    class Logic;
    class Module_F: Logic
    {
        class AttributesBase
        {
            class Default;
            class Edit; // Default edit box (i.e., text input field)
            class Combo; // Default combo box (i.e., drop-down menu)
            class Checkbox; // Default checkbox (returned value is Bool)
            class CheckboxNumber; // Default checkbox (returned value is Number)
            class ModuleDescription; // Module description
            class Units; // Selection of units on which the module is applied
        };
        // Description base classes, for more information see below
        class ModuleDescription
        {
            class AnyBrain;
        };
    };
    
    class GVAR(moduleWaitingArea): Module_F
    {
        scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
        scopeCurator = 1;
        displayName = "$STR_tunres_Respawn_Module_DisplayName_WaitingArea"; // Name displayed in the menu
        icon = "\a3\modules_f_curator\data\portraitcountdown_ca.paa"; // Map icon. Delete this entry to use the default icon
        category = "tunres_Respawn";

        // Name of function triggered once conditions are met
        function = QFUNC(moduleWaitingArea);
        // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
        functionPriority = 10;
        // 0 for server only execution, 1 for global execution, 2 for persistent global execution
        isGlobal = 0;
        // 1 for module waiting until all synced triggers are activated
        isTriggerActivated = 0;
        // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
        isDisposable = 1;
        // // 1 to run init function in Eden Editor as well
        is3DEN = 0;

        // Module attributes, uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific
        class Attributes: AttributesBase
        {
            class respawn_side: Combo
            {
                property = QGVAR(module_side);
                displayName = "Side"; // Argument label
                tooltip = "$STR_tunres_Respawn_Module_tooltip_WaitingArea"; // Tooltip description
                typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "0"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
                class Values
                {
                    class none  {name = "none";  value = "none";}; // Listbox item
                    class west {name = "west"; value = "respawn_west";};
                    class east {name = "east"; value = "respawn_east";};
                    class resistance {name = "resistance"; value = "respawn_guerrila";};
                    class civilian {name = "civilian"; value = "respawn_civilian";};
                };
            };
            class flag_texture: Edit
            {
                property = QGVAR(flag_texture);
				displayName = "Flag texture";
				tooltip = "$STR_tunres_Respawn_Module_tooltip_flagTexture";
                typeName = "STRING";
				// Default text filled in the input box
				// Because it is an expression, to return a String one must have a string within a string
				defaultValue = """""";
            };
            class ModuleDescription: ModuleDescription{};
        };
        class ModuleDescription: ModuleDescription
        {
            description = "$STR_tunres_Respawn_Module_Description_Waitingarea"; // Short description, will be formatted as structured text
            sync[] = {}; // Array of synced entities (can contain base classes)
        };
    };

    class GVAR(moduleRespawnPoint): GVAR(moduleWaitingArea)
    {
        displayName = "$STR_tunres_Respawn_Module_DisplayName_SpawnPoint"; // Name displayed in the menu
        icon = "\a3\modules_f\data\portraitrespawn_ca.paa";
        // Name of function triggered once conditions are met
        function = QFUNC(moduleRespawnPoint);

        class Attributes: AttributesBase
        {
            class respawn_side: Combo
            {
                property = QGVAR(module_side);
                displayName = "Side"; // Argument label
                tooltip = "$STR_tunres_Respawn_Module_tooltip_SpawnPoint"; // Tooltip description
                typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "0"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
                class Values
                {
                    class none  {name = "none";  value = "none";}; // Listbox item
                    class west {name = "west"; value = MARKER_NAME_CONFIG(west);};
                    class east {name = "east"; value = MARKER_NAME_CONFIG(east);};
                    class resistance {name = "resistance"; value = MARKER_NAME_CONFIG(resistance);};
                    class civilian {name = "civilian"; value = MARKER_NAME_CONFIG(civilian);};
                };
            };
            class flag_texture: Edit
            {
                property = QGVAR(flag_texture);
				displayName = "Flag texture";
				tooltip = "$STR_tunres_Respawn_Module_tooltip_flagTexture";
                typeName = "STRING";
				// Default text filled in the input box
				// Because it is an expression, to return a String one must have a string within a string
				defaultValue = """""";
            };
            class ModuleDescription: ModuleDescription{};
        };
        class ModuleDescription: ModuleDescription
        {
            description = "$STR_tunres_Respawn_Module_Description_Spawn_Point"; // Short description, will be formatted as structured text
            sync[] = {}; // Array of synced entities (can contain base classes)
        };
    };

    class GVAR(moduleTeleportPoint): GVAR(moduleWaitingArea)
    {
        displayName = "$STR_tunres_Respawn_Module_DisplayName_teleportPoint"; // Name displayed in the menu
        // 0 for server only execution, 1 for global execution, 2 for persistent global execution
        isGlobal = 2;
        // 1 for module waiting until all synced triggers are activated
        //isTriggerActivated = 1;
        // Name of function triggered once conditions are met
        function = QFUNC(moduleTeleport);
        icon = "\a3\ui_f\data\map\groupicons\badge_gs.paa";

        class Attributes: AttributesBase
        {

            class GVAR(teleportPointOBJ): Edit
            {
                property = QGVAR(teleportPointOBJ);
				displayName = "Teleport point object";
				tooltip = "$STR_tunres_Respawn_Module_tooltip_teleportPointOBJ";
                typeName = "STRING";
				// Default text filled in the input box
				// Because it is an expression, to return a String one must have a string within a string
				defaultValue = """Land_Sleeping_bag_blue_folded_F""";
            };

            class GVAR(teleportConditio): Edit
            {
                property = QGVAR(teleportConditio);
				displayName = "Teleport conditio";
				tooltip = "$STR_tunres_Respawn_Module_tooltip_teleportConditio";
                typeName = "STRING";
				// Default text filled in the input box
				// Because it is an expression, to return a String one must have a string within a string
				defaultValue = "true";
            };

            class GVAR(teleportName): Edit
            {
                property = QGVAR(teleportName);
				displayName = "Teleport name";
				tooltip = "$STR_tunres_Respawn_Module_tooltip_teleportName";
                typeName = "STRING";
				// Default text filled in the input box
				// Because it is an expression, to return a String one must have a string within a string
				defaultValue = """Name""";
            };

            class GVAR(teleportCreateMarker): Checkbox
            {
                property = QGVAR(teleportCreateMarker);
				displayName = "Create Marker";
                typeName = "BOOL";
				tooltip = "$STR_tunres_Respawn_Module_tooltip_teleportCreateMarker";
				defaultValue = "true";
            };

            class GVAR(teleportMarkerIcone): Edit
            {
                property = QGVAR(teleportMarkerIcone);
				displayName = "Marker Icon";
				tooltip = "$STR_tunres_Respawn_Module_tooltip_teleportMarkerIcone";
                typeName = "STRING";
				// Default text filled in the input box
				// Because it is an expression, to return a String one must have a string within a string
				defaultValue = """hd_start""";
            };

            class GVAR(teleportMenuOpenConditio): Edit
            {
                property = QGVAR(teleportMenuOpenConditio);
				displayName = "Menu open conditio";
                typeName = "STRING";
				tooltip = "$STR_tunres_Respawn_Module_tooltip_teleportMenuOpenConditio";
				defaultValue = """true""";
            };
            
            class GVAR(teleportUseAceAction): Checkbox
            {
                property = QGVAR(teleportUseAceAction);
				displayName = "Use Ace Actions";
                typeName = "BOOL";
				tooltip = "$STR_tunres_Respawn_Module_tooltip_teleportUseAceAction";
				defaultValue = "true";
            };

            class GVAR(teleportCheckTickets): Checkbox
            {
                property = QGVAR(teleportCheckTickets);
				displayName = "Allow Check Tickets";
                typeName = "BOOL";
				//tooltip = $STR_tunres_Respawn_Module_tooltip_teleportCreateMarker;
				defaultValue = "false";
            };

            class GVAR(teleportEnableWest): Checkbox
            {
                property = QGVAR(teleportEnableWest);
				displayName = "Enable West";
                typeName = "BOOL";
				tooltip = "$STR_tunres_Respawn_Module_tooltip_teleportEnableSides";
				defaultValue = "false";
            };

            class GVAR(teleportEnableEast): GVAR(teleportEnableWest)
            {
                property = QGVAR(teleportEnableEast);
				displayName = "Enable East";
            };

            class GVAR(teleportEnableResistance): GVAR(teleportEnableWest)
            {
                property = QGVAR(teleportEnableResistance);
				displayName = "Enable Resistance";
            };

            class GVAR(teleportEnableCivilian): GVAR(teleportEnableWest)
            {
                property = QGVAR(teleportEnableCivilian);
				displayName = "Enable Civilian";
            };

            class ModuleDescription: ModuleDescription{};
        };
        class ModuleDescription: ModuleDescription
        {
            description = "$STR_tunres_Respawn_Module_Description_Spawn_Point"; // Short description, will be formatted as structured text
            position = 1; // Position is taken into effect
            direction = 0; // Direction is taken into effect
            optional = 1; // Synced entity is optional
            duplicate = 1; // Multiple entities of this type can be synced
        };
    };
};