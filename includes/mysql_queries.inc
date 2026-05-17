// VALZZ FFA INDONESIA - MySQL Query Definitions
// Production-Ready Queries

// Account Queries
#define QUERY_CREATE_ACCOUNT "INSERT INTO accounts (username, password, created_date, last_login) VALUES ('%e', '%e', NOW(), NOW())"
#define QUERY_GET_ACCOUNT "SELECT * FROM accounts WHERE username = '%e' LIMIT 1"
#define QUERY_UPDATE_ACCOUNT "UPDATE accounts SET kills = %d, deaths = %d, money = %d, level = %d, experience = %d WHERE id = %d"
#define QUERY_LOAD_ACCOUNT "SELECT * FROM accounts WHERE id = %d LIMIT 1"
#define QUERY_CHECK_USERNAME "SELECT id FROM accounts WHERE username = '%e' LIMIT 1"
#define QUERY_UPDATE_LOGIN "UPDATE accounts SET last_login = NOW() WHERE id = %d"

// Stats Queries
#define QUERY_GET_LEADERBOARD "SELECT username, kills, deaths, level FROM accounts ORDER BY kills DESC LIMIT 10"
#define QUERY_INCREMENT_KILLS "UPDATE accounts SET kills = kills + 1 WHERE id = %d"
#define QUERY_INCREMENT_DEATHS "UPDATE accounts SET deaths = deaths + 1 WHERE id = %d"
#define QUERY_ADD_MONEY "UPDATE accounts SET money = money + %d WHERE id = %d"
#define QUERY_ADD_EXP "UPDATE accounts SET experience = experience + %d WHERE id = %d"

// Admin Queries
#define QUERY_GET_ADMIN_LEVEL "SELECT admin_level FROM accounts WHERE id = %d LIMIT 1"
#define QUERY_SET_ADMIN_LEVEL "UPDATE accounts SET admin_level = %d WHERE id = %d"
#define QUERY_GET_ALL_ADMINS "SELECT id, username, admin_level FROM accounts WHERE admin_level > 0 ORDER BY admin_level DESC"

// Ban Queries
#define QUERY_GET_BAN_INFO "SELECT id, reason, unban_date FROM bans WHERE player_id = %d AND active = 1 LIMIT 1"
#define QUERY_CREATE_BAN "INSERT INTO bans (player_id, reason, ban_date, unban_date, active) VALUES (%d, '%e', NOW(), DATE_ADD(NOW(), INTERVAL %d DAY), 1)"
#define QUERY_REMOVE_BAN "UPDATE bans SET active = 0 WHERE id = %d"

// Match Queries
#define QUERY_CREATE_MATCH "INSERT INTO matches (match_type, status, start_time) VALUES ('%e', 'active', NOW())"
#define QUERY_END_MATCH "UPDATE matches SET status = 'completed', end_time = NOW() WHERE id = %d"
#define QUERY_INSERT_MATCH_PLAYER "INSERT INTO match_players (match_id, player_id, team, kills, deaths) VALUES (%d, %d, %d, 0, 0)"

// Vehicle Queries
#define QUERY_GET_VEHICLES "SELECT * FROM vehicles WHERE owner_id = %d"
#define QUERY_SAVE_VEHICLE "INSERT INTO vehicles (owner_id, model, color1, color2, x, y, z, angle) VALUES (%d, %d, %d, %d, %f, %f, %f, %f)"
#define QUERY_UPDATE_VEHICLE "UPDATE vehicles SET color1 = %d, color2 = %d, x = %f, y = %f, z = %f, angle = %f WHERE id = %d"

// Anti-Cheat Queries
#define QUERY_LOG_CHEAT "INSERT INTO anticheat_logs (player_id, player_name, cheat_type, score, timestamp, action) VALUES (%d, '%e', '%e', %d, NOW(), '%e')"
#define QUERY_GET_CHEAT_HISTORY "SELECT * FROM anticheat_logs WHERE player_id = %d ORDER BY timestamp DESC LIMIT 20"

// Event Queries
#define QUERY_CREATE_EVENT "INSERT INTO events (event_type, active, start_time) VALUES ('%e', 1, NOW())"
#define QUERY_END_EVENT "UPDATE events SET active = 0, end_time = NOW() WHERE id = %d"
#define QUERY_ADD_EVENT_PLAYER "INSERT INTO event_players (event_id, player_id, reward) VALUES (%d, %d, %d)"

// Session Queries
#define QUERY_CREATE_SESSION "INSERT INTO sessions (account_id, token, created_at, expires_at) VALUES (%d, '%e', NOW(), DATE_ADD(NOW(), INTERVAL 1 HOUR))"
#define QUERY_GET_SESSION "SELECT * FROM sessions WHERE token = '%e' AND active = 1 AND expires_at > NOW() LIMIT 1"
#define QUERY_INVALIDATE_SESSION "UPDATE sessions SET active = 0 WHERE account_id = %d"
