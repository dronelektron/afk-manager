static Handle g_afkTimer = null;

void UseCase_ResetAfkTimer() {
    g_afkTimer = null;
}

void UseCase_OnClientActive(int client) {
    Client_SetAsActive(client);
    Client_ResetSeconds(client);
    MessagePrint_YouAreActive(client);
}

void UseCase_OnClientInactive(int client) {
    Client_SetAsInactive(client);
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

    if (IsClientObserver(client)) {
        UseCase_CheckKickSeconds(client);
    } else {
        UseCase_CheckMoveSeconds(client);
    }
}

void UseCase_NotifyAboutInactivity(int client) {
    if (IsClientObserver(client)) {
        UseCase_NotifyAboutKick(client);
    } else {
        UseCase_NotifyAboutMove(client);
    }
}

void UseCase_NotifyAboutKick(int client) {
    if (UseCase_IsClientHaveImmunity(client, AFK_IMMUNITY_KICK)) {
        return;
    }

    int kickSeconds = Variable_KickSeconds();

    MessagePrint_YouAreInactiveSpectator(client, kickSeconds);
}

void UseCase_NotifyAboutMove(int client) {
    if (UseCase_IsClientHaveImmunity(client, AFK_IMMUNITY_MOVE)) {
        return;
    }

    int moveSeconds = Variable_MoveSeconds();

    MessagePrint_YouAreInactivePlayer(client, moveSeconds);
}

void UseCase_CheckKickSeconds(int client) {
    Client_AddKickSeconds(client);

    if (UseCase_IsClientHaveImmunity(client, AFK_IMMUNITY_KICK)) {
        return;
    }

    int clientKickSeconds = Client_GetKickSeconds(client);
    int kickSeconds = Variable_KickSeconds();

    if (clientKickSeconds >= kickSeconds) {
        KickClient(client, "%t", "You are kicked for inactivity");
        MessageLog_ClientKicked(client);
    }
}

void UseCase_CheckMoveSeconds(int client) {
    Client_AddMoveSeconds(client);

    if (UseCase_IsClientHaveImmunity(client, AFK_IMMUNITY_MOVE)) {
        return;
    }

    int clientMoveSeconds = Client_GetMoveSeconds(client);
    int moveSeconds = Variable_MoveSeconds();

    if (clientMoveSeconds >= moveSeconds) {
        ChangeClientTeam(client, TEAM_SPECTATOR);
        Message_PlayerMovedToSpectators(client);
    }
}

bool UseCase_IsClientHaveImmunity(int client, int immunity) {
    int adminImmunity = Variable_AdminImmunity();

    if (UseCase_IsAdmin(client) && adminImmunity > AFK_IMMUNITY_NONE) {
        return UseCase_IsPartialOrFullImmunity(adminImmunity, immunity);
    }

    int playerImmunity = Variable_PlayerImmunity();

    return UseCase_IsPartialOrFullImmunity(playerImmunity, immunity);
}

bool UseCase_IsPartialOrFullImmunity(int variableImmunity, int immunity) {
    return variableImmunity == immunity || variableImmunity == AFK_IMMUNITY_FULL;
}

bool UseCase_IsAdmin(int client) {
    AdminId id = GetUserAdmin(client);

    return id != INVALID_ADMIN_ID && GetAdminFlag(id, Admin_Generic, Access_Effective);
}

void UseCase_CheckAfkStatus(int client, int target) {
    int seconds = Client_GetKickSeconds(target) + Client_GetMoveSeconds(client);

    MessageReply_AfkStatus(client, target, seconds);
}
