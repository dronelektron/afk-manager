#include <sourcemod>

#include "morecolors"

#include "afk-detector/api"
#include "afk-manager/message"
#include "afk-manager/use-case"

#include "modules/client.sp"
#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/message.sp"
#include "modules/use-case.sp"

#define AUTO_CREATE_YES true

public Plugin myinfo = {
    name = "AFK manager",
    author = "Dron-elektron",
    description = "Allows you to manage players who are inactive",
    version = "1.3.1",
    url = "https://github.com/dronelektron/afk-manager"
};

public void OnPluginStart() {
    Command_Create();
    Variable_Create();
    LoadTranslations("common.phrases");
    LoadTranslations("afk-manager.phrases");
    AutoExecConfig(AUTO_CREATE_YES, "afk-manager");
}

public void OnMapStart() {
    UseCase_ResetAfkTimer();
}

public void OnClientPostAdminCheck(int client) {
    Client_ResetSeconds(client);
}

public void AfkDetector_OnClientActive(int client) {
    UseCase_OnClientActive(client);
}

public void AfkDetector_OnClientInactive(int client) {
    UseCase_OnClientInactive(client);
}
