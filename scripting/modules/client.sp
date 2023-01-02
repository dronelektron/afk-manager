static bool g_isActive[MAXPLAYERS + 1];
static int g_seconds[MAXPLAYERS + 1];
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
    g_seconds[client] = 0;
}

int Client_GetSeconds(int client) {
    return g_seconds[client];
}

void Client_AddSeconds(int client) {
    g_seconds[client]++;
}

bool Client_IsNotified(int client) {
    return g_isNotified[client];
}

void Client_SetNotified(int client, bool isNotified) {
    g_isNotified[client] = isNotified;
}
