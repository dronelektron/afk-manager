static bool g_isActive[MAXPLAYERS + 1];
static int g_kickSeconds[MAXPLAYERS + 1];
static int g_moveSeconds[MAXPLAYERS + 1];
static bool g_isNotified[MAXPLAYERS + 1];

bool Client_IsActive(int client) {
    return g_isActive[client];
}

void Client_SetAsActive(int client) {
    g_isActive[client] = true;
}

void Client_SetAsInactive(int client) {
    g_isActive[client] = false;
}

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

bool Client_IsNotified(int client) {
    return g_isNotified[client];
}

void Client_SetNotified(int client, bool isNotified) {
    g_isNotified[client] = isNotified;
}
