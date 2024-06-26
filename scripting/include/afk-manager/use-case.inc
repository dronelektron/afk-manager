#if defined _afk_manager_use_case_included
 #endinput
#endif
#define _afk_manager_use_case_included

#define TEAM_SPECTATOR 1
#define CLIENT_NOT_FOUND -1

#define AFK_TIMER_INTERVAL 1.0
#define AFK_TIMER_FLAGS (TIMER_REPEAT | TIMER_FLAG_NO_MAPCHANGE)

#define AFK_IMMUNITY_NONE 0
#define AFK_IMMUNITY_MOVE 1
#define AFK_IMMUNITY_KICK 2
#define AFK_IMMUNITY_FULL 3
