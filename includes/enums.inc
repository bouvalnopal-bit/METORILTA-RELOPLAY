// VALZZ FFA INDONESIA - Enumerators
// Production-Ready Data Structures

enum PlayerData {
    // Account Info
    bool:account_loaded,
    account_id,
    account_username[32],
    account_password[65],
    account_created,
    account_last_login,
    
    // Session
    bool:is_logged_in,
    bool:is_in_lobby,
    session_token[32],
    session_start,
    
    // Stats
    kills,
    deaths,
    headshots,
    money,
    level,
    experience,
    
    // Admin
    admin_level,
    bool:is_admin,
    
    // Safezone
    bool:in_safezone,
    safezone_id,
    
    // Anti-Cheat
    cheat_score,
    cheat_warnings,
    cheat_last_check,
    
    // State
    current_gamemode,
    bool:is_in_match,
    bool:is_spectating,
    
    // Combat
    current_weapon,
    current_ammo,
    health,
    armor,
    
    // Misc
    bool:ucp_unlocked,
    bool:menu_locked,
    tutorial_completed,
};

new PlayerInfo[MAX_PLAYERS][PlayerData];

enum AccountData {
    acc_id,
    acc_username[32],
    acc_password[65],
    acc_email[128],
    acc_kills,
    acc_deaths,
    acc_level,
    acc_experience,
    acc_money,
    acc_admin_level,
    acc_created_date,
    acc_last_login,
    acc_playtime,
    acc_banned,
    acc_ban_reason[256],
};

enum SafezoneData {
    safezone_id,
    Float:safezone_x,
    Float:safezone_y,
    Float:safezone_z,
    Float:safezone_radius,
    safezone_type[32],
    bool:safezone_active,
};

enum WeaponData {
    weapon_id,
    weapon_name[32],
    weapon_damage,
    weapon_ammo,
    weapon_reload_time,
    weapon_cooldown,
    bool:weapon_allowed,
};

enum VehicleData {
    veh_id,
    veh_model,
    veh_owner,
    veh_color1,
    veh_color2,
    Float:veh_x,
    Float:veh_y,
    Float:veh_z,
    Float:veh_angle,
    bool:veh_saved,
};

enum MatchData {
    match_id,
    match_type,
    match_status,
    match_players[4],
    match_team1_score,
    match_team2_score,
    match_start_time,
    match_end_time,
    Float:match_arena_x,
    Float:match_arena_y,
    Float:match_arena_z,
};

enum EventData {
    event_id,
    event_type[32],
    event_active,
    event_start_time,
    event_target_player,
    event_reward,
};

enum AntiCheatLog {
    log_id,
    log_player_id,
    log_player_name[32],
    log_cheat_type[64],
    log_score,
    log_timestamp,
    log_action[32],
};
