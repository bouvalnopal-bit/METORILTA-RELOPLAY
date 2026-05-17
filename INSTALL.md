# VALZZ FFA INDONESIA Server Documentation

## Installation Guide

### Prerequisites
- Linux/Ubuntu/Debian or Android Termux
- MySQL Server running
- Pawn Compiler (pawncc)
- SA-MP Server Binary

### Step 1: Install Dependencies

```bash
bash install.sh
```

This will:
- Check for required tools
- Create directory structure
- Setup MySQL database
- Import database schema

### Step 2: Configure Server

Edit `server.cfg` with your settings:
```cfg
port 7777
hostname VALZZ FFA INDONESIA
gamemode0 valzz_ffa
maxplayers 200
```

### Step 3: Compile

```bash
bash compile.sh
```

This compiles:
- Main gamemode (valzz_ffa.pwn → valzz_ffa.amx)
- All filterscripts
- All includes

### Step 4: Start Server

```bash
bash start.sh
```

Server will start on configured port.

## Default Accounts

**Founder Account:**
- Username: `valzz`
- Password: `nouvalzz`
- Access: Full server control

## Player Flow

### First Join
1. Player connects to server
2. Blackscreen cinematic plays
3. Account automatically created
4. Account info displayed (UCP, IC, Password)
5. Player confirms entry
6. Spawned in Main Lobby

### Lobby
- Main menu access
- Statistics viewing
- Gamemode selection
- UCP access

### Open World FFA
- Full GTA SA map
- PvP enabled
- Kill rewards
- Vehicle system
- Event system

## System Features

### Auto Account Creation
- No manual registration needed
- Username = SA-MP nickname
- Auto-generated password
- MySQL saved
- Session tracking

### In-Game UCP
- Account settings
- Statistics display
- Inventory management
- Vehicle garage
- Clan management
- Settings

### Advanced Anti-Cheat
- Weapon hack detection
- Speed hack detection
- Aimbot detection
- Health hack detection
- Money hack detection
- Scoring system
- Auto-ban at high score

### Matchmaking
- Queue system
- 1v1, 2v2, 3v3, 4v4 modes
- Ready check system
- Arena teleport
- Match tracking

### Events
- Bounty Hunter
- Supply Drop
- Boss Raid
- Global notifications
- Reward system

### Admin System
- 6 admin levels
- GUI admin panel
- Moderation tools
- Spectate function
- Action logging

### Founder Control Center
- Server settings
- Anti-cheat configuration
- Economy control
- Event management
- Admin manager
- System logs
- Server restart

## Database Schema

### Main Tables
- `accounts` - Player accounts
- `sessions` - Active sessions
- `bans` - Ban records
- `vehicles` - Saved vehicles
- `matches` - Match history
- `anticheat_logs` - Cheat detection logs
- `events` - Global events
- `admin_logs` - Admin actions
- `inventory` - Player items

## Commands

### Player Commands
```
/help           - Show help
/play           - Join Open World FFA
/ucp            - Open UCP
/stats          - View stats
/leaderboard    - Show top players
```

### Admin Commands
```
/admin          - Open admin panel
/warn <id>      - Warn player
/kick <id>      - Kick player
/ban <id>       - Ban player
```

### Founder Commands
```
/founderpanel   - Open founder panel
```

## Troubleshooting

### MySQL Connection Error
- Check MySQL is running
- Verify credentials in mysql.cfg
- Check database exists

### Compilation Error
- Check pawncc is in server directory
- Check includes path is correct
- Check .pwn files syntax

### Server Won't Start
- Check port is not in use
- Check SA-MP binary exists
- Check gamemode compiled to .amx
- Check plugins loaded correctly

## Performance Tips

1. Enable query caching in MySQL
2. Optimize database indexes
3. Use filterscripts for heavy operations
4. Limit player count per world
5. Enable object streaming
6. Use dynamic objects instead of static

## Security

- All passwords hashed with Whirlpool
- Session tokens validated
- Anti-cheat monitoring
- Admin action logging
- IP tracking
- Ban system with appeals

## Support

For issues or questions:
1. Check logs in `/logs/` directory
2. Review MySQL error logs
3. Check server console output
4. Verify all dependencies installed

## License

VALZZ FFA INDONESIA © 2026
All rights reserved.
