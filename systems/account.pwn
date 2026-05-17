// VALZZ FFA INDONESIA - Account System
// Auto Account Creation & Management

new MySQL:mysql_handle;
new bool:account_exists[MAX_PLAYERS];
new bool:account_loading[MAX_PLAYERS];

public OnGameModeInit() {
    // Initialize MySQL connection
    new MySQL:connection = mysql_connect_file("mysql.cfg");
    mysql_handle = connection;
    
    if (connection == MYSQL_INVALID_HANDLE) {
        print("[ERROR] Failed to connect to MySQL database!");
        SendRconCommand("exit");
        return 0;
    }
    
    print("[SUCCESS] MySQL database connected successfully!");
    CreateFounderAccount();
    return 1;
}

CreateFounderAccount() {
    // Auto-create founder account on server start
    new query[256];
    new pass_hash[65];
    
    WP_Hash(pass_hash, 65, "nouvalzz");
    
    mysql_format(mysql_handle, query, sizeof(query),
        "INSERT IGNORE INTO accounts (username, password, admin_level) VALUES ('%e', '%e', %d)",
        "valzz", pass_hash, ADMIN_FOUNDER);
    
    mysql_query(mysql_handle, query);
}

AutoCreateAccount(playerid) {
    new query[512];
    new player_name[32];
    new pass_hash[65];
    new password[32];
    
    GetPlayerName(playerid, player_name, sizeof(player_name));
    GenerateSecurePassword(password, 16);
    WP_Hash(pass_hash, 65, password);
    
    account_loading[playerid] = true;
    
    mysql_format(mysql_handle, query, sizeof(query),
        "INSERT INTO accounts (username, password, created_date, last_login, money, level, experience) VALUES ('%e', '%e', NOW(), NOW(), %d, 1, 0)",
        player_name, pass_hash, STARTER_MONEY);
    
    mysql_query(mysql_handle, query, "AutoCreateAccount_Callback", "d", playerid);
    
    return 1;
}

forward AutoCreateAccount_Callback(playerid);
public AutoCreateAccount_Callback(playerid) {
    if (!IsPlayerConnected(playerid)) return 0;
    
    new player_name[32];
    GetPlayerName(playerid, player_name, sizeof(player_name));
    
    account_exists[playerid] = true;
    account_loading[playerid] = false;
    
    LoadPlayerAccount(playerid);
    
    return 1;
}

LoadPlayerAccount(playerid) {
    new query[256];
    new player_name[32];
    
    GetPlayerName(playerid, player_name, sizeof(player_name));
    
    mysql_format(mysql_handle, query, sizeof(query),
        "SELECT * FROM accounts WHERE username = '%e' LIMIT 1",
        player_name);
    
    mysql_query(mysql_handle, query, "LoadAccount_Callback", "d", playerid);
}

forward LoadAccount_Callback(playerid);
public LoadAccount_Callback(playerid) {
    if (!IsPlayerConnected(playerid)) return 0;
    
    new result = cache_get_row_count();
    if (result > 0) {
        // Load account data
        cache_get_value_name_int(0, "id", PlayerInfo[playerid][account_id]);
        cache_get_value_name(0, "username", PlayerInfo[playerid][account_username], 32);
        cache_get_value_name(0, "password", PlayerInfo[playerid][account_password], 65);
        cache_get_value_name_int(0, "kills", PlayerInfo[playerid][kills]);
        cache_get_value_name_int(0, "deaths", PlayerInfo[playerid][deaths]);
        cache_get_value_name_int(0, "money", PlayerInfo[playerid][money]);
        cache_get_value_name_int(0, "level", PlayerInfo[playerid][level]);
        cache_get_value_name_int(0, "experience", PlayerInfo[playerid][experience]);
        cache_get_value_name_int(0, "admin_level", PlayerInfo[playerid][admin_level]);
        
        PlayerInfo[playerid][account_loaded] = true;
        PlayerInfo[playerid][is_logged_in] = true;
        
        GivePlayerMoney(playerid, PlayerInfo[playerid][money]);
        
        return 1;
    }
    
    return 0;
}

SavePlayerAccount(playerid) {
    if (!PlayerInfo[playerid][account_loaded]) return 0;
    
    new query[512];
    
    mysql_format(mysql_handle, query, sizeof(query),
        "UPDATE accounts SET kills = %d, deaths = %d, money = %d, level = %d, experience = %d, last_login = NOW() WHERE id = %d",
        PlayerInfo[playerid][kills],
        PlayerInfo[playerid][deaths],
        PlayerInfo[playerid][money],
        PlayerInfo[playerid][level],
        PlayerInfo[playerid][experience],
        PlayerInfo[playerid][account_id]);
    
    mysql_query(mysql_handle, query, "SaveAccount_Callback", "d", playerid);
    
    return 1;
}

forward SaveAccount_Callback(playerid);
public SaveAccount_Callback(playerid) {
    if (!IsPlayerConnected(playerid)) return 0;
    // Account saved successfully
    return 1;
}

GetAccountPassword(playerid, output[]) {
    format(output, 65, "%s", PlayerInfo[playerid][account_password]);
}

VerifyAccountPassword(playerid, const password[]) {
    new temp[65];
    WP_Hash(temp, 65, password);
    return !strcmp(temp, PlayerInfo[playerid][account_password]);
}

IsAccountLoaded(playerid) {
    return PlayerInfo[playerid][account_loaded];
}
