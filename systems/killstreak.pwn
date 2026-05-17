// VALZZ FFA INDONESIA - Kill Streak System
// Multiple Kill Rewards

new kill_streak[MAX_PLAYERS];
new last_kill_time[MAX_PLAYERS];

#define KILL_STREAK_TIMEOUT 10000 // 10 seconds

UpdateKillStreak(killerid) {
    new current_time = GetTickCount();
    new time_diff = current_time - last_kill_time[killerid];
    
    if (time_diff > KILL_STREAK_TIMEOUT) {
        kill_streak[killerid] = 1;
    } else {
        kill_streak[killerid]++;
    }
    
    last_kill_time[killerid] = current_time;
    
    // Announce kill streaks
    switch(kill_streak[killerid]) {
        case 3: {
            SendClientMessageToAll(COLOR_WARNING, sprintf("~y~[STREAK] %s is on a 3-kill streak!", GetPlayerNameEx(killerid)));
            GivePlayerMoney(killerid, 1000);
        }
        case 5: {
            SendClientMessageToAll(COLOR_WARNING, sprintf("~y~[STREAK] %s is on a 5-kill streak! RAMPAGE!", GetPlayerNameEx(killerid)));
            GivePlayerMoney(killerid, 2000);
        }
        case 10: {
            SendClientMessageToAll(COLOR_ACCENT, sprintf("~m~[STREAK] %s is UNSTOPPABLE with 10 kills in a row!", GetPlayerNameEx(killerid)));
            GivePlayerMoney(killerid, 5000);
        }
    }
    
    return kill_streak[killerid];
}

ResetKillStreak(playerid) {
    kill_streak[playerid] = 0;
    last_kill_time[playerid] = 0;
}

GetPlayerKillStreak(playerid) {
    return kill_streak[playerid];
}

GetPlayerNameEx(playerid) {
    new name[32];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}
