// VALZZ FFA INDONESIA - Auto Account Creation GUI
// TextDraw Interface for Account Setup

new Text:AccountCreatedBG[MAX_PLAYERS];
new Text:AccountCreatedTitle[MAX_PLAYERS];
new Text:AccountCreatedUCP[MAX_PLAYERS];
new Text:AccountCreatedIC[MAX_PLAYERS];
new Text:AccountCreatedPass[MAX_PLAYERS];
new Text:AccountCreatedConfirm[MAX_PLAYERS];
new Text:AccountCreatedInfo[MAX_PLAYERS];

new bool:account_gui_shown[MAX_PLAYERS];
new player_password[MAX_PLAYERS][32];

ShowAccountCreatedGUI(playerid) {
    new player_name[32];
    new generated_pass[32];
    new info_text[256];
    
    GetPlayerName(playerid, player_name, sizeof(player_name));
    GenerateSecurePassword(generated_pass, 12);
    format(player_password[playerid], 32, "%s", generated_pass);
    
    // Black background with neon border
    AccountCreatedBG[playerid] = TextDrawCreate(160.0, 120.0, "~h~");
    TextDrawBackgroundColor(AccountCreatedBG[playerid], 0);
    TextDrawFont(AccountCreatedBG[playerid], 1);
    TextDrawLetterSize(AccountCreatedBG[playerid], 0.5, 0.5);
    TextDrawTextSize(AccountCreatedBG[playerid], 480.0, 360.0);
    TextDrawSetOutline(AccountCreatedBG[playerid], 1);
    TextDrawSetProportional(AccountCreatedBG[playerid], 1);
    TextDrawSetShadow(AccountCreatedBG[playerid], 0);
    TextDrawColor(AccountCreatedBG[playerid], COLOR_NEON_GREEN);
    
    // Title
    AccountCreatedTitle[playerid] = TextDrawCreate(320.0, 135.0, "~g~[ACCOUNT CREATED]");
    TextDrawBackgroundColor(AccountCreatedTitle[playerid], 0);
    TextDrawFont(AccountCreatedTitle[playerid], 1);
    TextDrawLetterSize(AccountCreatedTitle[playerid], 0.4, 1.8);
    TextDrawSetOutline(AccountCreatedTitle[playerid], 1);
    TextDrawSetProportional(AccountCreatedTitle[playerid], 1);
    TextDrawColor(AccountCreatedTitle[playerid], COLOR_NEON_GREEN);
    
    // UCP Name
    format(info_text, sizeof(info_text), "~g~UCP: ~w~%s", player_name);
    AccountCreatedUCP[playerid] = TextDrawCreate(175.0, 180.0, info_text);
    TextDrawBackgroundColor(AccountCreatedUCP[playerid], 0);
    TextDrawFont(AccountCreatedUCP[playerid], 1);
    TextDrawLetterSize(AccountCreatedUCP[playerid], 0.35, 1.5);
    TextDrawSetOutline(AccountCreatedUCP[playerid], 1);
    TextDrawSetProportional(AccountCreatedUCP[playerid], 1);
    TextDrawColor(AccountCreatedUCP[playerid], COLOR_NEON_GREEN);
    
    // IC Name
    format(info_text, sizeof(info_text), "~g~IC: ~w~%s", player_name);
    AccountCreatedIC[playerid] = TextDrawCreate(175.0, 220.0, info_text);
    TextDrawBackgroundColor(AccountCreatedIC[playerid], 0);
    TextDrawFont(AccountCreatedIC[playerid], 1);
    TextDrawLetterSize(AccountCreatedIC[playerid], 0.35, 1.5);
    TextDrawSetOutline(AccountCreatedIC[playerid], 1);
    TextDrawSetProportional(AccountCreatedIC[playerid], 1);
    TextDrawColor(AccountCreatedIC[playerid], COLOR_NEON_GREEN);
    
    // Password
    format(info_text, sizeof(info_text), "~g~PASSWORD: ~w~%s", generated_pass);
    AccountCreatedPass[playerid] = TextDrawCreate(175.0, 260.0, info_text);
    TextDrawBackgroundColor(AccountCreatedPass[playerid], 0);
    TextDrawFont(AccountCreatedPass[playerid], 1);
    TextDrawLetterSize(AccountCreatedPass[playerid], 0.35, 1.5);
    TextDrawSetOutline(AccountCreatedPass[playerid], 1);
    TextDrawSetProportional(AccountCreatedPass[playerid], 1);
    TextDrawColor(AccountCreatedPass[playerid], COLOR_NEON_CYAN);
    
    // Info text
    AccountCreatedInfo[playerid] = TextDrawCreate(175.0, 300.0, "~g~Save your password in safe place!");
    TextDrawBackgroundColor(AccountCreatedInfo[playerid], 0);
    TextDrawFont(AccountCreatedInfo[playerid], 1);
    TextDrawLetterSize(AccountCreatedInfo[playerid], 0.32, 1.2);
    TextDrawSetOutline(AccountCreatedInfo[playerid], 1);
    TextDrawSetProportional(AccountCreatedInfo[playerid], 1);
    TextDrawColor(AccountCreatedInfo[playerid], COLOR_WARNING);
    
    // Confirm Button
    AccountCreatedConfirm[playerid] = TextDrawCreate(320.0, 340.0, "~g~[~w~ENTER SERVER~g~]");
    TextDrawBackgroundColor(AccountCreatedConfirm[playerid], 0);
    TextDrawFont(AccountCreatedConfirm[playerid], 1);
    TextDrawLetterSize(AccountCreatedConfirm[playerid], 0.35, 1.5);
    TextDrawTextSize(AccountCreatedConfirm[playerid], 420.0, 20.0);
    TextDrawSetOutline(AccountCreatedConfirm[playerid], 1);
    TextDrawSetProportional(AccountCreatedConfirm[playerid], 1);
    TextDrawSetSelectable(AccountCreatedConfirm[playerid], 1);
    TextDrawColor(AccountCreatedConfirm[playerid], COLOR_NEON_GREEN);
    
    // Show all TextDraws
    TextDrawShowForPlayer(playerid, AccountCreatedBG[playerid]);
    TextDrawShowForPlayer(playerid, AccountCreatedTitle[playerid]);
    TextDrawShowForPlayer(playerid, AccountCreatedUCP[playerid]);
    TextDrawShowForPlayer(playerid, AccountCreatedIC[playerid]);
    TextDrawShowForPlayer(playerid, AccountCreatedPass[playerid]);
    TextDrawShowForPlayer(playerid, AccountCreatedInfo[playerid]);
    TextDrawShowForPlayer(playerid, AccountCreatedConfirm[playerid]);
    
    SelectTextDraw(playerid, 0x00FF00FF);
    account_gui_shown[playerid] = true;
    
    PlayerInfo[playerid][menu_locked] = true;
    PlayerInfo[playerid][ucp_unlocked] = false;
    
    return 1;
}

HideAccountCreatedGUI(playerid) {
    if (AccountCreatedBG[playerid] != Text:INVALID_TEXT_DRAW) {
        TextDrawDestroy(AccountCreatedBG[playerid]);
        TextDrawDestroy(AccountCreatedTitle[playerid]);
        TextDrawDestroy(AccountCreatedUCP[playerid]);
        TextDrawDestroy(AccountCreatedIC[playerid]);
        TextDrawDestroy(AccountCreatedPass[playerid]);
        TextDrawDestroy(AccountCreatedInfo[playerid]);
        TextDrawDestroy(AccountCreatedConfirm[playerid]);
        
        AccountCreatedBG[playerid] = Text:INVALID_TEXT_DRAW;
    }
    
    account_gui_shown[playerid] = false;
}

ConfirmAccountEntry(playerid) {
    if (account_gui_shown[playerid]) {
        HideAccountCreatedGUI(playerid);
        PlayerInfo[playerid][ucp_unlocked] = true;
        PlayerInfo[playerid][menu_locked] = false;
        SpawnPlayerToLobby(playerid);
        return 1;
    }
    return 0;
}
