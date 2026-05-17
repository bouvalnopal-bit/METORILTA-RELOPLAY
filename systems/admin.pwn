// VALZZ FFA INDONESIA - Admin System
// GUI-Based Administration Panel

new Text:AdminPanelBG[MAX_PLAYERS];
new Text:AdminPanelTitle[MAX_PLAYERS];
new Text:AdminPanelModerate[MAX_PLAYERS];
new Text:AdminPanelTeleport[MAX_PLAYERS];
new Text:AdminPanelSpectate[MAX_PLAYERS];
new Text:AdminPanelLogs[MAX_PLAYERS];
new Text:AdminPanelClose[MAX_PLAYERS];

new bool:admin_panel_shown[MAX_PLAYERS];
new admin_spectate_target[MAX_PLAYERS];

ShowAdminPanel(playerid) {
    if (PlayerInfo[playerid][admin_level] < ADMIN_HELPER) {
        SendClientMessage(playerid, COLOR_ERROR, "[ERROR] You do not have admin permission!");
        return 0;
    }
    
    // Background
    AdminPanelBG[playerid] = TextDrawCreate(10.0, 100.0, "~h~");
    TextDrawBackgroundColor(AdminPanelBG[playerid], 0);
    TextDrawFont(AdminPanelBG[playerid], 1);
    TextDrawLetterSize(AdminPanelBG[playerid], 0.5, 0.5);
    TextDrawTextSize(AdminPanelBG[playerid], 200.0, 250.0);
    TextDrawSetOutline(AdminPanelBG[playerid], 1);
    TextDrawSetProportional(AdminPanelBG[playerid], 1);
    TextDrawColor(AdminPanelBG[playerid], COLOR_NEON_BLUE);
    
    // Title
    AdminPanelTitle[playerid] = TextDrawCreate(50.0, 110.0, "~b~[ADMIN PANEL]");
    TextDrawBackgroundColor(AdminPanelTitle[playerid], 0);
    TextDrawFont(AdminPanelTitle[playerid], 1);
    TextDrawLetterSize(AdminPanelTitle[playerid], 0.35, 1.5);
    TextDrawSetOutline(AdminPanelTitle[playerid], 1);
    TextDrawSetProportional(AdminPanelTitle[playerid], 1);
    TextDrawColor(AdminPanelTitle[playerid], COLOR_NEON_BLUE);
    
    // Moderation Button
    AdminPanelModerate[playerid] = TextDrawCreate(20.0, 140.0, "~b~[~w~MODERATION~b~]");
    TextDrawBackgroundColor(AdminPanelModerate[playerid], 0);
    TextDrawFont(AdminPanelModerate[playerid], 1);
    TextDrawLetterSize(AdminPanelModerate[playerid], 0.3, 1.2);
    TextDrawTextSize(AdminPanelModerate[playerid], 190.0, 20.0);
    TextDrawSetOutline(AdminPanelModerate[playerid], 1);
    TextDrawSetProportional(AdminPanelModerate[playerid], 1);
    TextDrawSetSelectable(AdminPanelModerate[playerid], 1);
    TextDrawColor(AdminPanelModerate[playerid], COLOR_NEON_BLUE);
    
    // Teleport Button
    AdminPanelTeleport[playerid] = TextDrawCreate(20.0, 165.0, "~b~[~w~TELEPORT~b~]");
    TextDrawBackgroundColor(AdminPanelTeleport[playerid], 0);
    TextDrawFont(AdminPanelTeleport[playerid], 1);
    TextDrawLetterSize(AdminPanelTeleport[playerid], 0.3, 1.2);
    TextDrawTextSize(AdminPanelTeleport[playerid], 190.0, 20.0);
    TextDrawSetOutline(AdminPanelTeleport[playerid], 1);
    TextDrawSetProportional(AdminPanelTeleport[playerid], 1);
    TextDrawSetSelectable(AdminPanelTeleport[playerid], 1);
    TextDrawColor(AdminPanelTeleport[playerid], COLOR_NEON_BLUE);
    
    // Spectate Button
    AdminPanelSpectate[playerid] = TextDrawCreate(20.0, 190.0, "~b~[~w~SPECTATE~b~]");
    TextDrawBackgroundColor(AdminPanelSpectate[playerid], 0);
    TextDrawFont(AdminPanelSpectate[playerid], 1);
    TextDrawLetterSize(AdminPanelSpectate[playerid], 0.3, 1.2);
    TextDrawTextSize(AdminPanelSpectate[playerid], 190.0, 20.0);
    TextDrawSetOutline(AdminPanelSpectate[playerid], 1);
    TextDrawSetProportional(AdminPanelSpectate[playerid], 1);
    TextDrawSetSelectable(AdminPanelSpectate[playerid], 1);
    TextDrawColor(AdminPanelSpectate[playerid], COLOR_NEON_BLUE);
    
    // Logs Button
    AdminPanelLogs[playerid] = TextDrawCreate(20.0, 215.0, "~b~[~w~LOGS~b~]");
    TextDrawBackgroundColor(AdminPanelLogs[playerid], 0);
    TextDrawFont(AdminPanelLogs[playerid], 1);
    TextDrawLetterSize(AdminPanelLogs[playerid], 0.3, 1.2);
    TextDrawTextSize(AdminPanelLogs[playerid], 190.0, 20.0);
    TextDrawSetOutline(AdminPanelLogs[playerid], 1);
    TextDrawSetProportional(AdminPanelLogs[playerid], 1);
    TextDrawSetSelectable(AdminPanelLogs[playerid], 1);
    TextDrawColor(AdminPanelLogs[playerid], COLOR_NEON_BLUE);
    
    // Close Button
    AdminPanelClose[playerid] = TextDrawCreate(20.0, 240.0, "~r~[~w~CLOSE~r~]");
    TextDrawBackgroundColor(AdminPanelClose[playerid], 0);
    TextDrawFont(AdminPanelClose[playerid], 1);
    TextDrawLetterSize(AdminPanelClose[playerid], 0.3, 1.2);
    TextDrawTextSize(AdminPanelClose[playerid], 190.0, 20.0);
    TextDrawSetOutline(AdminPanelClose[playerid], 1);
    TextDrawSetProportional(AdminPanelClose[playerid], 1);
    TextDrawSetSelectable(AdminPanelClose[playerid], 1);
    TextDrawColor(AdminPanelClose[playerid], COLOR_ERROR);
    
    // Show all
    TextDrawShowForPlayer(playerid, AdminPanelBG[playerid]);
    TextDrawShowForPlayer(playerid, AdminPanelTitle[playerid]);
    TextDrawShowForPlayer(playerid, AdminPanelModerate[playerid]);
    TextDrawShowForPlayer(playerid, AdminPanelTeleport[playerid]);
    TextDrawShowForPlayer(playerid, AdminPanelSpectate[playerid]);
    TextDrawShowForPlayer(playerid, AdminPanelLogs[playerid]);
    TextDrawShowForPlayer(playerid, AdminPanelClose[playerid]);
    
    SelectTextDraw(playerid, 0x0099FFFF);
    admin_panel_shown[playerid] = true;
    
    return 1;
}

