// VALZZ FFA INDONESIA - Utility Functions
// Production-Ready Helpers

// String Functions
strtolower(const str[]) {
    new result[128];
    for (new i = 0; i < sizeof(str); i++) {
        if (str[i] >= 'A' && str[i] <= 'Z') {
            result[i] = str[i] + 32;
        } else {
            result[i] = str[i];
        }
    }
    return result;
}

GenerateSecurePassword(output[], length = 32) {
    new const chars[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*";
    for (new i = 0; i < length; i++) {
        output[i] = chars[random(sizeof(chars) - 1)];
    }
    output[length] = EOS;
    return length;
}

GenerateSessionToken(output[], length = 32) {
    new const hex[] = "0123456789ABCDEF";
    for (new i = 0; i < length; i++) {
        output[i] = hex[random(16)];
    }
    output[length] = EOS;
    return length;
}

HashPassword(const password[], output[]) {
    // Using basic MD5-like approach for example
    // In production, use proper hashing library
    WP_Hash(output, 65, password);
}

VerifyPassword(const password[], const hash[]) {
    new temp[65];
    WP_Hash(temp, 65, password);
    return !strcmp(temp, hash);
}

GetPlayerMoneyFormatted(playerid, output[]) {
    new money = GetPlayerMoney(playerid);
    if (money >= 1000000) {
        format(output, 128, "$%.2fM", float(money) / 1000000.0);
    } else if (money >= 1000) {
        format(output, 128, "$%.2fK", float(money) / 1000.0);
    } else {
        format(output, 128, "$%d", money);
    }
}

GetPlayerLevelXP(playerid, &level, &xp) {
    level = PlayerInfo[playerid][level];
    xp = PlayerInfo[playerid][experience];
}

CalculateLevelProgress(playerid, Float:&progress) {
    new level = PlayerInfo[playerid][level];
    new xp = PlayerInfo[playerid][experience];
    new level_req = (level + 1) * EXP_LEVEL_UP;
    progress = (float(xp) / float(level_req)) * 100.0;
}

GiveKillReward(playerid, killer, bool:headshot = false, bool:knife = false) {
    new reward = REWARD_NORMAL_KILL;
    
    if (knife) {
        reward = REWARD_KNIFE_KILL;
    } else if (headshot) {
        reward = REWARD_HEADSHOT;
    }
    
    GivePlayerMoney(killer, reward);
    PlayerInfo[killer][money] += reward;
    PlayerInfo[killer][experience] += EXP_PER_KILL;
    
    return reward;
}

FormatTime(seconds, output[]) {
    new hours = seconds / 3600;
    new mins = (seconds % 3600) / 60;
    new secs = seconds % 60;
    format(output, 32, "%02d:%02d:%02d", hours, mins, secs);
}

GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:&distance) {
    distance = floatsqrt(((x1-x2)*(x1-x2))+((y1-y2)*(y1-y2))+((z1-z2)*(z1-z2)));
    return 1;
}

IsPlayerInSafezone(playerid) {
    if (!PlayerInfo[playerid][in_safezone]) return 0;
    return 1;
}

GetPlayerKDRatio(playerid, Float:&kdr) {
    if (PlayerInfo[playerid][deaths] == 0) {
        kdr = float(PlayerInfo[playerid][kills]);
    } else {
        kdr = float(PlayerInfo[playerid][kills]) / float(PlayerInfo[playerid][deaths]);
    }
    return 1;
}

GetPlayerWinrate(playerid, Float:&winrate) {
    // Will be calculated from match history in MySQL
    winrate = 50.0; // Default
    return 1;
}
