#!/bin/bash

# VALZZ FFA INDONESIA - Installation Script
# Linux/Ubuntu/Debian Compatible

echo "============================================"
echo "  VALZZ FFA INDONESIA - Installation"
echo "============================================"
echo ""

# Check if running on Termux
if [[ -d "/data/data/com.termux" ]]; then
    echo "[INFO] Termux environment detected"
    TERMUX=1
else
    TERMUX=0
fi

# Check for required tools
echo "[*] Checking dependencies..."

if ! command -v mysql &> /dev/null; then
    echo "[ERROR] MySQL client not found. Installing..."
    if [[ $TERMUX -eq 1 ]]; then
        apt-get update
        apt-get install -y mysql-client
    else
        sudo apt-get update
        sudo apt-get install -y mysql-client
    fi
fi

if ! command -v wget &> /dev/null; then
    echo "[ERROR] wget not found. Installing..."
    if [[ $TERMUX -eq 1 ]]; then
        apt-get install -y wget
    else
        sudo apt-get install -y wget
    fi
fi

echo "[OK] Dependencies installed"
echo ""

# Create directory structure
echo "[*] Creating directory structure..."
mkdir -p gamemode include systems filterscripts mysql scriptfiles logs config
echo "[OK] Directories created"
echo ""

# Create config files
echo "[*] Creating configuration files..."

if [ ! -f "mysql.cfg" ]; then
    cat > mysql.cfg << 'EOF'
driver = mysql
host = localhost
user = samp_user
password = samp_password
database = valzz_ffa
port = 3306
pool_size = 4
EOF
    echo "[OK] mysql.cfg created"
else
    echo "[SKIP] mysql.cfg already exists"
fi

if [ ! -f ".env" ]; then
    cp .env.example .env
    echo "[OK] .env created"
else
    echo "[SKIP] .env already exists"
fi

echo ""
echo "[*] Setting up MySQL database..."
echo "[!] Make sure MySQL is running!"
echo ""
read -p "Enter MySQL root password: " mysql_pass
read -p "Enter desired database username [samp_user]: " db_user
db_user=${db_user:-samp_user}
read -p "Enter desired database password [samp_password]: " db_pass
db_pass=${db_pass:-samp_password}

echo ""
echo "[*] Creating database and user..."

mysql -u root -p"$mysql_pass" << EOF
CREATE DATABASE IF NOT EXISTS valzz_ffa CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '$db_user'@'localhost' IDENTIFIED BY '$db_pass';
GRANT ALL PRIVILEGES ON valzz_ffa.* TO '$db_user'@'localhost';
FLUSH PRIVILEGES;
EOF

if [ $? -eq 0 ]; then
    echo "[OK] Database created successfully"
    
    # Import schema
    echo "[*] Importing database schema..."
    mysql -u "$db_user" -p"$db_pass" valzz_ffa < mysql/schema.sql
    
    if [ $? -eq 0 ]; then
        echo "[OK] Schema imported successfully"
    else
        echo "[ERROR] Failed to import schema"
        exit 1
    fi
else
    echo "[ERROR] Failed to create database"
    exit 1
fi

# Update mysql.cfg with actual credentials
cat > mysql.cfg << EOF
driver = mysql
host = localhost
user = $db_user
password = $db_pass
database = valzz_ffa
port = 3306
pool_size = 4
EOF

echo ""
echo "[OK] MySQL credentials saved to mysql.cfg"
echo ""

# Download SA-MP server
echo "[*] Checking SA-MP server binary..."

if [ ! -f "samp03svr" ] && [ ! -f "samp03svr.exe" ]; then
    echo "[DOWNLOAD] You need to manually place SA-MP server binary in this directory"
    echo "[INFO] Download from: https://www.sa-mp.com/"
    echo ""
else
    echo "[OK] SA-MP server binary found"
fi

echo ""
echo "============================================"
echo "  Installation Complete!"
echo "============================================"
echo ""
echo "Next steps:"
echo "1. Run: bash compile.sh (to compile gamemode)"
echo "2. Run: bash start.sh (to start server)"
echo ""
echo "MySQL Credentials:"
echo "  User: $db_user"
echo "  Pass: $db_pass"
echo "  DB: valzz_ffa"
echo ""
