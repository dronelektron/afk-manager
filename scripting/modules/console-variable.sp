static ConVar g_moveSeconds = null;
static ConVar g_kickSeconds = null;
static ConVar g_adminImmunityMode = null;
static ConVar g_playerImmunityMode = null;

void Variable_Create() {
    g_moveSeconds = CreateConVar("sm_afkmanager_move_seconds", "5", "After how many seconds to move the player to spectators");
    g_kickSeconds = CreateConVar("sm_afkmanager_kick_seconds", "10", "After how many seconds to kick the player");
    g_adminImmunityMode = CreateConVar("sm_afkmanager_admin_immunity", "0", "Admin immunity (none - 0, move - 1, kick - 2, full - 3)");
    g_playerImmunityMode = CreateConVar("sm_afkmanager_player_immunity", "0", "Player immunity (none - 0, move - 1, kick - 2, full - 3)");
}

int Variable_MoveSeconds() {
    return g_moveSeconds.IntValue;
}

int Variable_KickSeconds() {
    return g_kickSeconds.IntValue;
}

int Variable_AdminImmunity() {
    return g_adminImmunityMode.IntValue;
}

int Variable_PlayerImmunity() {
    return g_playerImmunityMode.IntValue;
}
