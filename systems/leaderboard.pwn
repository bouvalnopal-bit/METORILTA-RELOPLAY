// VALZZ FFA INDONESIA - Leaderboard System
// Real-time Rankings Display

new leaderboard_data[10][PlayerData];
new leaderboard_count = 0;

UpdateLeaderboard() {
    // Query top 10 players by kills
    new query[256];
    mysql_format(mysql_handle, query, sizeof(query),
        "SELECT id, username, kills, deaths, level FROM accounts WHERE banned = 0 ORDER BY kills DESC LIMIT 10");
    
    mysql_query(mysql_handle, query, "UpdateLeaderboard_Callback");
    
    return 1;
}

forward UpdateLeaderboard_Callback();
public UpdateLeaderboard_Callback() {
    leaderboard_count = cache_get_row_count();
    
    for (new i = 0; i < leaderboard_count && i < 10; i++) {
        cache_get_value_name(i, "username", leaderboard_data[i][account_username], 32);
        cache_get_value_name_int(i, "kills", leaderboard_data[i][kills]);
        cache_get_value_name_int(i, "deaths", leaderboard_data[i][deaths]);
        cache_get_value_name_int(i, "level", leaderboard_data[i][level]);
    }
    
    return 1;
}

ShowLeaderboard(playerid) {
    new msg[256];
    SendClientMessage(playerid, COLOR_INFO, "~g~[TOP PLAYERS LEADERBOARD]");
    
    for (new i = 0; i < leaderboard_count && i < 10; i++) {
        format(msg, sizeof(msg), "~w~#%d: %s - ~g~%d Kills ~r~| %d Deaths ~y~[Lvl %d]",
            i + 1,
            leaderboard_data[i][account_username],
            leaderboard_data[i][kills],
            leaderboard_data[i][deaths],
            leaderboard_data[i][level]);
        
        SendClientMessage(playerid, COLOR_NEUTRAL, msg);
    }
    
    return 1;
}

GetLeaderboardPosition(playerid) {
    for (new i = 0; i < leaderboard_count; i++) {
        if (!strcmp(leaderboard_data[i][account_username], PlayerInfo[playerid][account_username])) {
            return i + 1;
        }
    }
    return -1;
}
