-- VALZZ FFA INDONESIA - MySQL Database Schema
-- Production-Ready Database Structure

CREATE DATABASE IF NOT EXISTS `valzz_ffa`;
USE `valzz_ffa`;

-- Accounts Table
CREATE TABLE IF NOT EXISTS `accounts` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(32) UNIQUE NOT NULL,
    `password` VARCHAR(65) NOT NULL,
    `email` VARCHAR(128),
    `kills` INT(11) DEFAULT 0,
    `deaths` INT(11) DEFAULT 0,
    `level` INT(11) DEFAULT 1,
    `experience` INT(11) DEFAULT 0,
    `money` INT(11) DEFAULT 1000,
    `admin_level` INT(11) DEFAULT 0,
    `created_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `last_login` DATETIME,
    `playtime` INT(11) DEFAULT 0,
    `banned` TINYINT(1) DEFAULT 0,
    `ban_reason` VARCHAR(256),
    `status` VARCHAR(32) DEFAULT 'active',
    UNIQUE KEY `username_unique` (`username`),
    INDEX `admin_level` (`admin_level`),
    INDEX `level` (`level`),
    INDEX `kills` (`kills`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Sessions Table
CREATE TABLE IF NOT EXISTS `sessions` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `account_id` INT(11) NOT NULL,
    `token` VARCHAR(32) UNIQUE NOT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `expires_at` DATETIME,
    `active` TINYINT(1) DEFAULT 1,
    `ip_address` VARCHAR(45),
    FOREIGN KEY (`account_id`) REFERENCES `accounts`(`id`) ON DELETE CASCADE,
    INDEX `account_id` (`account_id`),
    INDEX `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Bans Table
CREATE TABLE IF NOT EXISTS `bans` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `player_id` INT(11) NOT NULL,
    `banned_by` VARCHAR(32),
    `reason` VARCHAR(256),
    `ban_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `unban_date` DATETIME,
    `active` TINYINT(1) DEFAULT 1,
    `ip_ban` VARCHAR(45),
    FOREIGN KEY (`player_id`) REFERENCES `accounts`(`id`) ON DELETE CASCADE,
    INDEX `player_id` (`player_id`),
    INDEX `active` (`active`),
    INDEX `ban_date` (`ban_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Vehicles Table
CREATE TABLE IF NOT EXISTS `vehicles` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `owner_id` INT(11) NOT NULL,
    `model` INT(11),
    `color1` INT(11),
    `color2` INT(11),
    `x` FLOAT(10,4),
    `y` FLOAT(10,4),
    `z` FLOAT(10,4),
    `angle` FLOAT(10,4),
    `fuel` FLOAT(5,2) DEFAULT 100.0,
    `health` FLOAT(5,2) DEFAULT 1000.0,
    `created_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`owner_id`) REFERENCES `accounts`(`id`) ON DELETE CASCADE,
    INDEX `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Matches Table
CREATE TABLE IF NOT EXISTS `matches` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `match_type` VARCHAR(32),
    `status` VARCHAR(32) DEFAULT 'pending',
    `team1_score` INT(11) DEFAULT 0,
    `team2_score` INT(11) DEFAULT 0,
    `start_time` DATETIME,
    `end_time` DATETIME,
    `duration` INT(11),
    `created_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX `status` (`status`),
    INDEX `start_time` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Match Players Table
CREATE TABLE IF NOT EXISTS `match_players` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `match_id` INT(11) NOT NULL,
    `player_id` INT(11) NOT NULL,
    `team` INT(11),
    `kills` INT(11) DEFAULT 0,
    `deaths` INT(11) DEFAULT 0,
    `damage_dealt` INT(11) DEFAULT 0,
    `reward` INT(11) DEFAULT 0,
    FOREIGN KEY (`match_id`) REFERENCES `matches`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`player_id`) REFERENCES `accounts`(`id`) ON DELETE CASCADE,
    INDEX `match_id` (`match_id`),
    INDEX `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Anti-Cheat Logs Table
CREATE TABLE IF NOT EXISTS `anticheat_logs` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `player_id` INT(11) NOT NULL,
    `player_name` VARCHAR(32),
    `cheat_type` VARCHAR(64),
    `score` INT(11),
    `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `action` VARCHAR(32),
    `evidence` TEXT,
    FOREIGN KEY (`player_id`) REFERENCES `accounts`(`id`) ON DELETE CASCADE,
    INDEX `player_id` (`player_id`),
    INDEX `timestamp` (`timestamp`),
    INDEX `cheat_type` (`cheat_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Events Table
CREATE TABLE IF NOT EXISTS `events` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `event_type` VARCHAR(32),
    `active` TINYINT(1) DEFAULT 0,
    `start_time` DATETIME,
    `end_time` DATETIME,
    `created_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX `event_type` (`event_type`),
    INDEX `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Event Players Table
CREATE TABLE IF NOT EXISTS `event_players` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `event_id` INT(11) NOT NULL,
    `player_id` INT(11) NOT NULL,
    `reward` INT(11),
    `participation_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`event_id`) REFERENCES `events`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`player_id`) REFERENCES `accounts`(`id`) ON DELETE CASCADE,
    INDEX `event_id` (`event_id`),
    INDEX `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Admin Logs Table
CREATE TABLE IF NOT EXISTS `admin_logs` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `admin_id` INT(11),
    `admin_name` VARCHAR(32),
    `target_id` INT(11),
    `target_name` VARCHAR(32),
    `action` VARCHAR(64),
    `reason` VARCHAR(256),
    `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX `admin_id` (`admin_id`),
    INDEX `target_id` (`target_id`),
    INDEX `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Server Logs Table
CREATE TABLE IF NOT EXISTS `server_logs` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `action` VARCHAR(64),
    `details` TEXT,
    `timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX `action` (`action`),
    INDEX `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Inventory Table
CREATE TABLE IF NOT EXISTS `inventory` (
    `id` INT(11) AUTO_INCREMENT PRIMARY KEY,
    `player_id` INT(11) NOT NULL,
    `item_id` INT(11),
    `item_name` VARCHAR(64),
    `quantity` INT(11) DEFAULT 1,
    `rarity` VARCHAR(32),
    `created_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`player_id`) REFERENCES `accounts`(`id`) ON DELETE CASCADE,
    INDEX `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Leaderboard View
CREATE OR REPLACE VIEW `leaderboard_kills` AS
SELECT `id`, `username`, `kills`, `deaths`, `level`, `created_date`
FROM `accounts`
WHERE `banned` = 0 AND `status` = 'active'
ORDER BY `kills` DESC
LIMIT 100;

-- Create Founder Account (Initial Setup)
INSERT IGNORE INTO `accounts` (`username`, `password`, `admin_level`, `money`, `status`)
VALUES ('valzz', '4E77CBF23EC970BBB88A7C81C2A29B27B95D1F5C5FE965EED83CEBF92A86E45E', 6, 999999999, 'active');

PRINT 'Database schema created successfully!';
