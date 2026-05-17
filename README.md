# VALZZ FFA INDONESIA

**Modern SA-MP Open World FFA Server - 2026 Edition**

## Features

- ✅ Open World FFA on Full GTA SA Map
- ✅ Auto Account Creation System
- ✅ Full In-Game UCP (TextDraw GUI)
- ✅ Modern Futuristic Lobby
- ✅ Matchmaking System (1v1, 2v2, 3v3, 4v4, Ranked)
- ✅ Advanced Anti-Cheat
- ✅ Safezone System
- ✅ Vehicle System
- ✅ Event System (Bounty, Supply Drop, Boss Raid)
- ✅ Admin/Founder Control Center
- ✅ Real-time Leaderboard
- ✅ Kill Reward System
- ✅ MySQL Database Integration
- ✅ Production-Ready Code

## Quick Start

### On Linux/Codespaces

```bash
# Install dependencies
bash install.sh

# Compile server
bash compile.sh

# Start server
bash start.sh
```

### On Termux (Android)

```bash
bash install.sh
bash compile.sh
bash start.sh
```

## Configuration

1. Copy `.env.example` to `.env`
2. Configure MySQL credentials
3. Run `bash install.sh` to create database
4. Run `bash compile.sh` to compile
5. Run `bash start.sh` to start server

## Default Accounts

**Founder Account:**
- Username: `valzz`
- Password: `nouvalzz`
- Access: Full Server Control

## Server Structure

```
gamemode/          - Main gamemode
includes/          - All includes
systems/           - Modular systems
filterscripts/      - Filterscripts
mysql/             - Database schemas
config/            - Configuration files
scriptfiles/       - Runtime data
logs/              - Server logs
```

## Supported Platforms

- ✅ Linux (Ubuntu, Debian)
- ✅ GitHub Codespaces
- ✅ Android Termux
- ✅ Windows (WSL)

## System Requirements

- Pawn Compiler 3.10+
- MySQL Server
- SA-MP Server Binary

## License

Valzz FFA Indonesia © 2026
