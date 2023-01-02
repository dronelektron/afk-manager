void MessagePrint_YouAreActive(int client) {
    CPrintToChat(client, "%s%t", PREFIX_COLORED, "You are active");
}

void MessagePrint_YouAreInactivePlayer(int client, int seconds) {
    CPrintToChat(client, "%s%t", PREFIX_COLORED, "You are inactive player", seconds);
}

void MessagePrint_YouAreInactiveSpectator(int client, int seconds) {
    CPrintToChat(client, "%s%t", PREFIX_COLORED, "You are inactive spectator", seconds);
}

void Message_PlayerMovedToSpectators(int client) {
    CPrintToChatAll("%s%t", PREFIX_COLORED, "Player moved to spectators", client);
    LogMessage("\"%L\" moved to spectators for inactivity", client);
}

void MessageLog_ClientKicked(int client) {
    LogMessage("\"%L\" kicked for inactivity", client);
}
