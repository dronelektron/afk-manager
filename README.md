# AFK manager

Allows you to manage players who are inactive

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/afk-manager/releases) (compiled for SourceMod 1.11)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_afkmanager_move_seconds - After how many seconds to move the player to spectators [default: "5"]
* sm_afkmanager_move_min_players - Minimum number of players after which players will be moved to spectators [default: "1"]
* sm_afkmanager_kick_seconds - After how many seconds to kick the player [default: "10"]
* sm_afkmanager_kick_min_players - Minimum number of players after which players will be kicked [default: "1"]
* sm_afkmanager_admin_immunity - Admin immunity [default: "0"]
* sm_afkmanager_player_immunity - Player immunity [default: "0"]

##### AFK Immunity

* None - 0
* Move - 1
* Kick - 2
* Full - 3

### Console Commands

* sm_afkmanager_status <#userid|name> - Check AFK status of the player
