#include "script_component.hpp"

class CfgPatches
{
    class Tun_Respawn
    {
        units[] = {"Tun_Respawn_Module_waitingarea", "Tun_Respawn_Module_Respawn_point"};
        weapons[] = {};
        requiredVersion = 1.94;
        requiredAddons[] = {"A3_Modules_F","3DEN","cba_main","cba_xeh","cba_settings","ace_interaction","ace_interact_menu"};
        author = "Tuntematon";
        authorUrl = "https://armafinland.fi/";
    };
};

class CfgFactionClasses
{
    class NO_CATEGORY;
    class Tun_Respawn : NO_CATEGORY
    {
        displayName = $STR_Tun_Respawn_Module_category;
    };
};


class Extended_PostInit_EventHandlers {
    class Tun_Respawn {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_PreInit_EventHandlers {
    class Tun_Respawn {
        init = QUOTE( call COMPILE_FILE(XEH_preInit) );
    };
};

class Extended_PreStart_EventHandlers {
    class Tun_Respawn {
        init = QUOTE( call COMPILE_FILE(XEH_preStart) );
    };
};


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
    class Tun_Respawn_Module_waitingarea: Module_F
    {
        scope = 2; // Editor visibility; 2 will show it in the menu, 1 will hide it.
        scopeCurator = 1;
        displayName = $STR_Tun_Respawn_Module_DisplayName_WaitingArea; // Name displayed in the menu
        //icon = "x\Bum\addons\BlindZeus\UI\Portraits\blindcurator.paa"; // Map icon. Delete this entry to use the default icon
        category = "Tun_Respawn";

        // Name of function triggered once conditions are met
        function = QFUNC(module_waitingarea);
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
                property = "Tun_respawn_module_waiting_area_side";
                displayName = "Side"; // Argument label
                tooltip = $STR_Tun_Respawn_Module_tooltip_WaitingArea; // Tooltip description
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
            class ModuleDescription: ModuleDescription{};
        };
        class ModuleDescription: ModuleDescription
        {
            description = $STR_Tun_Respawn_Module_Description_Waitingarea; // Short description, will be formatted as structured text
            sync[] = {}; // Array of synced entities (can contain base classes)
        };
    };

    class Tun_Respawn_Module_Respawn_point: Tun_Respawn_Module_waitingarea
    {
        displayName = $STR_Tun_Respawn_Module_DisplayName_SpawnPoint; // Name displayed in the menu

        // Name of function triggered once conditions are met
        function = QFUNC(module_respawnpos);

        class Attributes: AttributesBase
        {
            class respawn_side: Combo
            {
                property = "Tun_respawn_module_respawn_point_side";
                displayName = "Side"; // Argument label
                tooltip = $STR_Tun_Respawn_Module_tooltip_SpawnPoint; // Tooltip description
                typeName = "STRING"; // Value type, can be "NUMBER", "STRING" or "BOOL"
                defaultValue = "0"; // Default attribute value. WARNING: This is an expression, and its returned value will be used (50 in this case)
                class Values
                {
                    class none  {name = "none";  value = "none";}; // Listbox item
                    class west {name = "west"; value = "tun_respawn_west";};
                    class east {name = "east"; value = "tun_respawn_east";};
                    class resistance {name = "resistance"; value = "tun_respawn_guerrila";};
                    class civilian {name = "civilian"; value = "tun_respawn_civilian";};
                };
            };
            class ModuleDescription: ModuleDescription{};
        };
        class ModuleDescription: ModuleDescription
        {
            description = $STR_Tun_Respawn_Module_Description_Spawn_Point; // Short description, will be formatted as structured text
            sync[] = {}; // Array of synced entities (can contain base classes)
        };
    };
};