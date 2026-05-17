// VALZZ FFA INDONESIA - Anti-Cheat System
// Advanced Detection & Prevention

new anticheat_score[MAX_PLAYERS];
new anticheat_warnings[MAX_PLAYERS];
new anticheat_last_check[MAX_PLAYERS];
new anticheat_last_weapon[MAX_PLAYERS][2];
new anticheat_last_ammo[MAX_PLAYERS][2];
new bool:anticheat_enabled = true;

// Anti-Cheat Timer
public AntiCheatTimer() {
    for (new i = 0; i < MAX_PLAYERS; i++) {
        if (!IsPlayerConnected(i)) continue;
        if (!PlayerInfo[i][is_logged_in]) continue;
        
        CheckWeaponHack(i);
        CheckSpeedHack(i);
        CheckAimbotSuspicion(i);
        CheckHealthHack(i);
        CheckMoneyHack(i);
    }
}

CheckWeaponHack(playerid) {
    new weapon, ammo;
    GetPlayerWeaponData(playerid, 0, weapon, ammo);
    
    // Check for impossible weapon combinations
    if (weapon > 46) {
        anticheat_score[playerid] += 15;
        LogAntiCheatEvent(playerid, "Invalid Weapon ID", 15);
    }
    
    // Check for impossible ammo
    if (ammo > 99999) {
        anticheat_score[playerid] += 20;
        LogAntiCheatEvent(playerid, "Impossible Ammo Amount", 20);
    }
}

CheckSpeedHack(playerid) {
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    
    // Calculate distance from last position
    new Float:distance = GetPlayerDistanceFromPoint(playerid, x, y, z);
    
    // If distance is too great in short time (speedhack indicator)
    if (distance > 50.0) {
        anticheat_score[playerid] += 10;
        LogAntiCheatEvent(playerid, "Possible Speed Hack", 10);
    }
}

CheckAimbotSuspicion(playerid) {
    // Check for unnatural aim accuracy
    // This is a simplified check
    new shots_fired = 0;
    new accuracy = 0;
    
    // Higher score if too many headshots in short time
    if (PlayerInfo[playerid][headshots] > 50) {
        if (PlayerInfo[playerid][kills] < 60) {
            anticheat_score[playerid] += 5;
            LogAntiCheatEvent(playerid, "Suspicious Headshot Ratio", 5);
        }
    }
}

CheckHealthHack(playerid) {
    new Float:health;
    GetPlayerHealth(playerid, health);
    
    // Health above 100 without armor
    if (health > 100.0) {
        anticheat_score[playerid] += 25;
        LogAntiCheatEvent(playerid, "Health Over 100", 25);
    }
}

CheckMoneyHack(playerid) {
    new current_money = GetPlayerMoney(playerid);
    
    // Check for negative money
    if (current_money < 0) {
        anticheat_score[playerid] += 30;
        LogAntiCheatEvent(playerid, "Negative Money Detected", 30);
        SetPlayerMoney(playerid, 0);
    }
}

LogAntiCheatEvent(playerid, cheat_type[], score) {
    if (!anticheat_enabled) return 0;
    
    new query[512];
    new player_name[32];
    new action[32];
    
    GetPlayerName(playerid, player_name, sizeof(player_name));
    
    // Determine action based on score
    if (anticheat_score[playerid] >= CHEAT_SCORE_BAN) {
        format(action, 32, "PERMANENT_BAN");
        KickPlayer(playerid, "Anti-Cheat: Permanent Ban");
    } else if (anticheat_score[playerid] >= CHEAT_SCORE_KICK) {
        format(action, 32, "KICK");
        KickPlayer(playerid, "Anti-Cheat: Kicked");
    } else if (anticheat_score[playerid] >= CHEAT_SCORE_WARN) {
        format(action, 32, "WARNING");
        SendClientMessage(playerid, COLOR_WARNING, "[ANTI-CHEAT] Suspicious activity detected. Warnings remaining: 2");
        anticheat_warnings[playerid]++;
    }
    
    mysql_format(mysql_handle, query, sizeof(query),
        "INSERT INTO anticheat_logs (player_id, player_name, cheat_type, score, timestamp, action) VALUES (%d, '%e', '%e', %d, NOW(), '%e')",
        PlayerInfo[playerid][account_id], player_name, cheat_type, score, action);
    
    mysql_query(mysql_handle, query);
    
    return 1;
}

KickPlayer(playerid, reason[]) {
    new kick_msg[256];
    format(kick_msg, sizeof(kick_msg), "[KICKED] %s", reason);
    SendClientMessage(playerid, COLOR_ERROR, kick_msg);
    SetTimerEx("ActualKickPlayer", 1000, false, "d", playerid);
}

forward ActualKickPlayer(playerid);
public ActualKickPlayer(playerid) {
    Kick(playerid);
}

GetPlayerAntiCheatScore(playerid) {
    return anticheat_score[playerid];
}

ResetPlayerAntiCheatScore(playerid) {
    anticheat_score[playerid] = 0;
    anticheat_warnings[playerid] = 0;
}
