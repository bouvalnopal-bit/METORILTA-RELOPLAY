// VALZZ FFA INDONESIA - Player Spawn & Lobby System
// Main Hub for All Players

new player_spawn_count[MAX_PLAYERS];
new bool:player_in_lobby[MAX_PLAYERS];

SpawnPlayerToLobby(playerid) {
    if (!PlayerInfo[playerid][account_loaded]) {
        SendClientMessage(playerid, COLOR_ERROR, "[ERROR] Account not loaded yet!");
        return 0;
    }
    
    // Teleport to lobby
    SetPlayerPos(playerid, LOBBY_X, LOBBY_Y, LOBBY_Z);
    SetPlayerFacingAngle(playerid, LOBBY_ANGLE);
    SetPlayerInterior(playerid, LOBBY_INTERIOR);
    SetPlayerVirtualWorld(playerid, LOBBY_WORLD);
    
    // Reset weapons
    ResetPlayerWeapons(playerid);
    GiveStarterWeapons(playerid);
    
    // Reset stats
    SetPlayerHealth(playerid, 100.0);
    SetPlayerArmour(playerid, 0.0);
    
    // Give starter money
    GivePlayerMoney(playerid, PlayerInfo[playerid][money]);
    
    // Mark as in lobby
    PlayerInfo[playerid][is_in_lobby] = true;
    PlayerInfo[playerid][current_gamemode] = 0;
    player_in_lobby[playerid] = true;
    player_spawn_count[playerid]++;
    
    // Show welcome message
    new msg[256];
    format(msg, sizeof(msg), "~g~Welcome to VALZZ FFA INDONESIA~n~~w~Level: %d | Kills: %d | Deaths: %d | Money: $%d",
        PlayerInfo[playerid][level],
        PlayerInfo[playerid][kills],
        PlayerInfo[playerid][deaths],
        PlayerInfo[playerid][money]);
    
    SendClientMessage(playerid, COLOR_SUCCESS, msg);
    SendClientMessage(playerid, COLOR_INFO, "[INFO] Press ~g~F~w~ to open main menu or ~g~/help~w~ for commands");
    
    // Set camera cinematic view
    SetPlayerCameraPos(playerid, LOBBY_X + 20, LOBBY_Y + 20, LOBBY_Z + 10);
    SetPlayerCameraLookAt(playerid, LOBBY_X, LOBBY_Y, LOBBY_Z);
    
    return 1;
}

SpawnPlayerToOpenWorld(playerid) {
    // Random spawn location in GTA SA map
    new random_spawn = random(5);
    new Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:spawn_angle;
    
    switch(random_spawn) {
        case 0: { // Los Santos
            spawn_x = 1224.0;
            spawn_y = -1046.0;
            spawn_z = 43.5;
            spawn_angle = 270.0;
        }
        case 1: { // San Fierro
            spawn_x = -2033.0;
            spawn_y = 156.0;
            spawn_z = 28.8;
            spawn_angle = 180.0;
        }
        case 2: { // Las Venturas
            spawn_x = 1924.0;
            spawn_y = 1343.0;
            spawn_z = 15.4;
            spawn_angle = 270.0;
        }
        case 3: { // Desert
            spawn_x = 286.0;
            spawn_y = 1964.0;
            spawn_z = 17.5;
            spawn_angle = 180.0;
        }
        case 4: { // Airport
            spawn_x = 1524.0;
            spawn_y = 1432.0;
            spawn_z = 10.8;
            spawn_angle = 90.0;
        }
    }
    
    SetPlayerPos(playerid, spawn_x, spawn_y, spawn_z);
    SetPlayerFacingAngle(playerid, spawn_angle);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    
    ResetPlayerWeapons(playerid);
    GiveStarterWeapons(playerid);
    
    SetPlayerHealth(playerid, 100.0);
    SetPlayerArmour(playerid, 0.0);
    
    PlayerInfo[playerid][is_in_lobby] = false;
    PlayerInfo[playerid][current_gamemode] = 1; // Open World FFA
    
    SendClientMessage(playerid, COLOR_SUCCESS, "[SPAWN] You spawned in Open World FFA!");
    SendClientMessage(playerid, COLOR_INFO, "[INFO] Fight other players! Press ~g~TAB~w~ for leaderboard");
    
    return 1;
}

GetPlayerSpawnCount(playerid) {
    return player_spawn_count[playerid];
}

IsPlayerInLobby(playerid) {
    return player_in_lobby[playerid];
}
