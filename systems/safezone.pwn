// VALZZ FFA INDONESIA - Safezone System
// Protected Areas

new Safezone:safezones[10];
new safezone_count = 0;

enum SafezoneInfo {
    safe_id,
    Float:safe_x,
    Float:safe_y,
    Float:safe_z,
    Float:safe_radius,
    safe_type[32],
    safe_object_id,
};

new safezone_data[10][SafezoneInfo];
new bool:player_in_safezone[MAX_PLAYERS];
new player_current_safezone[MAX_PLAYERS];

CreateSafezones() {
    // Lobby Safezone
    CreateSafezone(0, LOBBY_X, LOBBY_Y, LOBBY_Z, SAFEZONE_RADIUS, "LOBBY");
    
    // Spawn Safezone (Hospital)
    CreateSafezone(1, 1186.7, -1323.5, 13.5, SAFEZONE_RADIUS, "SPAWN");
    
    // Bank Safezone
    CreateSafezone(2, 1473.6, -1008.4, 26.8, SAFEZONE_RADIUS, "BANK");
    
    // Marketplace Safezone
    CreateSafezone(3, -2027.4, 156.3, 28.8, SAFEZONE_RADIUS, "MARKET");
    
    // Garage Safezone
    CreateSafezone(4, 558.5, -1293.5, 17.2, SAFEZONE_RADIUS, "GARAGE");
    
    // Admin Zone
    CreateSafezone(5, 2003.8, 1907.5, 12.0, SAFEZONE_RADIUS, "ADMIN");
}

CreateSafezone(safezone_id, Float:x, Float:y, Float:z, Float:radius, safe_type[]) {
    safezone_data[safezone_id][safe_id] = safezone_id;
    safezone_data[safezone_id][safe_x] = x;
    safezone_data[safezone_id][safe_y] = y;
    safezone_data[safezone_id][safe_z] = z;
    safezone_data[safezone_id][safe_radius] = radius;
    format(safezone_data[safezone_id][safe_type], 32, "%s", safe_type);
    
    // Create visual marker (cylinder)
    safezone_data[safezone_id][safe_object_id] = CreateDynamicSphere(x, y, z, radius, 0, 0, -1);
    
    safezone_count++;
    return safezone_id;
}

CheckPlayerSafezone(playerid) {
    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);
    
    for (new i = 0; i < safezone_count; i++) {
        new Float:dist = floatsqrt(
            (px - safezone_data[i][safe_x]) * (px - safezone_data[i][safe_x]) +
            (py - safezone_data[i][safe_y]) * (py - safezone_data[i][safe_y]) +
            (pz - safezone_data[i][safe_z]) * (pz - safezone_data[i][safe_z])
        );
        
        if (dist <= safezone_data[i][safe_radius]) {
            if (!player_in_safezone[playerid]) {
                OnPlayerEnterSafezone(playerid, i);
                player_in_safezone[playerid] = true;
                player_current_safezone[playerid] = i;
            }
            return 1;
        }
    }
    
    if (player_in_safezone[playerid]) {
        OnPlayerLeaveSafezone(playerid, player_current_safezone[playerid]);
        player_in_safezone[playerid] = false;
    }
    
    return 0;
}

public OnPlayerEnterSafezone(playerid, safezone_id) {
    new msg[256];
    format(msg, sizeof(msg), "[SAFEZONE] Entered %s zone - You are protected!", safezone_data[safezone_id][safe_type]);
    SendClientMessage(playerid, COLOR_SUCCESS, msg);
    
    // Disable damage in safezone
    PlayerInfo[playerid][in_safezone] = true;
    PlayerInfo[playerid][safezone_id] = safezone_id;
    
    // Disarm player if in combat zone
    RemovePlayerWeapons(playerid);
    
    return 1;
}

public OnPlayerLeaveSafezone(playerid, safezone_id) {
    new msg[256];
    format(msg, sizeof(msg), "[SAFEZONE] You left %s zone", safezone_data[safezone_id][safe_type]);
    SendClientMessage(playerid, COLOR_INFO, msg);
    
    PlayerInfo[playerid][in_safezone] = false;
    
    return 1;
}

IsPlayerInSafezone(playerid) {
    return player_in_safezone[playerid];
}

PreventDamageInSafezone(playerid) {
    if (IsPlayerInSafezone(playerid)) {
        new Float:health;
        GetPlayerHealth(playerid, health);
        SetPlayerHealth(playerid, health + 10.0); // Nullify damage
        return 1;
    }
    return 0;
}
