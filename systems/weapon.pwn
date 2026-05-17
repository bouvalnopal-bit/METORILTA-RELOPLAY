// VALZZ FFA INDONESIA - Weapon System
// Balanced Weapons with Realistic Mechanics

new weapon_info[47][WeaponData];

InitializeWeaponSystem() {
    // Desert Eagle
    weapon_info[WEAPON_DEAGLE][weapon_id] = WEAPON_DEAGLE;
    format(weapon_info[WEAPON_DEAGLE][weapon_name], 32, "Desert Eagle");
    weapon_info[WEAPON_DEAGLE][weapon_damage] = 45;
    weapon_info[WEAPON_DEAGLE][weapon_ammo] = 70;
    weapon_info[WEAPON_DEAGLE][weapon_reload_time] = 1800;
    weapon_info[WEAPON_DEAGLE][weapon_cooldown] = 300;
    weapon_info[WEAPON_DEAGLE][weapon_allowed] = true;
    
    // MP5
    weapon_info[WEAPON_MP5][weapon_id] = WEAPON_MP5;
    format(weapon_info[WEAPON_MP5][weapon_name], 32, "MP5");
    weapon_info[WEAPON_MP5][weapon_damage] = 28;
    weapon_info[WEAPON_MP5][weapon_ammo] = 120;
    weapon_info[WEAPON_MP5][weapon_reload_time] = 2200;
    weapon_info[WEAPON_MP5][weapon_cooldown] = 150;
    weapon_info[WEAPON_MP5][weapon_allowed] = true;
    
    // AK47
    weapon_info[WEAPON_AK47][weapon_id] = WEAPON_AK47;
    format(weapon_info[WEAPON_AK47][weapon_name], 32, "AK47");
    weapon_info[WEAPON_AK47][weapon_damage] = 35;
    weapon_info[WEAPON_AK47][weapon_ammo] = 150;
    weapon_info[WEAPON_AK47][weapon_reload_time] = 2500;
    weapon_info[WEAPON_AK47][weapon_cooldown] = 200;
    weapon_info[WEAPON_AK47][weapon_allowed] = true;
    
    // M4
    weapon_info[WEAPON_M4][weapon_id] = WEAPON_M4;
    format(weapon_info[WEAPON_M4][weapon_name], 32, "M4");
    weapon_info[WEAPON_M4][weapon_damage] = 38;
    weapon_info[WEAPON_M4][weapon_ammo] = 150;
    weapon_info[WEAPON_M4][weapon_reload_time] = 2400;
    weapon_info[WEAPON_M4][weapon_cooldown] = 180;
    weapon_info[WEAPON_M4][weapon_allowed] = true;
    
    // Shotgun
    weapon_info[WEAPON_SHOTGUN][weapon_id] = WEAPON_SHOTGUN;
    format(weapon_info[WEAPON_SHOTGUN][weapon_name], 32, "Shotgun");
    weapon_info[WEAPON_SHOTGUN][weapon_damage] = 50;
    weapon_info[WEAPON_SHOTGUN][weapon_ammo] = 80;
    weapon_info[WEAPON_SHOTGUN][weapon_reload_time] = 2800;
    weapon_info[WEAPON_SHOTGUN][weapon_cooldown] = 400;
    weapon_info[WEAPON_SHOTGUN][weapon_allowed] = true;
    
    // Sniper Rifle
    weapon_info[WEAPON_SNIPER][weapon_id] = WEAPON_SNIPER;
    format(weapon_info[WEAPON_SNIPER][weapon_name], 32, "Sniper Rifle");
    weapon_info[WEAPON_SNIPER][weapon_damage] = 60;
    weapon_info[WEAPON_SNIPER][weapon_ammo] = 50;
    weapon_info[WEAPON_SNIPER][weapon_reload_time] = 3000;
    weapon_info[WEAPON_SNIPER][weapon_cooldown] = 800;
    weapon_info[WEAPON_SNIPER][weapon_allowed] = true;
    
    // Knife
    weapon_info[4][weapon_id] = 4;
    format(weapon_info[4][weapon_name], 32, "Knife");
    weapon_info[4][weapon_damage] = 40;
    weapon_info[4][weapon_ammo] = 0;
    weapon_info[4][weapon_reload_time] = 800;
    weapon_info[4][weapon_cooldown] = 500;
    weapon_info[4][weapon_allowed] = true;
    
    // Forbidden weapons
    weapon_info[35][weapon_allowed] = false; // RPG
    weapon_info[38][weapon_allowed] = false; // Minigun
    weapon_info[37][weapon_allowed] = false; // Flamethrower
}

GiveStarterWeapons(playerid) {
    GivePlayerWeapon(playerid, WEAPON_DEAGLE, STARTER_DEAGLE_AMMO);
    GivePlayerWeapon(playerid, 4, 1); // Knife
}

IsWeaponAllowed(weaponid) {
    if (weaponid < 0 || weaponid > 46) return 0;
    return weapon_info[weaponid][weapon_allowed];
}

GetWeaponName(weaponid, output[]) {
    if (weaponid < 0 || weaponid > 46) {
        format(output, 32, "Unknown");
        return 0;
    }
    format(output, 32, "%s", weapon_info[weaponid][weapon_name]);
    return 1;
}

GetWeaponDamage(weaponid) {
    if (weaponid < 0 || weaponid > 46) return 0;
    return weapon_info[weaponid][weapon_damage];
}
