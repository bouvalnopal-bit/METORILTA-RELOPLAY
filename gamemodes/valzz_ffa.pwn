// VALZZ FFA INDONESIA - Main Gamemode
// Production-Ready SA-MP Server 2026

#define FILTERSCRIPT 0
#include <a_samp>
#include <a_http>
#include <streamer>
#include <sscanf2>
#include <mysql>
#include <Whirlpool>
#include <YSI_Coding\y_hooks>

// Master Include
#include "../includes/core.inc"

public OnGameModeInit() {
    SetGameModeText("VALZZ FFA INDONESIA");
    ShowPlayerMarkers(1);
    ShowNameTags(1);
    AllowAdminTeleport(1);
    
    // Add player class
    AddPlayerClass(0, LOBBY_X, LOBBY_Y, LOBBY_Z, LOBBY_ANGLE, 0, 0, 0, 0, 0, 0);
    
    // Initialize systems
    InitializeWeaponSystem();
    CreateSafezones();
    CreateAllTextDraws();
    
    // Set server weather and time
    SetWeather(10);
    SetWorldTime(14);
    
    // Set server gravity
    SetGravityForPlayer(INVALID_PLAYER_ID, 0.008);
    
    // Start timers
    SetTimer("AntiCheatTimer", TIMER_ANTICHEAT, true);
    SetTimer("SavePlayersTimer", TIMER_SAVE_PLAYER, true);
    SetTimer("UpdateLeaderboard", TIMER_LEADERBOARD, true);
    SetTimer("UpdateEventCheck", TIMER_EVENT_CHECK, true);
    SetTimer("CheckPlayerSafezonesTimer", 1000, true);
    
    print("\n\n========================================");
    print("  VALZZ FFA INDONESIA - Server Started");
    print("  Version: 1.0.0");
    print("  Mode: Open World FFA + Matchmaking");
    print("  Players: 200 Max");
    print("========================================\n\n");
    
    return 1;
}

public OnGameModeExit() {
    // Save all player data
    for (new i = 0; i < MAX_PLAYERS; i++) {
        if (IsPlayerConnected(i)) {
            if (PlayerInfo[i][account_loaded]) {
                SavePlayerAccount(i);
            }
        }
    }
    
    // Cleanup
    DestroyAllTextDraws();
    
    return 1;
}

public OnPlayerConnect(playerid) {
    // Initialize player variables
    ResetPlayerVariables(playerid);
    
    new player_name[32];
    GetPlayerName(playerid, player_name, sizeof(player_name));
    
    printf("[CONNECT] Player %s (ID: %d) connected", player_name, playerid);
    
    // Show intro cinematic
    SetPlayerCameraPos(playerid, LOBBY_X + 50, LOBBY_Y + 50, LOBBY_Z + 50);
    SetPlayerCameraLookAt(playerid, LOBBY_X, LOBBY_Y, LOBBY_Z);
    TogglePlayerControllable(playerid, 0); // Freeze during cinematic
    
    // Show blackscreen intro
    TextDrawShowForPlayer(playerid, LoadingBG);
    TextDrawShowForPlayer(playerid, LoadingText);
    
    // Check if account exists
    CheckAccountExists(playerid);
    
    return 1;
}

CheckAccountExists(playerid) {
    new player_name[32];
    new query[256];
    
    GetPlayerName(playerid, player_name, sizeof(player_name));
    
    mysql_format(mysql_handle, query, sizeof(query),
        "SELECT id FROM accounts WHERE username = '%e' LIMIT 1",
        player_name);
    
    mysql_query(mysql_handle, query, "CheckAccount_Callback", "d", playerid);
}

forward CheckAccount_Callback(playerid);
public CheckAccount_Callback(playerid) {
    if (!IsPlayerConnected(playerid)) return 0;
    
    if (cache_get_row_count() > 0) {
        // Account exists, load it
        LoadPlayerAccount(playerid);
    } else {
        // Create new account
        AutoCreateAccount(playerid);
    }
    
    return 1;
}

