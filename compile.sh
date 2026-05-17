#!/bin/bash

# VALZZ FFA INDONESIA - Compile Script
# Converts .pwn to .amx

echo "============================================"
echo "  VALZZ FFA - Compilation"
echo "============================================"
echo ""

# Check if pawn compiler exists
if [ ! -f "pawncc" ]; then
    echo "[ERROR] Pawn compiler not found!"
    echo "[INFO] Download from: https://www.compuphase.com/pawn/pawncc.htm"
    exit 1
fi

echo "[*] Compiling gamemode..."
echo ""

# Compile main gamemode
if [ -f "gamemodes/valzz_ffa.pwn" ]; then
    ./pawncc gamemodes/valzz_ffa.pwn -o gamemodes/valzz_ffa.amx -i includes -i systems -l -v2
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "[OK] Gamemode compiled successfully!"
    else
        echo ""
        echo "[ERROR] Compilation failed!"
        exit 1
    fi
else
    echo "[ERROR] valzz_ffa.pwn not found"
    exit 1
fi

echo ""
echo "[*] Compiling filterscripts..."

if [ -f "filterscripts/npc_system.pwn" ]; then
    ./pawncc filterscripts/npc_system.pwn -o filterscripts/npc_system.amx -i includes -l -v2
fi

if [ -f "filterscripts/safezone_system.pwn" ]; then
    ./pawncc filterscripts/safezone_system.pwn -o filterscripts/safezone_system.amx -i includes -l -v2
fi

echo ""
echo "============================================"
echo "  Compilation Complete!"
echo "============================================"
echo ""
echo "Next: Run bash start.sh"
echo ""
