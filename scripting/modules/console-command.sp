void Command_Create() {
    RegAdminCmd("sm_afkmanager_status", Command_Status, ADMFLAG_GENERIC);
    RegAdminCmd("sm_afkmanager_reset_seconds", Command_ResetSeconds, ADMFLAG_GENERIC);
}

public Action Command_Status(int client, int args) {
    if (args < 1) {
        MessageReply_AfkStatusUsage(client);

        return Plugin_Handled;
    }

    char name[MAX_NAME_LENGTH];

    GetCmdArg(1, name, sizeof(name));

    int target = FindTarget(client, name);

    if (target != CLIENT_NOT_FOUND) {
        UseCase_CheckAfkStatus(client, target);
    }

    return Plugin_Handled;
}

public Action Command_ResetSeconds(int client, int args) {
    if (args < 1) {
        MessageReply_ResetSecondsUsage(client);

        return Plugin_Handled;
    }

    char name[MAX_NAME_LENGTH];

    GetCmdArg(1, name, sizeof(name));

    int target = FindTarget(client, name);

    if (target != CLIENT_NOT_FOUND) {
        UseCase_ResetSeconds(client,  target);
    }

    return Plugin_Handled;
}
