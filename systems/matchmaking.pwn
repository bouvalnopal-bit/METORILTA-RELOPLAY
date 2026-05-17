// VALZZ FFA INDONESIA - Matchmaking System
// Competitive Ranked Matches

new match_count = 0;
new active_matches[100];
new match_queue[MAX_PLAYERS];
new match_queue_count = 0;
new bool:player_in_queue[MAX_PLAYERS];
new bool:player_ready[MAX_PLAYERS];

enum MatchInfo {
    match_id,
    match_type,
    match_status,
    match_players[4],
    match_team1_score,
    match_team2_score,
    match_start_time,
    match_duration,
    Float:match_x,
    Float:match_y,
    Float:match_z,
};

new match_data[100][MatchInfo];

JoinMatchQueue(playerid, match_type) {
    if (player_in_queue[playerid]) {
        SendClientMessage(playerid, COLOR_WARNING, "[MATCHMAKING] You are already in queue!");
        return 0;
    }
    
    if (!PlayerInfo[playerid][is_in_lobby]) {
        SendClientMessage(playerid, COLOR_ERROR, "[ERROR] You must be in lobby to join queue!");
        return 0;
    }
    
    match_queue[match_queue_count] = playerid;
    match_queue_count++;
    player_in_queue[playerid] = true;
    player_ready[playerid] = false;
    
    new msg[256];
    format(msg, sizeof(msg), "[MATCHMAKING] You joined queue for %s (Players in queue: %d)", GetMatchTypeName(match_type), match_queue_count);
    SendClientMessage(playerid, COLOR_INFO, msg);
    
    // Check if we can start a match
    CheckMatchRequirements(match_type);
    
    return 1;
}

LeaveMatchQueue(playerid) {
    if (!player_in_queue[playerid]) return 0;
    
    for (new i = 0; i < match_queue_count; i++) {
        if (match_queue[i] == playerid) {
            match_queue[i] = -1;
            break;
        }
    }
    
    player_in_queue[playerid] = false;
    SendClientMessage(playerid, COLOR_INFO, "[MATCHMAKING] You left the queue!");
    
    return 1;
}

CheckMatchRequirements(match_type) {
    new players_needed = GetPlayersNeededForMatch(match_type);
    new players_ready = 0;
    
    for (new i = 0; i < match_queue_count; i++) {
        if (match_queue[i] != -1 && IsPlayerConnected(match_queue[i])) {
            players_ready++;
        }
    }
    
    if (players_ready >= players_needed) {
        StartMatchmaking(match_type, players_needed);
    }
}

StartMatchmaking(match_type, players_needed) {
    new match_id = match_count++;
    new player_index = 0;
    
    // Create match data
    match_data[match_id][match_id] = match_id;
    match_data[match_id][match_type] = match_type;
    match_data[match_id][match_status] = 1; // Active
    match_data[match_id][match_team1_score] = 0;
    match_data[match_id][match_team2_score] = 0;
    match_data[match_id][match_start_time] = GetTickCount();
    
    // Assign players to match
    for (new i = 0; i < match_queue_count && player_index < players_needed; i++) {
        if (match_queue[i] != -1 && IsPlayerConnected(match_queue[i])) {
            match_data[match_id][match_players][player_index] = match_queue[i];
            player_index++;
        }
    }
    
    // Send ready check to all players
    SendReadyCheck(match_id);
}

SendReadyCheck(match_id) {
    for (new i = 0; i < 4; i++) {
        new playerid = match_data[match_id][match_players][i];
        if (playerid == -1 || !IsPlayerConnected(playerid)) continue;
        
        SendClientMessage(playerid, COLOR_INFO, "[MATCHMAKING] Match found! Click [ READY ] or [ DECLINE ]");
        player_ready[playerid] = false;
    }
    
    SetTimerEx("CheckReadyStatus", MATCH_READY_CHECK_TIME, false, "d", match_id);
}

forward CheckReadyStatus(match_id);
public CheckReadyStatus(match_id) {
    new all_ready = 1;
    
    for (new i = 0; i < 4; i++) {
        new playerid = match_data[match_id][match_players][i];
        if (playerid == -1 || !IsPlayerConnected(playerid)) continue;
        
        if (!player_ready[playerid]) {
            all_ready = 0;
            break;
        }
    }
    
    if (all_ready) {
        TeleportPlayersToArena(match_id);
    } else {
        CancelMatch(match_id);
    }
}

TeleportPlayersToArena(match_id) {
    for (new i = 0; i < 4; i++) {
        new playerid = match_data[match_id][match_players][i];
        if (playerid == -1 || !IsPlayerConnected(playerid)) continue;
        
        // Get arena location
        new Float:arena_x = 1958.0 + (i * 30.0);
        new Float:arena_y = 1343.0 + (i * 30.0);
        new Float:arena_z = 15.4;
        
        SetPlayerPos(playerid, arena_x, arena_y, arena_z);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 100 + match_id);
        
        ResetPlayerWeapons(playerid);
        GiveStarterWeapons(playerid);
        
        PlayerInfo[playerid][is_in_match] = true;
        
        SendClientMessage(playerid, COLOR_SUCCESS, "[MATCH] Fight! First to 10 points wins!");
    }
    
    SetTimerEx("UpdateMatch", 1000, true, "d", match_id);
}

forward UpdateMatch(match_id);
public UpdateMatch(match_id) {
    for (new i = 0; i < 4; i++) {
        new playerid = match_data[match_id][match_players][i];
        if (playerid == -1 || !IsPlayerConnected(playerid)) continue;
        
        // Check win conditions
        if (match_data[match_id][match_team1_score] >= 10 || match_data[match_id][match_team2_score] >= 10) {
            EndMatch(match_id);
            break;
        }
    }
}

EndMatch(match_id) {
    for (new i = 0; i < 4; i++) {
        new playerid = match_data[match_id][match_players][i];
        if (playerid == -1 || !IsPlayerConnected(playerid)) continue;
        
        PlayerInfo[playerid][is_in_match] = false;
        SendClientMessage(playerid, COLOR_SUCCESS, "[MATCH] Match ended! Returning to lobby...");
        SetTimerEx("ReturnToLobby", 5000, false, "d", playerid);
    }
}

forward ReturnToLobby(playerid);
public ReturnToLobby(playerid) {
    if (IsPlayerConnected(playerid)) {
        SpawnPlayerToLobby(playerid);
    }
}

CancelMatch(match_id) {
    for (new i = 0; i < 4; i++) {
        new playerid = match_data[match_id][match_players][i];
        if (playerid == -1 || !IsPlayerConnected(playerid)) continue;
        
        SendClientMessage(playerid, COLOR_WARNING, "[MATCHMAKING] Match cancelled. Returning to lobby...");
        player_in_queue[playerid] = false;
        SetTimerEx("ReturnToLobby", 3000, false, "d", playerid);
    }
}

GetPlayersNeededForMatch(match_type) {
    switch(match_type) {
        case 0: return 2;  // 1v1
        case 1: return 4;  // 2v2
        case 2: return 6;  // 3v3
        case 3: return 8;  // 4v4
        default: return 2;
    }
}

GetMatchTypeName(match_type) {
    new name[32];
    switch(match_type) {
        case 0: format(name, 32, "1v1");
        case 1: format(name, 32, "2v2");
        case 2: format(name, 32, "3v3");
        case 3: format(name, 32, "4v4");
        default: format(name, 32, "Unknown");
    }
    return name;
}