ResetPlayerVariables(playerid) {
    PlayerInfo[playerid][account_loaded] = false;
    PlayerInfo[playerid][is_logged_in] = false;
    PlayerInfo[playerid][is_in_lobby] = false;
    PlayerInfo[playerid][in_safezone] = false;
    PlayerInfo[playerid][is_admin] = false;
    PlayerInfo[playerid][kills] = 0;
    PlayerInfo[playerid][deaths] = 0;
    PlayerInfo[playerid][money] = 0;
    PlayerInfo[playerid][level] = 1;
    PlayerInfo[playerid][experience] = 0;
    PlayerInfo[playerid][cheat_score] = 0;
    PlayerInfo[playerid][cheat_warnings] = 0;
    PlayerInfo[playerid][menu_locked] = true;
    PlayerInfo[playerid][ucp_unlocked] = false;
    ResetPlayerAntiCheatScore(playerid);
}

public OnPlayerDisconnect(playerid, reason) {
    new player_name[32];
    GetPlayerName(playerid, player_name, sizeof(player_name));
    
    // Save account
    if (PlayerInfo[playerid][account_loaded]) {
        SavePlayerAccount(playerid);
    }
    
    // Leave queue if in matchmaking
    if (player_in_queue[playerid]) {
        LeaveMatchQueue(playerid);
    }
    
    new reason_str[32];
    switch(reason) {
        case 0: format(reason_str, 32, "Timeout");
        case 1: format(reason_str, 32, "Quit");
        case 2: format(reason_str, 32, "Kicked");
    }
    
    printf("[DISCONNECT] Player %s (ID: %d) disconnected - Reason: %s", player_name, playerid, reason_str);
    
    return 1;
}

public OnPlayerSpawn(playerid) {
    if (!PlayerInfo[playerid][account_loaded]) return 0;
    
    // Spawn to lobby if account just created
    if (PlayerInfo[playerid][ucp_unlocked]) {
        SpawnPlayerToLobby(playerid);
    }
    
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason) {
    if (IsPlayerConnected(killerid)) {
        // Award kill
        PlayerInfo[killerid][kills]++;
        
        // Check for headshot (simplified)
        new headshot = (reason == 34) ? 1 : 0;
        new knife = (reason == 4) ? 1 : 0;
        
        // Give reward
        GiveKillReward(killerid, playerid, bool:headshot, bool:knife);
        
        if (headshot) {
            SendClientMessage(killerid, COLOR_NORMAL_KILL, "[KILL] Headshot! +$1000");
        } else if (knife) {
            SendClientMessage(killerid, COLOR_KNIFE_KILL, "[KILL] Knife kill! +$1500");
        } else {
            SendClientMessage(killerid, COLOR_NORMAL_KILL, "[KILL] +$500");
        }
    }
    
    PlayerInfo[playerid][deaths]++;
    
    // Respawn after 3 seconds
    SetTimerEx("RespawnPlayer", 3000, false, "d", playerid);
    
    return 1;
}

