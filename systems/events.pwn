// VALZZ FFA INDONESIA - Event System
// Global Server Events

enum EventData {
    event_id,
    event_type,
    event_active,
    event_start_time,
    event_target,
    event_reward,
};

new event_data[3][EventData];
new active_event = -1;

#define EVENT_TYPE_BOUNTY 0
#define EVENT_TYPE_SUPPLY_DROP 1
#define EVENT_TYPE_BOSS_RAID 2

StartRandomEvent() {
    new random_event = random(3);
    
    switch(random_event) {
        case EVENT_TYPE_BOUNTY: StartBountyEvent();
        case EVENT_TYPE_SUPPLY_DROP: StartSupplyDropEvent();
        case EVENT_TYPE_BOSS_RAID: StartBossRaidEvent();
    }
}

StartBountyEvent() {
    new random_target = random(MAX_PLAYERS);
    while (!IsPlayerConnected(random_target)) {
        random_target = random(MAX_PLAYERS);
    }
    
    event_data[EVENT_TYPE_BOUNTY][event_id] = EVENT_TYPE_BOUNTY;
    event_data[EVENT_TYPE_BOUNTY][event_type] = EVENT_TYPE_BOUNTY;
    event_data[EVENT_TYPE_BOUNTY][event_active] = 1;
    event_data[EVENT_TYPE_BOUNTY][event_start_time] = GetTickCount();
    event_data[EVENT_TYPE_BOUNTY][event_target] = random_target;
    event_data[EVENT_TYPE_BOUNTY][event_reward] = 50000;
    
    active_event = EVENT_TYPE_BOUNTY;
    
    new msg[256];
    new target_name[32];
    GetPlayerName(random_target, target_name, 32);
    
    format(msg, sizeof(msg), "~r~[EVENT] BOUNTY HUNTER!~n~~w~Target: %s~n~~g~Reward: $50,000", target_name);
    SendClientMessageToAll(COLOR_WARNING, msg);
    
    return 1;
}

StartSupplyDropEvent() {
    event_data[EVENT_TYPE_SUPPLY_DROP][event_id] = EVENT_TYPE_SUPPLY_DROP;
    event_data[EVENT_TYPE_SUPPLY_DROP][event_type] = EVENT_TYPE_SUPPLY_DROP;
    event_data[EVENT_TYPE_SUPPLY_DROP][event_active] = 1;
    event_data[EVENT_TYPE_SUPPLY_DROP][event_start_time] = GetTickCount();
    event_data[EVENT_TYPE_SUPPLY_DROP][event_reward] = 25000;
    
    active_event = EVENT_TYPE_SUPPLY_DROP;
    
    SendClientMessageToAll(COLOR_INFO, "~g~[EVENT] SUPPLY DROP!~n~~w~An airplane is dropping loot crates!~n~~y~Check the sky!");
    
    // Spawn supply crate object
    new Float:x = 1500.0 + random(500);
    new Float:y = 1500.0 + random(500);
    new Float:z = 1000.0;
    
    CreateDynamicObject(1559, x, y, z, 0.0, 0.0, 0.0, 0);
    
    return 1;
}

StartBossRaidEvent() {
    event_data[EVENT_TYPE_BOSS_RAID][event_id] = EVENT_TYPE_BOSS_RAID;
    event_data[EVENT_TYPE_BOSS_RAID][event_type] = EVENT_TYPE_BOSS_RAID;
    event_data[EVENT_TYPE_BOSS_RAID][event_active] = 1;
    event_data[EVENT_TYPE_BOSS_RAID][event_start_time] = GetTickCount();
    event_data[EVENT_TYPE_BOSS_RAID][event_reward] = 100000;
    
    active_event = EVENT_TYPE_BOSS_RAID;
    
    SendClientMessageToAll(COLOR_WARNING, "~r~[EVENT] BOSS RAID!~n~~w~Defeat the final boss!~n~~y~Reward: $100,000!");
    
    // Spawn NPC boss
    // This would use NPC filterscript in production
    
    return 1;
}

EndEvent(event_type) {
    if (active_event != event_type) return 0;
    
    event_data[event_type][event_active] = 0;
    active_event = -1;
    
    SendClientMessageToAll(COLOR_INFO, "[EVENT] Event has ended!");
    
    return 1;
}

GetActiveEvent() {
    return active_event;
}

IsEventActive() {
    return (active_event != -1);
}
