void MessagePrint_YouAreActive(int client) {
    PrintToChat(client, "%s%t", PREFIX, "You are active");
}

void MessagePrint_YouAreInactivePlayer(int client, int seconds) {
    PrintToChat(client, "%s%t", PREFIX, "You are inactive player", seconds);
}

void MessagePrint_YouAreInactiveSpectator(int client, int seconds) {
    PrintToChat(client, "%s%t", PREFIX, "You are inactive spectator", seconds);
}

void Message_PlayerMovedToSpectators(int client) {
    PrintToChatAll("%s%t", PREFIX, "Player moved to spectators", client);
    LogMessage("\"%L\" moved to spectators for inactivity", client);
}

void MessageLog_ClientKicked(int client) {
    LogMessage("\"%L\" kicked for inactivity", client);
}
