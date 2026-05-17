// VALZZ FFA INDONESIA - Founder Control Center
// Complete Server Management Panel

new Text:FounderPanelBG[MAX_PLAYERS];
new Text:FounderPanelTitle[MAX_PLAYERS];
new Text:FounderPanelServerSettings[MAX_PLAYERS];
new Text:FounderPanelAntiCheat[MAX_PLAYERS];
new Text:FounderPanelEconomy[MAX_PLAYERS];
new Text:FounderPanelEvents[MAX_PLAYERS];
new Text:FounderPanelAdminManager[MAX_PLAYERS];
new Text:FounderPanelRestart[MAX_PLAYERS];
new Text:FounderPanelClose[MAX_PLAYERS];

new bool:founder_panel_shown[MAX_PLAYERS];

ShowFounderPanel(playerid) {
    if (PlayerInfo[playerid][admin_level] != ADMIN_FOUNDER) {
        SendClientMessage(playerid, COLOR_ERROR, "[ERROR] Only founder can access this panel!");
        return 0;
    }
    
    // Background
    FounderPanelBG[playerid] = TextDrawCreate(50.0, 50.0, "~h~");
    TextDrawBackgroundColor(FounderPanelBG[playerid], 0);
    TextDrawFont(FounderPanelBG[playerid], 1);
    TextDrawLetterSize(FounderPanelBG[playerid], 0.5, 0.5);
    TextDrawTextSize(FounderPanelBG[playerid], 540.0, 380.0);
    TextDrawSetOutline(FounderPanelBG[playerid], 2);
    TextDrawSetProportional(FounderPanelBG[playerid], 1);
    TextDrawColor(FounderPanelBG[playerid], COLOR_NEON_PURPLE);
    
    // Title
    FounderPanelTitle[playerid] = TextDrawCreate(290.0, 60.0, "~m~[FOUNDER CONTROL CENTER]");
    TextDrawBackgroundColor(FounderPanelTitle[playerid], 0);
    TextDrawFont(FounderPanelTitle[playerid], 1);
    TextDrawLetterSize(FounderPanelTitle[playerid], 0.4, 2.0);
    TextDrawSetOutline(FounderPanelTitle[playerid], 2);
    TextDrawSetProportional(FounderPanelTitle[playerid], 1);
    TextDrawColor(FounderPanelTitle[playerid], COLOR_NEON_PURPLE);
    
    // Server Settings
    FounderPanelServerSettings[playerid] = TextDrawCreate(60.0, 100.0, "~m~[~w~SERVER SETTINGS~m~]");
    TextDrawBackgroundColor(FounderPanelServerSettings[playerid], 0);
    TextDrawFont(FounderPanelServerSettings[playerid], 1);
    TextDrawLetterSize(FounderPanelServerSettings[playerid], 0.3, 1.2);
    TextDrawTextSize(FounderPanelServerSettings[playerid], 250.0, 20.0);
    TextDrawSetOutline(FounderPanelServerSettings[playerid], 1);
    TextDrawSetProportional(FounderPanelServerSettings[playerid], 1);
    TextDrawSetSelectable(FounderPanelServerSettings[playerid], 1);
    TextDrawColor(FounderPanelServerSettings[playerid], COLOR_NEON_PURPLE);
    
    // Anti-Cheat Settings
    FounderPanelAntiCheat[playerid] = TextDrawCreate(60.0, 130.0, "~m~[~w~ANTI-CHEAT CONFIG~m~]");
    TextDrawBackgroundColor(FounderPanelAntiCheat[playerid], 0);
    TextDrawFont(FounderPanelAntiCheat[playerid], 1);
    TextDrawLetterSize(FounderPanelAntiCheat[playerid], 0.3, 1.2);
    TextDrawTextSize(FounderPanelAntiCheat[playerid], 250.0, 20.0);
    TextDrawSetOutline(FounderPanelAntiCheat[playerid], 1);
    TextDrawSetProportional(FounderPanelAntiCheat[playerid], 1);
    TextDrawSetSelectable(FounderPanelAntiCheat[playerid], 1);
    TextDrawColor(FounderPanelAntiCheat[playerid], COLOR_NEON_PURPLE);
    
    // Economy Control
    FounderPanelEconomy[playerid] = TextDrawCreate(60.0, 160.0, "~m~[~w~ECONOMY CONTROL~m~]");
    TextDrawBackgroundColor(FounderPanelEconomy[playerid], 0);
    TextDrawFont(FounderPanelEconomy[playerid], 1);
    TextDrawLetterSize(FounderPanelEconomy[playerid], 0.3, 1.2);
    TextDrawTextSize(FounderPanelEconomy[playerid], 250.0, 20.0);
    TextDrawSetOutline(FounderPanelEconomy[playerid], 1);
    TextDrawSetProportional(FounderPanelEconomy[playerid], 1);
    TextDrawSetSelectable(FounderPanelEconomy[playerid], 1);
    TextDrawColor(FounderPanelEconomy[playerid], COLOR_NEON_PURPLE);
    
    // Event Control
    FounderPanelEvents[playerid] = TextDrawCreate(60.0, 190.0, "~m~[~w~EVENT CONTROL~m~]");
    TextDrawBackgroundColor(FounderPanelEvents[playerid], 0);
    TextDrawFont(FounderPanelEvents[playerid], 1);
    TextDrawLetterSize(FounderPanelEvents[playerid], 0.3, 1.2);
    TextDrawTextSize(FounderPanelEvents[playerid], 250.0, 20.0);
    TextDrawSetOutline(FounderPanelEvents[playerid], 1);
    TextDrawSetProportional(FounderPanelEvents[playerid], 1);
    TextDrawSetSelectable(FounderPanelEvents[playerid], 1);
    TextDrawColor(FounderPanelEvents[playerid], COLOR_NEON_PURPLE);
    
    // Admin Manager
    FounderPanelAdminManager[playerid] = TextDrawCreate(60.0, 220.0, "~m~[~w~ADMIN MANAGER~m~]");
    TextDrawBackgroundColor(FounderPanelAdminManager[playerid], 0);
    TextDrawFont(FounderPanelAdminManager[playerid], 1);
    TextDrawLetterSize(FounderPanelAdminManager[playerid], 0.3, 1.2);
    TextDrawTextSize(FounderPanelAdminManager[playerid], 250.0, 20.0);
    TextDrawSetOutline(FounderPanelAdminManager[playerid], 1);
    TextDrawSetProportional(FounderPanelAdminManager[playerid], 1);
    TextDrawSetSelectable(FounderPanelAdminManager[playerid], 1);
    TextDrawColor(FounderPanelAdminManager[playerid], COLOR_NEON_PURPLE);
    
    // Restart Server
    FounderPanelRestart[playerid] = TextDrawCreate(60.0, 250.0, "~r~[~w~RESTART SERVER~r~]");
    TextDrawBackgroundColor(FounderPanelRestart[playerid], 0);
    TextDrawFont(FounderPanelRestart[playerid], 1);
    TextDrawLetterSize(FounderPanelRestart[playerid], 0.3, 1.2);
    TextDrawTextSize(FounderPanelRestart[playerid], 250.0, 20.0);
    TextDrawSetOutline(FounderPanelRestart[playerid], 1);
    TextDrawSetProportional(FounderPanelRestart[playerid], 1);
    TextDrawSetSelectable(FounderPanelRestart[playerid], 1);
    TextDrawColor(FounderPanelRestart[playerid], COLOR_ERROR);
    
    // Close Button
    FounderPanelClose[playerid] = TextDrawCreate(60.0, 280.0, "~r~[~w~CLOSE~r~]");
    TextDrawBackgroundColor(FounderPanelClose[playerid], 0);
    TextDrawFont(FounderPanelClose[playerid], 1);
    TextDrawLetterSize(FounderPanelClose[playerid], 0.3, 1.2);
    TextDrawTextSize(FounderPanelClose[playerid], 250.0, 20.0);
    TextDrawSetOutline(FounderPanelClose[playerid], 1);
    TextDrawSetProportional(FounderPanelClose[playerid], 1);
    TextDrawSetSelectable(FounderPanelClose[playerid], 1);
    TextDrawColor(FounderPanelClose[playerid], COLOR_ERROR);
    
    // Show all
    TextDrawShowForPlayer(playerid, FounderPanelBG[playerid]);
    TextDrawShowForPlayer(playerid, FounderPanelTitle[playerid]);
    TextDrawShowForPlayer(playerid, FounderPanelServerSettings[playerid]);
    TextDrawShowForPlayer(playerid, FounderPanelAntiCheat[playerid]);
    TextDrawShowForPlayer(playerid, FounderPanelEconomy[playerid]);
    TextDrawShowForPlayer(playerid, FounderPanelEvents[playerid]);
    TextDrawShowForPlayer(playerid, FounderPanelAdminManager[playerid]);
    TextDrawShowForPlayer(playerid, FounderPanelRestart[playerid]);
    TextDrawShowForPlayer(playerid, FounderPanelClose[playerid]);
    
    SelectTextDraw(playerid, 0xFF00FFFF);
    founder_panel_shown[playerid] = true;
    
    return 1;
}

