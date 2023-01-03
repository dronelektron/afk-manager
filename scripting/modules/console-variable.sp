static ConVar g_moveSeconds = null;
static ConVar g_moveMinPlayers = null;
static ConVar g_moveNotificationInterval = null;
static ConVar g_kickSeconds = null;
static ConVar g_kickMinPlayers = null;
static ConVar g_kickNotificationInterval = null;
static ConVar g_adminImmunityMode = null;
static ConVar g_playerImmunityMode = null;

void Variable_Create() {
    g_moveSeconds = CreateConVar("sm_afkmanager_move_seconds", "15", "After how many seconds to move the player to spectators");
    g_moveMinPlayers = CreateConVar("sm_afkmanager_move_min_players", "1", "Minimum number of players after which players will be moved to spectators");
    g_moveNotificationInterval = CreateConVar("sm_afkmanager_move_notification_interval", "5", "How often (in seconds, disable - 0) to notify the player about inactivity");
    g_kickSeconds = CreateConVar("sm_afkmanager_kick_seconds", "300", "After how many seconds to kick the player");
    g_kickMinPlayers = CreateConVar("sm_afkmanager_kick_min_players", "1", "Minimum number of players after which players will be kicked");
    g_kickNotificationInterval = CreateConVar("sm_afkmanager_kick_notification_interval", "30", "How often (in seconds, disable - 0) to notify the spectator about inactivity");
    g_adminImmunityMode = CreateConVar("sm_afkmanager_admin_immunity", "0", "Admin immunity (none - 0, move - 1, kick - 2, full - 3)");
    g_playerImmunityMode = CreateConVar("sm_afkmanager_player_immunity", "0", "Player immunity (none - 0, move - 1, kick - 2, full - 3)");
}

int Variable_MoveSeconds() {
    return g_moveSeconds.IntValue;
}

int Variable_MoveMinPlayers() {
    return g_moveMinPlayers.IntValue;
}

int Variable_MoveNotificationInterval() {
    return g_moveNotificationInterval.IntValue;
}

int Variable_KickSeconds() {
    return g_kickSeconds.IntValue;
}

int Variable_KickMinPlayers() {
    return g_kickMinPlayers.IntValue;
}

int Variable_KickNotificationInterval() {
    return g_kickNotificationInterval.IntValue;
}

int Variable_AdminImmunity() {
    return g_adminImmunityMode.IntValue;
}

int Variable_PlayerImmunity() {
    return g_playerImmunityMode.IntValue;
}
