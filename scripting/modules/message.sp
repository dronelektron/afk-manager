void Message_InactivePlayer(int client, int seconds) {
    if (seconds < 60) {
        PrintToChat(client, COLOR_DEFAULT ... "%t%t", PREFIX_COLORED, INACTIVE_PLAYER, SECONDS, seconds);
    } else {
        int minutes = seconds / 60;

        seconds %= 60;

        if (seconds == 0) {
            PrintToChat(client, COLOR_DEFAULT ... "%t%t", PREFIX_COLORED, INACTIVE_PLAYER, MINUTES, minutes);
        } else {
            PrintToChat(client, COLOR_DEFAULT ... "%t%t", PREFIX_COLORED, INACTIVE_PLAYER, MINUTES_SECONDS, minutes, seconds);
        }
    }
}

void Message_InactiveSpectator(int client, int seconds) {
    if (seconds < 60) {
        PrintToChat(client, COLOR_DEFAULT ... "%t%t", PREFIX_COLORED, INACTIVE_SPECTATOR, SECONDS, seconds);
    } else {
        int minutes = seconds / 60;

        seconds %= 60;

        if (seconds == 0) {
            PrintToChat(client, COLOR_DEFAULT ... "%t%t", PREFIX_COLORED, INACTIVE_SPECTATOR, MINUTES, minutes);
        } else {
            PrintToChat(client, COLOR_DEFAULT ... "%t%t", PREFIX_COLORED, INACTIVE_SPECTATOR, MINUTES_SECONDS, minutes, seconds);
        }
    }
}

void Message_PlayerMovedToSpectators(int client) {
    PrintToChatAll(COLOR_DEFAULT ... "%t%t", PREFIX_COLORED, "Player moved to spectators", client);
    LogMessage("\"%L\" moved to spectators", client);
}

void Message_ClientKicked(int client) {
    PrintToChatAll(COLOR_DEFAULT ... "%t%t", PREFIX_COLORED, "Player kicked", client);
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