HideFounderPanel(playerid) {
    if (FounderPanelBG[playerid] != Text:INVALID_TEXT_DRAW) {
        TextDrawDestroy(FounderPanelBG[playerid]);
        TextDrawDestroy(FounderPanelTitle[playerid]);
        TextDrawDestroy(FounderPanelServerSettings[playerid]);
        TextDrawDestroy(FounderPanelAntiCheat[playerid]);
        TextDrawDestroy(FounderPanelEconomy[playerid]);
        TextDrawDestroy(FounderPanelEvents[playerid]);
        TextDrawDestroy(FounderPanelAdminManager[playerid]);
        TextDrawDestroy(FounderPanelRestart[playerid]);
        TextDrawDestroy(FounderPanelClose[playerid]);
        
        FounderPanelBG[playerid] = Text:INVALID_TEXT_DRAW;
    }
    
    founder_panel_shown[playerid] = false;
    return 1;
}

RestartServer() {
    new query[256];
    mysql_format(mysql_handle, query, sizeof(query), "INSERT INTO server_logs (action, timestamp) VALUES ('SERVER_RESTART', NOW())");
    mysql_query(mysql_handle, query);
    
    SendClientMessageToAll(COLOR_WARNING, "[SERVER] Server will restart in 10 seconds...");
    SetTimer("DoServerRestart", 10000, false);
    
    return 1;
}

forward DoServerRestart();
public DoServerRestart() {
    SendRconCommand("gmx");
    return 1;
}
