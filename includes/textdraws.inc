// VALZZ FFA INDONESIA - TextDraw Definitions
// Modern Futuristic UI

// Main Menu TextDraws
new Text:MainMenuBG;
new Text:MainMenuTitle;
new Text:ButtonPlay;
new Text:ButtonShop;
new Text:ButtonInventory;
new Text:ButtonProfile;
new Text:ButtonEvent;
new Text:ButtonDaily;
new Text:ButtonClan;
new Text:ButtonSettings;
new Text:ButtonSpin;
new Text:ButtonUCP;

// Lobby HUD
new Text:LobbyPlayerName;
new Text:LobbyLevel;
new Text:LobbyMoney;
new Text:LobbyKills;
new Text:LobbyDeaths;
new Text:LobbyLeaderboard[3];
new Text:LobbyTime;

// UCP TextDraws
new Text:UCPBackground;
new Text:UCPTitle;
new Text:UCPAccountInfo;
new Text:UCPStats;
new Text:UCPInventory;
new Text:UCPVehicles;
new Text:UCPSettings;
new Text:UCPCloseButton;

// Admin Panel TextDraws
new Text:AdminPanelBG;
new Text:AdminPanelTitle;
new Text:AdminPanelPlayerList;
new Text:AdminPanelActions;
new Text:AdminPanelLogs;

// Founder Control Center
new Text:FounderPanelBG;
new Text:FounderPanelTitle;
new Text:FounderPanelServerSettings;
new Text:FounderPanelAntiCheat;
new Text:FounderPanelEconomy;
new Text:FounderPanelEvents;
new Text:FounderPanelAdminManager;
new Text:FounderPanelLogs;

// HUD Elements
new Text:HUDHealth;
new Text:HUDArmor;
new Text:HUDAmmo;
new Text:HUDWeapon;
new Text:HUDMoney;
new Text:HUDKills;
new Text:HUDDeaths;
new Text:HUDPing;

// Loading Screen
new Text:LoadingBG;
new Text:LoadingBar;
new Text:LoadingText;
new Text:LoadingPercent;

// Notifications
new Text:NotificationBox;
new Text:NotificationText;

// Match Info
new Text:MatchInfoBG;
new Text:MatchScore[2];
new Text:MatchTime;
new Text:MatchPlayers[4];

// Safezone Indicator
new Text:SafezoneWarning;
new Text:SafezoneStatus;

// Creating TextDraws Function
CreateAllTextDraws() {
    // Main Menu Background
    MainMenuBG = TextDrawCreate(0.0, 0.0, " ");
    TextDrawBackgroundColor(MainMenuBG, 0);
    TextDrawFont(MainMenuBG, 1);
    TextDrawLetterSize(MainMenuBG, 0.5, 0.5);
    TextDrawTextSize(MainMenuBG, 640.0, 480.0);
    TextDrawSetOutline(MainMenuBG, 0);
    TextDrawSetProportional(MainMenuBG, 1);
    TextDrawSetShadow(MainMenuBG, 0);
    
    // Additional TextDraw initialization would follow same pattern
    // This provides the structure for modern UI
}

DestroyAllTextDraws() {
    TextDrawDestroy(MainMenuBG);
    TextDrawDestroy(MainMenuTitle);
    TextDrawDestroy(ButtonPlay);
    TextDrawDestroy(ButtonShop);
    TextDrawDestroy(ButtonInventory);
    TextDrawDestroy(ButtonProfile);
    TextDrawDestroy(ButtonEvent);
    TextDrawDestroy(ButtonDaily);
    TextDrawDestroy(ButtonClan);
    TextDrawDestroy(ButtonSettings);
    TextDrawDestroy(ButtonSpin);
    TextDrawDestroy(ButtonUCP);
    // ... destroy all other TextDraws
}
