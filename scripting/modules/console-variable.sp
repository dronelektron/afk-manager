static ConVar g_moveSeconds = null;
static ConVar g_kickSeconds = null;

void Variable_Create() {
    g_moveSeconds = CreateConVar("sm_afkmanager_move_seconds", "5", "After how many seconds to move the player to spectators");
    g_kickSeconds = CreateConVar("sm_afkmanager_kick_seconds", "10", "After how many seconds to kick the player");
}

int Variable_MoveSeconds() {
    return g_moveSeconds.IntValue;
}

int Variable_KickSeconds() {
    return g_kickSeconds.IntValue;
}
