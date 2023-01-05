static int g_kickSeconds[MAXPLAYERS + 1];
static int g_moveSeconds[MAXPLAYERS + 1];

void Client_ResetSeconds(int client) {
    g_kickSeconds[client] = 0;
    g_moveSeconds[client] = 0;
}

int Client_GetKickSeconds(int client) {
    return g_kickSeconds[client];
}

void Client_AddKickSeconds(int client) {
    g_kickSeconds[client]++;
}

int Client_GetMoveSeconds(int client) {
    return g_moveSeconds[client];
}

void Client_AddMoveSeconds(int client) {
    g_moveSeconds[client]++;
}
