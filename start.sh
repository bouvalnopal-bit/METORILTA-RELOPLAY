#!/bin/bash

# VALZZ FFA INDONESIA - Server Start Script
# Linux/Termux Compatible

echo "============================================"
echo "  VALZZ FFA INDONESIA - Starting Server"
echo "============================================"
echo ""

# Check if binary exists
if [ ! -f "samp03svr" ] && [ ! -f "samp03svr.exe" ]; then
    echo "[ERROR] SA-MP server binary not found!"
    echo "[INFO] Download from: https://www.sa-mp.com/"
    exit 1
fi

# Check if compiled
if [ ! -f "gamemodes/valzz_ffa.amx" ]; then
    echo "[ERROR] Gamemode not compiled!"
    echo "[INFO] Run: bash compile.sh"
    exit 1
fi

# Check MySQL connection
echo "[*] Checking MySQL connection..."

if grep -q "mysql.cfg" server.cfg; then
    echo "[OK] MySQL configured"
else
    echo "[WARNING] MySQL config not found in server.cfg"
fi

echo ""
echo "[*] Starting SA-MP Server..."
echo ""

# Run server
if [ -f "samp03svr" ]; then
    # Linux binary
    ./samp03svr
elif [ -f "samp03svr.exe" ]; then
    # Windows binary (via Wine if on Linux)
    wine ./samp03svr.exe
fi

echo ""
echo "[INFO] Server stopped"
