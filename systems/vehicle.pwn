// VALZZ FFA INDONESIA - Vehicle System
// Garage, Insurance, Customization

new player_vehicle[MAX_PLAYERS];
new vehicle_owner[1000];
new vehicle_fuel[1000];
new vehicle_health[1000];

enum VehicleData {
    veh_id,
    veh_owner,
    veh_model,
    veh_color1,
    veh_color2,
    Float:veh_x,
    Float:veh_y,
    Float:veh_z,
    Float:veh_angle,
    veh_fuel,
    veh_health,
    veh_saved,
};

new vehicle_data[1000][VehicleData];

GetPlayerVehicle(playerid) {
    return player_vehicle[playerid];
}

SpawnPlayerVehicle(playerid, model, Float:x, Float:y, Float:z, Float:angle) {
    if (PlayerInfo[playerid][money] < 5000) {
        SendClientMessage(playerid, COLOR_ERROR, "[ERROR] You need $5000 to spawn a vehicle!");
        return 0;
    }
    
    new veh_id = CreateVehicle(model, x, y, z, angle, -1, -1, -1);
    if (veh_id == INVALID_VEHICLE_ID) return 0;
    
    player_vehicle[playerid] = veh_id;
    vehicle_owner[veh_id] = playerid;
    vehicle_fuel[veh_id] = 100;
    vehicle_health[veh_id] = 1000;
    
    // Deduct spawn cost
    GivePlayerMoney(playerid, -5000);
    PlayerInfo[playerid][money] -= 5000;
    
    SendClientMessage(playerid, COLOR_SUCCESS, "[VEHICLE] Vehicle spawned! Fuel: 100");
    
    return veh_id;
}

SavePlayerVehicle(playerid) {
    new veh_id = player_vehicle[playerid];
    if (veh_id == INVALID_VEHICLE_ID) return 0;
    
    new Float:x, Float:y, Float:z, Float:angle;
    GetVehiclePos(veh_id, x, y, z);
    GetVehicleZAngle(veh_id, angle);
    GetVehicleHealth(veh_id, vehicle_health[veh_id]);
    
    new query[512];
    new model, color1, color2;
    GetVehicleModel(veh_id);
    GetVehicleColor(veh_id, color1, color2);
    
    mysql_format(mysql_handle, query, sizeof(query),
        "UPDATE vehicles SET x = %f, y = %f, z = %f, angle = %f, fuel = %d, health = %d WHERE id = %d",
        x, y, z, angle, vehicle_fuel[veh_id], vehicle_health[veh_id], veh_id);
    
    mysql_query(mysql_handle, query);
    
    return 1;
}

GetVehicleModel(vehicleid) {
    new model;
    for (new i = 0; i < 1000; i++) {
        if (vehicle_data[i][veh_id] == vehicleid) {
            model = vehicle_data[i][veh_model];
            break;
        }
    }
    return model;
}

GetVehicleColor(vehicleid, &color1, &color2) {
    for (new i = 0; i < 1000; i++) {
        if (vehicle_data[i][veh_id] == vehicleid) {
            color1 = vehicle_data[i][veh_color1];
            color2 = vehicle_data[i][veh_color2];
            break;
        }
    }
}

RefreshVehicleFuel() {
    for (new i = 1; i < 1000; i++) {
        if (vehicle_fuel[i] > 0) {
            vehicle_fuel[i]--; // Decrease fuel over time
        }
    }
}

GetVehicleFuel(vehicleid) {
    return vehicle_fuel[vehicleid];
}

SetVehicleFuel(vehicleid, amount) {
    if (amount < 0) amount = 0;
    if (amount > 100) amount = 100;
    vehicle_fuel[vehicleid] = amount;
}
