<a href="https://armafinland.fi/"><img src="https://armafinland.fi/logot/armafin-logo-200px.png" title="Armafinland" alt="Armafinland"></a>


# TUN Respawn System
![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/tuntematonjr/Tun-Respawn-System?include_prereleases)


[Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2055674861)

> Wave Respawn system with customizability for every mission needs.
> Additionally there is Mobile Respawn Point vehicle which allow moving respawn point around map

**Required Mods**

- [CBA](https://github.com/CBATeam/CBA_A3)

- [ACE3](https://github.com/acemod/ACE3)

---

## Features/Settings

**Respawn system**
- Ability to use gearscript or let this system to save starting gear.
- Currently 2 types of respawn systems: Infinite waves or side-based tickets. (Planned to implement ticket system for players, e.g., all players have 3 tickets)
- Customize time between waves for every side.
- Players who are waiting respawn are in "waiting" area where they can talk each other.
- All settings are in CBA settings.
- Waiting areas and Spawn points are placed with modules.
- Support all 4 sides.
- TFAR support to save radio settings.
- Teleport network system

**Mobile Spawn Point (MSP)**
- Each side can have vehicle type what is used to move spawn point to battlefield.
- There is contest system for MSP. There are currently 2 ways to MSP become contested (disabled): 1. There is more enemies in max range. 2. There is even 1 enemy in min range. Both ranges can be changed in settings.
- There is warning system if there is enemies near MSP.
- You can teleport between "main base" and MSP. But you can only move to MSP if it's not contested.

---

## Usage

### Setting Up Respawn
1. In the Arma 3 Editor, place the following modules from the "Tun Respawn" category:
   - **Waiting Area**: Defines where players wait during respawn.
   - **Respawn Point**: Sets spawn locations.
   - **Teleport Point**: Adds teleport destinations.
2. Configure settings via CBA Settings in-game or in the editor.
3. Choose respawn type: Infinite waves or side-based tickets.

### Mobile Spawn Point (MSP)
- Assign MSP vehicles per side in settings.
- Deploy MSP to move respawn points dynamically.
- MSP becomes contested if enemies are detected in configured ranges, disabling respawn.

For detailed configuration, refer to CBA settings in-game.

---

## License

[![License](https://www.bohemia.net/assets/img/licenses/APL-SA.png)](https://www.bohemia.net/community/licenses/arma-public-license-share-alike)

- **[APL-SA](https://www.bohemia.net/community/licenses/arma-public-license-share-alike)**
