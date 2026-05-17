// VALZZ FFA INDONESIA - Callback Headers
// Production-Ready Forward Declarations

// Server Callbacks
forward OnServerInit();
forward OnServerShutdown();
forward OnGameModeInit();
forward OnGameModeExit();

// Player Callbacks
forward OnPlayerConnect(playerid);
forward OnPlayerDisconnect(playerid, reason);
forward OnPlayerSpawn(playerid);
forward OnPlayerDeath(playerid, killerid, reason);
forward OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart);
forward OnPlayerGiveDamage(playerid, damageid, Float:amount, weaponid, bodypart);
forward OnPlayerText(playerid, text[]);
forward OnPlayerCommandText(playerid, cmdtext[]);
forward OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
forward OnPlayerEnterCheckpoint(playerid);
forward OnPlayerLeaveCheckpoint(playerid);
forward OnPlayerEnterRaceCheckpoint(playerid);
forward OnPlayerLeaveRaceCheckpoint(playerid);
forward OnPlayerClickTextDraw(playerid, Text:clickedid);
forward OnPlayerSelectObject(playerid, type, objectid, modelid, Float:fX, Float:fY, Float:fZ);
forward OnPlayerExitVehicle(playerid, vehicleid);
forward OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
forward OnPlayerStateChange(playerid, newstate, oldstate);

// Dialog Callbacks
forward OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);

// MySQL Callbacks
forward OnQueryFinish(query[], resultid, threadid, playerid);
forward OnAccountCreated(playerid);
forward OnAccountLoaded(playerid);
forward OnAccountSaved(playerid);

// Anti-Cheat Callbacks
forward OnCheatDetected(playerid, cheat_type, cheat_score);
forward OnCheatWarning(playerid);
forward OnCheatAction(playerid, action[]);

// Event Callbacks
forward OnEventStart(eventid, event_type[]);
forward OnEventEnd(eventid);
forward OnEventPlayerJoin(playerid, eventid);
forward OnEventPlayerLeave(playerid, eventid);

// Match Callbacks
forward OnMatchStart(matchid);
forward OnMatchEnd(matchid);
forward OnMatchReady(playerid, matchid);
forward OnMatchNotReady(playerid, matchid);

// Admin Callbacks
forward OnAdminAction(adminid, action[], targetid);
forward OnAdminWarning(playerid, adminid, reason[]);
forward OnAdminKick(playerid, adminid, reason[]);
forward OnAdminBan(playerid, adminid, reason[], ban_duration);

// Safezone Callbacks
forward OnPlayerEnterSafezone(playerid, safezone_id);
forward OnPlayerLeaveSafezone(playerid, safezone_id);
forward OnPlayerDamageInSafezone(playerid, issuerid);

// Weapon Callbacks
forward OnWeaponFired(playerid, weaponid);
forward OnPlayerReload(playerid, weaponid);

// Timer Callbacks
forward AntiCheatTimer();
forward SavePlayersTimer();
forward UpdateLeaderboard();
forward UpdateEventCheck();
forward CheckSessionExpiry();