HideAdminPanel(playerid) {
    if (AdminPanelBG[playerid] != Text:INVALID_TEXT_DRAW) {
        TextDrawDestroy(AdminPanelBG[playerid]);
        TextDrawDestroy(AdminPanelTitle[playerid]);
        TextDrawDestroy(AdminPanelModerate[playerid]);
        TextDrawDestroy(AdminPanelTeleport[playerid]);
        TextDrawDestroy(AdminPanelSpectate[playerid]);
        TextDrawDestroy(AdminPanelLogs[playerid]);
        TextDrawDestroy(AdminPanelClose[playerid]);
        
        AdminPanelBG[playerid] = Text:INVALID_TEXT_DRAW;
    }
    
    admin_panel_shown[playerid] = false;
    return 1;
}

AdminWarn(playerid, targetid, reason[]) {
    if (PlayerInfo[playerid][admin_level] < ADMIN_MODERATOR) return 0;
    
    new msg[256];
    format(msg, sizeof(msg), "[ADMIN WARNING] You were warned by admin: %s", reason);
    SendClientMessage(targetid, COLOR_WARNING, msg);
    
    anticheat_warnings[targetid]++;
    
    new query[512];
    new admin_name[32], target_name[32];
    GetPlayerName(playerid, admin_name, 32);
    GetPlayerName(targetid, target_name, 32);
    
    mysql_format(mysql_handle, query, sizeof(query),
        "INSERT INTO admin_logs (admin_id, admin_name, target_id, target_name, action, reason) VALUES (%d, '%e', %d, '%e', 'WARN', '%e')",
        PlayerInfo[playerid][account_id], admin_name, PlayerInfo[targetid][account_id], target_name, reason);
    
    mysql_query(mysql_handle, query);
    
    return 1;
}

