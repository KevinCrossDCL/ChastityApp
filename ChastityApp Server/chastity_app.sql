-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 15, 2020 at 05:27 PM
-- Server version: 10.1.48-MariaDB
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chastity_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `APIProjects`
--

CREATE TABLE `APIProjects` (
  `id` bigint(20) NOT NULL,
  `user_id` varchar(25) NOT NULL,
  `name` varchar(30) NOT NULL,
  `client_id` varchar(60) NOT NULL,
  `client_secret` varchar(60) NOT NULL,
  `banned` tinyint(4) NOT NULL,
  `bot` tinyint(1) NOT NULL,
  `deleted` tinyint(4) NOT NULL,
  `desktop_app` tinyint(1) NOT NULL,
  `dont_know` tinyint(1) NOT NULL,
  `lockbox` tinyint(1) NOT NULL,
  `mobile_app` tinyint(1) NOT NULL,
  `something_else` tinyint(1) NOT NULL,
  `timestamp_deleted` int(11) NOT NULL,
  `timestamp_last_called` int(11) NOT NULL,
  `tokens` smallint(4) NOT NULL,
  `tokens_per_minute` smallint(4) NOT NULL DEFAULT '60',
  `total_requests_made` int(11) NOT NULL,
  `website` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `DiscordQRRegister`
--

CREATE TABLE `DiscordQRRegister` (
  `id` bigint(20) NOT NULL,
  `auth_code` varchar(13) NOT NULL,
  `created` datetime NOT NULL,
  `discord_discriminator` int(4) DEFAULT NULL,
  `discord_id` varchar(64) NOT NULL,
  `discord_username` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `GeneratedLocks`
--

CREATE TABLE `GeneratedLocks` (
  `id` bigint(20) NOT NULL,
  `build` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `level` smallint(2) NOT NULL,
  `max_random_double_ups` int(11) NOT NULL,
  `max_random_freezes` int(11) NOT NULL,
  `max_random_greens` int(11) NOT NULL,
  `max_random_reds` int(11) NOT NULL,
  `max_random_resets` int(11) NOT NULL,
  `max_random_stickies` smallint(3) NOT NULL,
  `max_random_yellows` int(11) NOT NULL,
  `max_random_yellows_add` int(11) NOT NULL,
  `max_random_yellows_minus` int(11) NOT NULL,
  `min_random_double_ups` int(11) NOT NULL,
  `min_random_freezes` int(11) NOT NULL,
  `min_random_greens` int(11) NOT NULL,
  `min_random_reds` int(11) NOT NULL,
  `min_random_resets` int(11) NOT NULL,
  `min_random_stickies` smallint(3) NOT NULL,
  `min_random_yellows` int(11) NOT NULL,
  `min_random_yellows_add` int(11) NOT NULL,
  `min_random_yellows_minus` int(11) NOT NULL,
  `minimum_version_required` varchar(25) NOT NULL,
  `multiple_greens_required` tinyint(1) NOT NULL,
  `regularity` float NOT NULL,
  `simulation_average_minutes_locked` int(11) NOT NULL,
  `simulation_best_case_minutes_locked` int(11) NOT NULL,
  `simulation_worst_case_minutes_locked` int(11) NOT NULL,
  `version` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Locks_Log`
--

CREATE TABLE `Locks_Log` (
  `id` bigint(20) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `lock_id` bigint(20) NOT NULL,
  `user_id` varchar(25) NOT NULL,
  `action` varchar(100) NOT NULL,
  `actioned_by` varchar(20) NOT NULL,
  `result` varchar(100) NOT NULL,
  `total_action_time` int(11) NOT NULL,
  `hidden` tinyint(1) NOT NULL,
  `private` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Locks_V2`
--

CREATE TABLE `Locks_V2` (
  `id` bigint(20) NOT NULL,
  `user_id` varchar(25) NOT NULL,
  `lock_id` int(11) NOT NULL,
  `lock_group_id` int(11) NOT NULL,
  `shared_id` varchar(20) NOT NULL,
  `name` varchar(30) NOT NULL,
  `auto_resets_paused` tinyint(1) NOT NULL,
  `block_users_already_locked` tinyint(1) NOT NULL,
  `bot_can_hide_info` tinyint(1) NOT NULL,
  `bot_chosen` tinyint(2) NOT NULL,
  `build` smallint(5) NOT NULL,
  `card_info_hidden` tinyint(1) NOT NULL,
  `chances_accumulated_before_freeze` smallint(5) NOT NULL,
  `check_in_frequency_in_seconds` int(11) NOT NULL,
  `combination` varchar(20) NOT NULL,
  `cumulative` tinyint(1) NOT NULL,
  `daily` tinyint(1) NOT NULL,
  `date_deleted` varchar(10) NOT NULL,
  `date_last_picked` varchar(10) NOT NULL,
  `date_locked` varchar(10) NOT NULL,
  `date_unlocked` varchar(10) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `discard_pile` text NOT NULL,
  `display_in_stats` tinyint(1) NOT NULL DEFAULT '1',
  `double_up_cards` smallint(3) NOT NULL,
  `double_up_cards_added` int(6) NOT NULL,
  `double_up_cards_picked` int(6) NOT NULL,
  `fake` tinyint(1) NOT NULL,
  `fake_card_count_percentage` decimal(5,2) NOT NULL,
  `fixed` tinyint(1) NOT NULL,
  `flag_chosen` smallint(2) NOT NULL,
  `freeze_cards` smallint(3) NOT NULL,
  `freeze_cards_added` int(6) NOT NULL,
  `go_again_cards` int(6) NOT NULL,
  `go_again_cards_percentage` float NOT NULL,
  `green_cards` smallint(3) NOT NULL,
  `greens_picked_since_reset` smallint(5) NOT NULL,
  `hide_greens_until_picked_count` int(11) NOT NULL,
  `initial_double_up_cards` smallint(3) NOT NULL,
  `initial_freeze_cards` smallint(3) NOT NULL,
  `initial_green_cards` smallint(3) NOT NULL,
  `initial_minutes` int(11) NOT NULL,
  `initial_red_cards` int(11) NOT NULL,
  `initial_reset_cards` smallint(3) NOT NULL,
  `initial_sticky_cards` smallint(3) NOT NULL,
  `initial_yellow_add_1_cards` smallint(5) NOT NULL,
  `initial_yellow_add_2_cards` smallint(5) NOT NULL,
  `initial_yellow_add_3_cards` smallint(5) NOT NULL,
  `initial_yellow_cards` smallint(5) NOT NULL,
  `initial_yellow_minus_1_cards` smallint(5) NOT NULL,
  `initial_yellow_minus_2_cards` smallint(5) NOT NULL,
  `key_disabled` tinyint(1) NOT NULL,
  `key_used` tinyint(1) NOT NULL,
  `keyholder_decision_disabled` tinyint(1) NOT NULL,
  `keyholder_disabled_key` tinyint(1) NOT NULL,
  `keyholder_emoji` smallint(3) NOT NULL,
  `keyholder_emoji_colour` smallint(2) NOT NULL,
  `keyholder_id` bigint(20) NOT NULL,
  `last_update_id_seen` bigint(20) NOT NULL,
  `late_check_in_window_in_seconds` int(11) NOT NULL,
  `lock_frozen_by_card` tinyint(1) NOT NULL,
  `lock_frozen_by_keyholder` tinyint(1) NOT NULL,
  `maximum_auto_resets` smallint(3) NOT NULL,
  `maximum_minutes` int(11) NOT NULL,
  `maximum_red_cards` int(11) NOT NULL,
  `minimum_minutes` int(11) NOT NULL,
  `minimum_red_cards` int(11) NOT NULL,
  `minutes` int(11) NOT NULL,
  `minutes_added` int(11) NOT NULL,
  `multiple_greens_required` tinyint(1) NOT NULL,
  `no_of_add_1_cards` smallint(5) NOT NULL,
  `no_of_add_2_cards` smallint(5) NOT NULL,
  `no_of_add_3_cards` smallint(5) NOT NULL,
  `no_of_keys_required` smallint(3) NOT NULL DEFAULT '1',
  `no_of_minus_1_cards` smallint(5) NOT NULL,
  `no_of_minus_2_cards` smallint(5) NOT NULL,
  `no_of_times_auto_reset` smallint(5) NOT NULL,
  `no_of_times_card_reset` smallint(5) NOT NULL,
  `no_of_times_full_reset` smallint(5) NOT NULL,
  `no_of_times_green_card_revealed` smallint(5) NOT NULL,
  `no_of_times_reset` smallint(5) NOT NULL,
  `permanent` tinyint(1) NOT NULL,
  `picked_count` int(11) NOT NULL,
  `picked_count_including_yellows` int(11) NOT NULL,
  `picked_count_since_reset` int(11) NOT NULL,
  `platform` varchar(25) NOT NULL,
  `random_cards_added` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `rating_from_keyholder` int(11) NOT NULL,
  `ready_to_unlock` tinyint(1) NOT NULL,
  `red_cards` int(11) NOT NULL,
  `red_cards_added` int(11) NOT NULL,
  `regularity` float NOT NULL,
  `removed_by_keyholder` tinyint(1) NOT NULL,
  `reset_cards` smallint(3) NOT NULL,
  `reset_cards_added` int(6) NOT NULL,
  `reset_cards_picked` int(6) NOT NULL,
  `reset_frequency_in_seconds` int(11) NOT NULL,
  `safe_id` varchar(255) NOT NULL,
  `show_fake_card_count` tinyint(1) NOT NULL,
  `simulation_average_minutes_locked` int(11) NOT NULL,
  `simulation_best_case_minutes_locked` int(11) NOT NULL,
  `simulation_worst_case_minutes_locked` int(11) NOT NULL,
  `sticky_cards` smallint(3) NOT NULL,
  `test` tinyint(1) NOT NULL,
  `time_left_until_next_chance_before_freeze` int(11) NOT NULL,
  `timer_hidden` tinyint(1) NOT NULL,
  `timestamp_clean_time_request_blocked_until` int(11) NOT NULL,
  `timestamp_deleted` int(11) NOT NULL,
  `timestamp_denied_clean_time` int(11) NOT NULL,
  `timestamp_ended_clean_time` int(11) NOT NULL,
  `timestamp_frozen_by_card` int(11) NOT NULL,
  `timestamp_frozen_by_keyholder` int(11) NOT NULL,
  `timestamp_keyholder_rated` int(11) NOT NULL,
  `timestamp_last_auto_reset` int(11) NOT NULL,
  `timestamp_last_card_reset` int(11) NOT NULL,
  `timestamp_last_checked_in` int(11) NOT NULL,
  `timestamp_last_full_reset` int(11) NOT NULL,
  `timestamp_last_picked` int(11) NOT NULL,
  `timestamp_last_reset` int(11) NOT NULL,
  `timestamp_last_synced` int(11) NOT NULL,
  `timestamp_last_updated` int(11) NOT NULL,
  `timestamp_locked` int(11) NOT NULL,
  `timestamp_rated` int(11) NOT NULL,
  `timestamp_real_last_picked` int(11) NOT NULL,
  `timestamp_removed_by_keyholder` int(11) NOT NULL,
  `timestamp_requested_clean_time` int(11) NOT NULL,
  `timestamp_requested_keyholders_decision` int(11) NOT NULL,
  `timestamp_started_clean_time` int(11) NOT NULL,
  `timestamp_unfreezes` int(11) NOT NULL,
  `timestamp_unfrozen` int(11) NOT NULL,
  `timestamp_unlocked` int(11) NOT NULL,
  `total_time_cleaning` int(11) NOT NULL,
  `total_time_frozen` int(11) NOT NULL,
  `trust_keyholder` int(11) NOT NULL,
  `unlocked` tinyint(1) NOT NULL,
  `user_emoji` int(11) NOT NULL,
  `user_emoji_colour` int(11) NOT NULL,
  `version` varchar(25) NOT NULL,
  `yellow_cards` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ModifiedLocks_V2`
--

CREATE TABLE `ModifiedLocks_V2` (
  `id` bigint(20) NOT NULL,
  `user_id` varchar(25) NOT NULL,
  `lock_id` bigint(20) NOT NULL,
  `shared_id` varchar(25) NOT NULL,
  `auto_resets_paused_modified_by` tinyint(2) NOT NULL,
  `card_info_hidden_modified_by` tinyint(2) NOT NULL,
  `cumulative_modified_by` tinyint(2) NOT NULL,
  `double_up_cards_modified_by` int(11) NOT NULL,
  `freeze_cards_modified_by` int(11) NOT NULL,
  `green_cards_modified_by` int(11) NOT NULL,
  `hidden` tinyint(2) NOT NULL,
  `lock_frozen_modified_by` tinyint(2) NOT NULL,
  `minutes_modified_by` int(11) NOT NULL,
  `no_of_add_1_cards` int(11) NOT NULL,
  `no_of_add_2_cards` int(11) NOT NULL,
  `no_of_add_3_cards` int(11) NOT NULL,
  `no_of_minus_1_cards` int(11) NOT NULL,
  `no_of_minus_2_cards` int(11) NOT NULL,
  `ready_to_unlock` tinyint(2) NOT NULL,
  `red_cards_modified_by` int(11) NOT NULL,
  `reset` tinyint(2) NOT NULL,
  `reset_cards_modified_by` int(11) NOT NULL,
  `sticky_cards_modified_by` smallint(3) NOT NULL,
  `timer_hidden_modified_by` tinyint(2) NOT NULL,
  `timestamp_modified` int(11) NOT NULL,
  `unlocked` tinyint(2) NOT NULL,
  `user_notified` tinyint(2) NOT NULL,
  `yellow_cards_modified_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Records_Deleted`
--

CREATE TABLE `Records_Deleted` (
  `id` bigint(20) NOT NULL,
  `locks_deleted` int(11) NOT NULL,
  `locks_log_deleted` int(11) NOT NULL,
  `modified_locks_deleted` int(11) NOT NULL,
  `shareable_locks_deleted` int(11) NOT NULL,
  `test_locks_deleted` int(11) NOT NULL,
  `user_ids_deleted` int(11) NOT NULL,
  `date_deleted` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Relations`
--

CREATE TABLE `Relations` (
  `id` bigint(20) NOT NULL,
  `user_one_id` bigint(20) NOT NULL,
  `user_two_id` bigint(20) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ReservedUsernames_V2`
--

CREATE TABLE `ReservedUsernames_V2` (
  `id` bigint(20) NOT NULL,
  `username` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ServerVariables`
--

CREATE TABLE `ServerVariables` (
  `id` bigint(20) NOT NULL,
  `variable` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ShareableLocks_V2`
--

CREATE TABLE `ShareableLocks_V2` (
  `id` bigint(20) NOT NULL,
  `user_id` varchar(25) NOT NULL,
  `share_id` varchar(25) NOT NULL,
  `name` varchar(30) NOT NULL,
  `allow_copies` tinyint(1) NOT NULL,
  `block_users_already_locked` tinyint(1) NOT NULL,
  `block_users_with_stats_hidden` tinyint(1) NOT NULL,
  `build` int(11) NOT NULL,
  `card_info_hidden` tinyint(1) NOT NULL,
  `check_in_frequency_in_seconds` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `cumulative` tinyint(1) NOT NULL,
  `daily` tinyint(1) NOT NULL,
  `double_up_cards` int(11) NOT NULL,
  `fixed` tinyint(1) NOT NULL,
  `force_trust` tinyint(1) NOT NULL,
  `freeze_cards` int(11) NOT NULL,
  `green_cards` int(11) NOT NULL,
  `hide_from_owner` tinyint(1) NOT NULL,
  `key_disabled` tinyint(1) NOT NULL,
  `keyholder_decision_disabled` tinyint(1) NOT NULL,
  `late_check_in_window_in_seconds` int(11) NOT NULL,
  `max_auto_resets` smallint(3) NOT NULL,
  `max_random_copies` int(11) NOT NULL,
  `max_random_double_ups` int(11) NOT NULL,
  `max_random_freezes` int(11) NOT NULL,
  `max_random_greens` int(11) NOT NULL,
  `max_random_minutes` int(11) NOT NULL,
  `max_random_reds` int(11) NOT NULL,
  `max_random_resets` int(11) NOT NULL,
  `max_random_stickies` smallint(3) NOT NULL,
  `max_random_yellows` int(11) NOT NULL,
  `max_random_yellows_add` int(11) NOT NULL,
  `max_random_yellows_minus` int(11) NOT NULL,
  `maximum_copies` int(11) NOT NULL,
  `maximum_users` int(11) NOT NULL,
  `min_random_copies` int(11) NOT NULL,
  `min_random_double_ups` int(11) NOT NULL,
  `min_random_freezes` int(11) NOT NULL,
  `min_random_greens` int(11) NOT NULL,
  `min_random_minutes` int(11) NOT NULL,
  `min_random_reds` int(11) NOT NULL,
  `min_random_resets` int(11) NOT NULL,
  `min_random_stickies` smallint(3) NOT NULL,
  `min_random_yellows` int(11) NOT NULL,
  `min_random_yellows_add` int(11) NOT NULL,
  `min_random_yellows_minus` int(11) NOT NULL,
  `min_rating_required` tinyint(1) NOT NULL,
  `minimum_version_required` varchar(25) NOT NULL,
  `multiple_greens_required` tinyint(1) NOT NULL,
  `random_double_ups` tinyint(1) NOT NULL,
  `random_freezes` tinyint(1) NOT NULL,
  `random_greens` tinyint(1) NOT NULL,
  `random_reds` tinyint(1) NOT NULL,
  `random_resets` tinyint(1) NOT NULL,
  `random_yellows` tinyint(1) NOT NULL,
  `random_yellows_add` tinyint(1) NOT NULL,
  `random_yellows_minus` tinyint(1) NOT NULL,
  `red_cards` int(11) NOT NULL,
  `regularity` float NOT NULL,
  `require_dm` tinyint(1) NOT NULL,
  `reset_cards` int(11) NOT NULL,
  `reset_frequency_in_seconds` int(11) NOT NULL,
  `share_in_api` tinyint(1) NOT NULL,
  `simulation_average_minutes_locked` int(11) NOT NULL,
  `simulation_best_case_minutes_locked` int(11) NOT NULL,
  `simulation_worst_case_minutes_locked` int(11) NOT NULL,
  `start_lock_frozen` tinyint(1) NOT NULL,
  `temporarily_disabled` tinyint(1) NOT NULL,
  `timer_hidden` tinyint(1) NOT NULL,
  `timestamp_hidden` int(11) NOT NULL,
  `version` varchar(25) NOT NULL,
  `yellow_cards` int(11) NOT NULL,
  `yellow_cards_add` int(11) NOT NULL,
  `yellow_cards_minus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `UserIDs_V2`
--

CREATE TABLE `UserIDs_V2` (
  `id` bigint(20) NOT NULL,
  `user_id` varchar(25) NOT NULL,
  `username` varchar(25) NOT NULL,
  `admin_notes` varchar(500) NOT NULL,
  `api_token` varchar(255) NOT NULL,
  `avatar_id` bigint(20) NOT NULL,
  `banned` tinyint(1) NOT NULL,
  `build_number_installed` smallint(5) NOT NULL,
  `created` datetime NOT NULL,
  `date_deleted` datetime NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `device_id` varchar(100) NOT NULL,
  `discord_discriminator` int(4) DEFAULT NULL,
  `discord_id` varchar(64) CHARACTER SET utf8 DEFAULT NULL,
  `discord_username` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `display_in_stats` tinyint(1) NOT NULL DEFAULT '1',
  `free_ads_removal_available` tinyint(1) NOT NULL,
  `free_keys_available` smallint(4) NOT NULL,
  `include_in_api` tinyint(1) NOT NULL,
  `keyholder_level` smallint(3) NOT NULL,
  `last_active` datetime NOT NULL,
  `lockee_level` smallint(3) NOT NULL,
  `main_role` smallint(3) NOT NULL,
  `no_of_keys` smallint(4) NOT NULL,
  `no_of_keys_purchased` smallint(4) NOT NULL,
  `no_of_times_review_box_shown` smallint(4) NOT NULL,
  `platform` varchar(25) NOT NULL,
  `private_profile` tinyint(1) NOT NULL,
  `pro_account` tinyint(1) NOT NULL,
  `push_notifications_disabled` tinyint(1) NOT NULL,
  `reason_banned` varchar(500) NOT NULL,
  `removed_ads` tinyint(1) NOT NULL,
  `requests` int(11) NOT NULL,
  `show_combinations_to_keyholders` tinyint(1) NOT NULL,
  `status` smallint(3) NOT NULL DEFAULT '1',
  `timestamp_deleted` int(11) NOT NULL,
  `timestamp_last_active` int(11) NOT NULL,
  `token` text NOT NULL,
  `twitter_handle` varchar(32) DEFAULT NULL,
  `version_installed` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Server time is 8 hours behind GMT. I''m the first 3 user ids.';

-- --------------------------------------------------------

--
-- Table structure for table `Usernames_Cleared`
--

CREATE TABLE `Usernames_Cleared` (
  `id` bigint(20) NOT NULL,
  `usernames_cleared` int(11) NOT NULL,
  `date_cleared` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `APIProjects`
--
ALTER TABLE `APIProjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `client_id` (`client_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `DiscordQRRegister`
--
ALTER TABLE `DiscordQRRegister`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_code_UNIQUE` (`auth_code`),
  ADD UNIQUE KEY `discord_id_UNIQUE` (`discord_id`),
  ADD UNIQUE KEY `discord_tag_UNIQUE` (`discord_username`,`discord_discriminator`),
  ADD KEY `auth_code` (`auth_code`),
  ADD KEY `created` (`created`);

--
-- Indexes for table `GeneratedLocks`
--
ALTER TABLE `GeneratedLocks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `Locks_Log`
--
ALTER TABLE `Locks_Log`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `lock_id` (`lock_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `Locks_V2`
--
ALTER TABLE `Locks_V2`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`,`lock_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `shared_id` (`shared_id`),
  ADD KEY `lock_id` (`lock_id`),
  ADD KEY `lock_group_id` (`lock_group_id`),
  ADD KEY `bot_chosen` (`bot_chosen`);

--
-- Indexes for table `ModifiedLocks_V2`
--
ALTER TABLE `ModifiedLocks_V2`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `shared_id` (`shared_id`),
  ADD KEY `lock_id` (`lock_id`);

--
-- Indexes for table `Records_Deleted`
--
ALTER TABLE `Records_Deleted`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Relations`
--
ALTER TABLE `Relations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `user_id` (`user_one_id`),
  ADD KEY `friend_id` (`user_two_id`);

--
-- Indexes for table `ReservedUsernames_V2`
--
ALTER TABLE `ReservedUsernames_V2`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `ServerVariables`
--
ALTER TABLE `ServerVariables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `variable` (`variable`);

--
-- Indexes for table `ShareableLocks_V2`
--
ALTER TABLE `ShareableLocks_V2`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`,`share_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `share_id` (`share_id`);

--
-- Indexes for table `UserIDs_V2`
--
ALTER TABLE `UserIDs_V2`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `discord_id_UNIQUE` (`discord_id`),
  ADD UNIQUE KEY `discord_tag_UNIQUE` (`discord_username`,`discord_discriminator`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `Usernames_Cleared`
--
ALTER TABLE `Usernames_Cleared`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `APIProjects`
--
ALTER TABLE `APIProjects`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `DiscordQRRegister`
--
ALTER TABLE `DiscordQRRegister`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `GeneratedLocks`
--
ALTER TABLE `GeneratedLocks`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Locks_Log`
--
ALTER TABLE `Locks_Log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Locks_V2`
--
ALTER TABLE `Locks_V2`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ModifiedLocks_V2`
--
ALTER TABLE `ModifiedLocks_V2`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Records_Deleted`
--
ALTER TABLE `Records_Deleted`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Relations`
--
ALTER TABLE `Relations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ReservedUsernames_V2`
--
ALTER TABLE `ReservedUsernames_V2`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ServerVariables`
--
ALTER TABLE `ServerVariables`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ShareableLocks_V2`
--
ALTER TABLE `ShareableLocks_V2`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `UserIDs_V2`
--
ALTER TABLE `UserIDs_V2`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Usernames_Cleared`
--
ALTER TABLE `Usernames_Cleared`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;
COMMIT;

--
-- Add 4 bots to table `UserIDs_V2`
--
INSERT INTO `UserIDs_V2` (`id`, `user_id`, `username`, `build_number_installed`, `keyholder_level`, `main_role`) VALUES
('', 'BOT01', 'Hailey', 99, 5, 1),
('', 'BOT02', 'Blaine', 99, 5, 1),
('', 'BOT03', 'Zoe', '', 99, 5, 1),
('', 'BOT04', 'Chase', '', 99, 5, 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