forward RespawnPlayer(playerid);
public RespawnPlayer(playerid) {
    if (IsPlayerConnected(playerid)) {
        if (PlayerInfo[playerid][is_in_lobby]) {
            SpawnPlayerToLobby(playerid);
        } else if (PlayerInfo[playerid][current_gamemode] == 1) {
            SpawnPlayerToOpenWorld(playerid);
        }
    }
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
    // F key to open main menu
    if (newkeys & KEY_SECONDARY_ATTACK && !(oldkeys & KEY_SECONDARY_ATTACK)) {
        if (!PlayerInfo[playerid][menu_locked]) {
            ShowMainMenu(playerid);
        }
    }
    
    return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid) {
    if (admin_panel_shown[playerid]) {
        if (clickedid == AdminPanelClose[playerid]) {
            HideAdminPanel(playerid);
        }
    }
    
    if (founder_panel_shown[playerid]) {
        if (clickedid == FounderPanelClose[playerid]) {
            HideFounderPanel(playerid);
        }
    }
    
    if (account_gui_shown[playerid]) {
        if (clickedid == AccountCreatedConfirm[playerid]) {
            ConfirmAccountEntry(playerid);
        }
    }
    
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[]) {
    if (sscanf(cmdtext, "s[256]", cmdtext)) return 0;
    
    if (!strcmp(cmdtext, "/help", true)) {
        SendClientMessage(playerid, COLOR_INFO, "=== VALZZ FFA COMMANDS ===");
        SendClientMessage(playerid, COLOR_INFO, "/play - Join Open World FFA");
        SendClientMessage(playerid, COLOR_INFO, "/ucp - Open User Control Panel");
        SendClientMessage(playerid, COLOR_INFO, "/stats - View your statistics");
        SendClientMessage(playerid, COLOR_INFO, "/admin - Open admin panel (admins only)");
        SendClientMessage(playerid, COLOR_INFO, "/founderpanel - Founder control center");
        return 1;
    }
    
    if (!strcmp(cmdtext, "/play", true)) {
        if (!PlayerInfo[playerid][is_in_lobby]) {
            SendClientMessage(playerid, COLOR_ERROR, "[ERROR] You are not in lobby!");
            return 1;
        }
        SpawnPlayerToOpenWorld(playerid);
        return 1;
    }
    
    if (!strcmp(cmdtext, "/ucp", true)) {
        ShowUCPPanel(playerid);
        return 1;
    }
    
    if (!strcmp(cmdtext, "/stats", true)) {
        ShowPlayerStats(playerid);
        return 1;
    }
    
    if (!strcmp(cmdtext, "/admin", true)) {
        if (PlayerInfo[playerid][admin_level] >= ADMIN_HELPER) {
            ShowAdminPanel(playerid);
        } else {
            SendClientMessage(playerid, COLOR_ERROR, "[ERROR] You are not an admin!");
        }
        return 1;
    }
    
    if (!strcmp(cmdtext, "/founderpanel", true)) {
        if (PlayerInfo[playerid][admin_level] == ADMIN_FOUNDER) {
            ShowFounderPanel(playerid);
        } else {
            SendClientMessage(playerid, COLOR_ERROR, "[ERROR] Only founder can access this!");
        }
        return 1;
    }
    
    return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    switch(dialogid) {
        case DIALOG_CONFIRM_ENTRY: {
            if (response) {
                ConfirmAccountEntry(playerid);
            }
        }
    }
    return 0;
}

// Timer Callbacks
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

public SavePlayersTimer() {
    for (new i = 0; i < MAX_PLAYERS; i++) {
        if (!IsPlayerConnected(i)) continue;
        if (!PlayerInfo[i][account_loaded]) continue;
        SavePlayerAccount(i);
    }
}

public UpdateLeaderboard() {
    // Update top players in lobby
    // This would refresh NPC clones and displays
}

public UpdateEventCheck() {
    // Check for random event triggers
    if (!IsEventActive()) {
        if (random(100) < 5) { // 5% chance per minute
            StartRandomEvent();
        }
    }
}

public CheckPlayerSafezonesTimer() {
    for (new i = 0; i < MAX_PLAYERS; i++) {
        if (!IsPlayerConnected(i)) continue;
        CheckPlayerSafezone(i);
    }
}

// Placeholder UI Functions
ShowMainMenu(playerid) {
    SendClientMessage(playerid, COLOR_INFO, "[MAIN MENU] /play /shop /inventory /profile /event /daily /clan /settings /spin /ucp");
}

ShowUCPPanel(playerid) {
    SendClientMessage(playerid, COLOR_INFO, "[UCP] Account | Stats | Inventory | Vehicles | Clan | Notifications | Settings");
}

ShowPlayerStats(playerid) {
    new msg[512];
    new Float:kdr;
    GetPlayerKDRatio(playerid, kdr);
    
    format(msg, sizeof(msg), 
        "~g~[STATISTICS]~n~~w~Level: %d~n~Kills: %d~n~Deaths: %d~n~K/D Ratio: %.2f~n~Money: $%d~n~Experience: %d",
        PlayerInfo[playerid][level],
        PlayerInfo[playerid][kills],
        PlayerInfo[playerid][deaths],
        kdr,
        PlayerInfo[playerid][money],
        PlayerInfo[playerid][experience]);
    
    SendClientMessage(playerid, COLOR_INFO, msg);
}