AdminKick(playerid, targetid, reason[]) {
    if (PlayerInfo[playerid][admin_level] < ADMIN_ADMIN) return 0;
    
    new msg[256];
    format(msg, sizeof(msg), "[KICKED] Reason: %s", reason);
    SendClientMessage(targetid, COLOR_ERROR, msg);
    
    new query[512];
    new admin_name[32], target_name[32];
    GetPlayerName(playerid, admin_name, 32);
    GetPlayerName(targetid, target_name, 32);
    
    mysql_format(mysql_handle, query, sizeof(query),
        "INSERT INTO admin_logs (admin_id, admin_name, target_id, target_name, action, reason) VALUES (%d, '%e', %d, '%e', 'KICK', '%e')",
        PlayerInfo[playerid][account_id], admin_name, PlayerInfo[targetid][account_id], target_name, reason);
    
    mysql_query(mysql_handle, query);
    
    KickPlayer(targetid, reason);
    
    return 1;
}

AdminBan(playerid, targetid, reason[], ban_duration) {
    if (PlayerInfo[playerid][admin_level] < ADMIN_SENIOR) return 0;
    
    new query[512];
    new admin_name[32], target_name[32];
    GetPlayerName(playerid, admin_name, 32);
    GetPlayerName(targetid, target_name, 32);
    
    mysql_format(mysql_handle, query, sizeof(query),
        "INSERT INTO bans (player_id, banned_by, reason, ban_date, unban_date) VALUES (%d, '%e', '%e', NOW(), DATE_ADD(NOW(), INTERVAL %d DAY))",
        PlayerInfo[targetid][account_id], admin_name, reason, ban_duration);
    
    mysql_query(mysql_handle, query);
    
    mysql_format(mysql_handle, query, sizeof(query),
        "INSERT INTO admin_logs (admin_id, admin_name, target_id, target_name, action, reason) VALUES (%d, '%e', %d, '%e', 'BAN_%d_DAYS', '%e')",
        PlayerInfo[playerid][account_id], admin_name, PlayerInfo[targetid][account_id], target_name, ban_duration, reason);
    
    mysql_query(mysql_handle, query);
    
    KickPlayer(targetid, "You have been banned");
    
    return 1;
}

AdminTeleport(adminid, targetid, Float:x, Float:y, Float:z) {
    if (PlayerInfo[adminid][admin_level] < ADMIN_ADMIN) return 0;
    
    SetPlayerPos(targetid, x, y, z);
    
    new msg[256];
    format(msg, sizeof(msg), "[ADMIN] You were teleported by %s", GetAdminName(adminid));
    SendClientMessage(targetid, COLOR_INFO, msg);
    
    return 1;
}

GetAdminName(adminid) {
    new admin_level = PlayerInfo[adminid][admin_level];
    new name[32];
    
    switch(admin_level) {
        case ADMIN_HELPER: format(name, 32, "Helper");
        case ADMIN_MODERATOR: format(name, 32, "Moderator");
        case ADMIN_ADMIN: format(name, 32, "Admin");
        case ADMIN_SENIOR: format(name, 32, "Senior Admin");
        case ADMIN_OWNER: format(name, 32, "Owner");
        case ADMIN_FOUNDER: format(name, 32, "Founder");
        default: format(name, 32, "Unknown");
    }
    
    return name;
}
