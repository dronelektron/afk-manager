void Message_InactivePlayer(int client, int seconds) {
    CPrintToChat(client, "%t%t", PREFIX_COLORED, "Inactive player", seconds);
}

void Message_InactiveSpectator(int client, int seconds) {
    CPrintToChat(client, "%t%t", PREFIX_COLORED, "Inactive spectator", seconds);
}

void Message_PlayerMovedToSpectators(int client) {
    CPrintToChatAll("%t%t", PREFIX_COLORED, "Player moved to spectators", client);
    LogMessage("\"%L\" moved to spectators", client);
}

void Message_ClientKicked(int client) {
    LogMessage("\"%L\" kicked", client);
}

void Message_AfkStatusUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_afkmanager_status <#userid|name>");
}

void Message_AfkStatus(int client, int target, int seconds) {
    ReplyToCommand(client, "%s%t", PREFIX, "Afk status", target, seconds);
}

void Message_ResetSecondsUsage(int client) {
    ReplyToCommand(client, "%s%s", PREFIX, "Usage: sm_afkmanager_reset_seconds <#userid|name>");
}

void Message_ResetSeconds(int client, int target) {
    ShowActivity2(client, PREFIX, "%t", "Reset seconds", target);
    LogMessage("\"%L\" reset seconds for \"%L\"", client, target);
}
