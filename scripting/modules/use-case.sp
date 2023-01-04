static Handle g_afkTimer = null;

void UseCase_ResetAfkTimer() {
    g_afkTimer = null;
}

void UseCase_OnClientActive(int client) {
    Client_SetAsActive(client);
    Client_ResetSeconds(client);
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
    bool isNotified = Client_IsNotified(client);

    Client_SetNotified(client, NOTIFIED_YES);

    if (IsClientObserver(client)) {
        if (isNotified) {
            UseCase_CheckKickSeconds(client);
        } else {
            UseCase_NotifyAboutKick(client);
        }
    } else {
        if (isNotified) {
            UseCase_CheckMoveSeconds(client);
        } else {
            UseCase_NotifyAboutMove(client);
        }
    }
}

void UseCase_NotifyAboutKick(int client, int clientKickSeconds = 0) {
    if (UseCase_NotEnoughClientsForKick()) {
        return;
    }

    if (UseCase_IsClientHaveImmunity(client, AFK_IMMUNITY_KICK)) {
        return;
    }

    int kickSeconds = Variable_KickSeconds() - clientKickSeconds;

    Message_InactiveSpectator(client, kickSeconds);
}

void UseCase_NotifyAboutMove(int client, int clientMoveSeconds = 0) {
    if (UseCase_NotEnoughClientsForMove()) {
        return;
    }

    if (UseCase_IsClientHaveImmunity(client, AFK_IMMUNITY_MOVE)) {
        return;
    }

    int moveSeconds = Variable_MoveSeconds() - clientMoveSeconds;

    Message_InactivePlayer(client, moveSeconds);
}

void UseCase_CheckKickSeconds(int client) {
    Client_AddKickSeconds(client);

    if (UseCase_NotEnoughClientsForKick()) {
        return;
    }

    if (UseCase_IsClientHaveImmunity(client, AFK_IMMUNITY_KICK)) {
        return;
    }

    int clientKickSeconds = Client_GetKickSeconds(client);
    int kickSeconds = Variable_KickSeconds();

    if (clientKickSeconds >= kickSeconds) {
        KickClient(client, "%t", "You are kicked for inactivity");
        Message_ClientKicked(client);
    } else if (UseCase_IsRepeatKickNotification(clientKickSeconds)) {
        UseCase_NotifyAboutKick(client, clientKickSeconds);
    }
}

void UseCase_CheckMoveSeconds(int client) {
    Client_AddMoveSeconds(client);

    if (UseCase_NotEnoughClientsForMove()) {
        return;
    }

    if (UseCase_IsClientHaveImmunity(client, AFK_IMMUNITY_MOVE)) {
        return;
    }

    int clientMoveSeconds = Client_GetMoveSeconds(client);
    int moveSeconds = Variable_MoveSeconds();

    if (clientMoveSeconds >= moveSeconds) {
        ChangeClientTeam(client, TEAM_SPECTATOR);
        Message_PlayerMovedToSpectators(client);
        UseCase_NotifyAboutKick(client);
    } else if (UseCase_IsRepeatMoveNotification(clientMoveSeconds)) {
        UseCase_NotifyAboutMove(client, clientMoveSeconds);
    }
}

bool UseCase_IsRepeatKickNotification(int seconds) {
    int interval = Variable_KickNotificationInterval();

    return UseCase_IsRepeatNotification(interval, seconds);
}

bool UseCase_IsRepeatMoveNotification(int seconds) {
    int interval = Variable_MoveNotificationInterval();

    return UseCase_IsRepeatNotification(interval, seconds);
}

bool UseCase_IsRepeatNotification(int interval, int seconds) {
    return interval == 0 ? false : (seconds % interval == 0);
}

bool UseCase_NotEnoughClientsForKick() {
    return GetClientCount() < Variable_KickMinPlayers();
}

bool UseCase_NotEnoughClientsForMove() {
    return GetClientCount() < Variable_MoveMinPlayers();
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

    Message_AfkStatus(client, target, seconds);
}

void UseCase_ResetSeconds(int client, int target) {
    Client_ResetSeconds(client);
    Message_ResetSeconds(client, target);
}
