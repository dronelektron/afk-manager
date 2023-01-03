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

void MessageReply_AfkStatusUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_afkmanager_status <#userid|name>");
}

void MessageReply_AfkStatus(int client, int target, int seconds) {
    ReplyToCommand(client, "%s%t", PREFIX, "Afk status", target, seconds);
}

void MessageReply_ResetSecondsUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_afkmanager_reset_seconds <#userid|name>");
}

void Message_ResetSeconds(int client, int target) {
    ShowActivity2(client, PREFIX, "%t", "Reset seconds", target);
    LogMessage("\"%L\" reset seconds for \"%L\"", client, target);
}
