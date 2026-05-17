// VALZZ FFA INDONESIA - Core Include
// Master Include File

// Include all headers and definitions
#include <a_samp>
#include <a_http>
#include <streamer>
#include <sscanf2>
#include <mysql>
#include <Whirlpool>
#include <YSI_Coding\y_hooks>

// Project Includes
#include "defines.inc"
#include "enums.inc"
#include "colors.inc"
#include "textdraws.inc"
#include "callbacks.inc"
#include "utils.inc"
#include "mysql_queries.inc"

// Compile-time checks
#if !defined MAX_PLAYERS
    #error "MAX_PLAYERS not defined"
#endif

#pragma unused ret_memcpy

public OnGameModeInit() {
    // Server initialization
    SetGameModeText(VALZZ_NAME);
    AddPlayerClass(0, LOBBY_X, LOBBY_Y, LOBBY_Z, LOBBY_ANGLE, 0, 0, 0, 0, 0, 0);
    return 1;
}

public OnGameModeExit() {
    // Server shutdown
    return 1;
}
