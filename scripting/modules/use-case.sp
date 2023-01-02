static Handle g_afkTimer = null;

void UseCase_ResetAfkTimer() {
    g_afkTimer = null;
}

void UseCase_OnClientActive(int client) {
    Client_SetAsActive(client);
    MessagePrint_YouAreActive(client);
}

void UseCase_OnClientInactive(int client) {
    Client_SetAsInactive(client);
    Client_ResetSeconds(client);
    Client_SetNotified(client, NOTIFIED_NO);
    UseCase_CreateAfkTimer();
}

void UseCase_CreateAfkTimer() {
    if (g_afkTimer == null) {
        g_afkTimer = CreateTimer(AFK_TIMER_INTERVAL, UseCaseTimer_InactiveClients, _, AFK_TIMER_FLAGS);
    }
}

public Action UseCaseTimer_InactiveClients(Handle timer) {
    int inactiveClientsAmount = 0;

    for (int client = 1; client <= MaxClients; client++) {
        if (!IsClientInGame(client) || Client_IsActive(client)) {
            continue;
        }

        inactiveClientsAmount++;

        UseCase_ProcessInactiveClient(client);
    }

    if (inactiveClientsAmount == 0) {
        g_afkTimer = null;

        return Plugin_Stop;
    }

    return Plugin_Continue;
}

void UseCase_ProcessInactiveClient(int client) {
    if (!Client_IsNotified(client)) {
        Client_SetNotified(client, NOTIFIED_YES);
        UseCase_NotifyAboutInactivity(client);

        return;
    }

    Client_AddSeconds(client);

    int clientSeconds = Client_GetSeconds(client);

    if (IsClientObserver(client)) {
        int kickSeconds = Variable_KickSeconds();

        if (clientSeconds >= kickSeconds) {
            KickClient(client, "%t", "You are kicked for inactivity");
            MessageLog_ClientKicked(client);
        }
    } else {
        int moveSeconds = Variable_MoveSeconds();

        if (clientSeconds >= moveSeconds) {
            Client_ResetSeconds(client);
            ChangeClientTeam(client, TEAM_SPECTATOR);
            Message_PlayerMovedToSpectators(client);
        }
    }
}

void UseCase_NotifyAboutInactivity(int client) {
    if (IsClientObserver(client)) {
        int kickSeconds = Variable_KickSeconds();

        MessagePrint_YouAreInactiveSpectator(client, kickSeconds);
    } else {
        int moveSeconds = Variable_MoveSeconds();

        MessagePrint_YouAreInactivePlayer(client, moveSeconds);
    }
}
