#include <sourcemod>

#include "morecolors"

#include "afkm/message"
#include "afkm/use-case"

#include "modules/client.sp"
#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/message.sp"
#include "modules/use-case.sp"

#define AFK_DETECTOR "afk-detector"

public Plugin myinfo = {
    name = "AFK manager",
    author = "Dron-elektron",
    description = "Allows you to manage players who are inactive",
    version = "1.3.0",
    url = "https://github.com/dronelektron/afk-manager"
};

public void OnAllPluginsLoaded() {
    if (!LibraryExists(AFK_DETECTOR)) {
        SetFailState("Library '%s' is not found", AFK_DETECTOR);
    }
}

public void OnPluginStart() {
    Command_Create();
    Variable_Create();
    LoadTranslations("common.phrases");
    LoadTranslations("afk-manager.phrases");
    AutoExecConfig(true, "afk-manager");
}

public void OnMapStart() {
    UseCase_ResetAfkTimer();
}

public void OnClientPostAdminCheck(int client) {
    Client_SetAsActive(client);
    Client_ResetSeconds(client);
}

public void OnClientActive(int client) {
    UseCase_OnClientActive(client);
}

public void OnClientInactive(int client) {
    UseCase_OnClientInactive(client);
}
