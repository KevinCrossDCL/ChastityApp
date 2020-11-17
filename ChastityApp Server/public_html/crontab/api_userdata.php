<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

ini_set("memory_limit","256M");

try {
    include_once("../../includes/app.php");
    
    $array = array();
    
    $query = $pdo->prepare("select
        u.id as u_id,
        u.user_id as u_user_id,
        if (u.username = '', concat('CKU', u.id), u.username) as u_username,
        u.discord_id as u_discord_id,
        u.display_in_stats as u_display_in_stats,
        u.build_number_installed as u_build_number_installed,
        u.created as u_created,
        u.keyholder_level as u_keyholder_level,
        u.lockee_level as u_lockee_level,
        u.main_role as u_main_role,
        u.status as u_status,
        u.timestamp_last_active as u_timestamp_last_active,
        u.twitter_handle as u_twitter_handle,
        u.version_installed as u_version_installed
    from UserIDs_V2 as u
    where ".time()." - u.timestamp_last_active < 1209600 and 
        u.display_in_stats = 1 
    order by u_username asc");
    $query->execute();
    if ($query->rowCount() > 0) {
        header("HTTP/1.1 200 OK", true, 200);
        $array["response"] = array('status' => 200, 'message' => 'the request has succeeded', 'timestampGenerated' => time());
        $array["users"] = array();
        foreach ($query as $row) {
            $userNo = $row["u_id"];
            if ($row["u_discord_id"] == NULL) { $row["u_discord_id"] = ""; }
            
            $mainRole = "Unknown";
            if ($row["u_main_role"] == 1) { $mainRole = "Keyholder"; }
            if ($row["u_main_role"] == 2) { $mainRole = "Lockee"; }
            
            if ($row["u_status"] == 0 || $row["u_status"] == 1) {
                if (time() - $row["timestamp_last_active"] <= 900) {
                    $status = "Available";
                } else {
                    $status = "Offline";
                }
            }
            if ($row["u_status"] == 2) { $status = "Busy"; }
            if ($row["u_status"] == 3) { $status = "Sleeping"; }
            
            $noOfSharedLocks = 0;
            $noOfSharedLocksFixed = 0;
            $noOfSharedLocksVariable = 0;
            $query2 = $pdo->prepare("select
                coalesce(count(*), 0) as noOfSharedLocks,
                sum(case when s.fixed = 1 then 1 else 0 end) as noOfSharedLocksFixed,
                sum(case when s.fixed = 0 then 1 else 0 end) as noOfSharedLocksVariable
            from ShareableLocks_V2 as s
            where s.user_id = :userID and 
                s.hide_from_owner = 0");
            $query2->execute(array('userID' => $row["u_user_id"]));
            if ($query2->rowCount() == 1) {
                foreach ($query2 as $row2) {
                    $noOfSharedLocks = $row2["noOfSharedLocks"];
                    $noOfSharedLocksFixed = $row2["noOfSharedLocksFixed"];
                    $noOfSharedLocksVariable = $row2["noOfSharedLocksVariable"];
                }
            }
            
            $noOfLocksFlaggedAsTrusted = 0;
            $noOfLocksManagingNow = 0;
            $noOfLocksManagingNowFixed = 0;
            $noOfLocksManagingNowVariable = 0;
            $query2 = $pdo->prepare("select
                coalesce(sum(l.trust_keyholder), 0) as noOfLocksFlaggedAsTrusted,
                coalesce(count(*), 0) as noOfLocksManagingNow,
                sum(case when l.fixed = 1 then 1 else 0 end) as noOfLocksManagingNowFixed,
                sum(case when l.fixed = 0 then 1 else 0 end) as noOfLocksManagingNowVariable
            from ShareableLocks_V2 as s, Locks_V2 as l
            where s.user_id = :userID and 
                l.shared_id = s.share_id and 
                s.hide_from_owner = 0 and 
                l.deleted = 0 and 
                l.fake = 0 and 
                l.test = 0 and 
                l.timestamp_locked > 1451606400 and 
                l.unlocked = 0");
            $query2->execute(array('userID' => $row["u_user_id"]));
            if ($query2->rowCount() == 1) {
                foreach ($query2 as $row2) {
                    $noOfLocksFlaggedAsTrusted = $row2["noOfLocksFlaggedAsTrusted"];
                    $noOfLocksManagingNow = $row2["noOfLocksManagingNow"];
                    $noOfLocksManagingNowFixed = $row2["noOfLocksManagingNowFixed"];
                    $noOfLocksManagingNowVariable = $row2["noOfLocksManagingNowVariable"];
                }
            }
    
            $dateFirstKeyheld = "";
            $timestampFirstKeyheld = 0;
            $totalLocksManaged = 0;
            $query2 = $pdo->prepare("select
                min(l.timestamp_locked) as timestampFirstKeyheld,
                coalesce(count(*), 0) as totalLocksManaged
            from ShareableLocks_V2 as s, Locks_V2 as l
            where s.user_id = :userID and 
                l.shared_id = s.share_id and 
                l.fake = 0 and 
                l.test = 0 and 
                l.timestamp_locked > 1451606400
            order by l.timestamp_locked asc");
            $query2->execute(array('userID' => $row["u_user_id"]));
            if ($query2->rowCount() == 1) {
                foreach ($query2 as $row2) {
                    $dateFirstKeyheld = date("d/m/Y", $row2["timestampFirstKeyheld"]);
                    $timestampFirstKeyheld = $row2["timestampFirstKeyheld"];
                    $totalLocksManaged = $row2["totalLocksManaged"];
                }
            }
            
            $averageKeyholderRating = 0;
            $noOfKeyholderRatings = 0;
            $averageKeyholderRating = 0;
            $query2 = $pdo->prepare("select
                coalesce(cast(avg(l.rating) as decimal(3,2)), 0) as averageRating,
                coalesce(count(*), 0) as noOfRatings
            from ShareableLocks_V2 as s, Locks_V2 as l
            where s.user_id = :userID and 
                l.shared_id = s.share_id and 
                l.rating > 0 and 
                l.test = 0 and 
                l.timestamp_locked > 1451606400
            order by l.timestamp_locked asc");
            $query2->execute(array('userID' => $row["u_user_id"]));
            if ($query2->rowCount() == 1) {
                foreach ($query2 as $row2) {
                    $averageKeyholderRating = $row2["averageRating"];
                    $noOfKeyholderRatings = $row2["noOfRatings"];
                    if ($noOfKeyholderRatings < 5) { $averageKeyholderRating = 0; }
                }
            }
            
            if ($totalLocksManaged >= 1500 && time() - $timestampFirstKeyheld >= 15552000 && $timestampFirstKeyheld > 0) { $keyholderLevel = 5; }
            elseif ($totalLocksManaged >= 500 && time() - $timestampFirstKeyheld >= 10368000 && $timestampFirstKeyheld > 0) { $keyholderLevel = 4; }
            elseif ($totalLocksManaged >= 100 && time() - $timestampFirstKeyheld >= 5184000 && $timestampFirstKeyheld > 0) { $keyholderLevel = 3; }
            elseif ($totalLocksManaged >= 10 && time() - $timestampFirstKeyheld) { $keyholderLevel = 2; }
            else { $keyholderLevel = 1; }
        
            $secondsLockedInCurrentLock = 0;
            $query2 = $pdo->prepare("select 
                coalesce(max(:timestampNow - l.timestamp_locked), 0) as secondsLockedInCurrentLock
            from Locks_V2 as l
            where l.user_id = :userID and 
                l.deleted = 0 and 
                l.display_in_stats = 1 and 
                l.test = 0 and 
                l.timestamp_locked > 1451606400 and 
                l.unlocked = 0");
            $query2->execute(array('userID' => $row["u_user_id"], 'timestampNow' => time()));
            if ($query2->rowCount() == 1) {
                foreach ($query2 as $row2) {
                    $secondsLockedInCurrentLock = $row2["secondsLockedInCurrentLock"];
                }
            }
            
            $cumulativeSecondsLocked = 0;
            $noOfLocks = 0;
            $noOfLocksCompleted = 0;
            $lastTimestampLocked = 0;
            $lastTimestampUnlocked = 0;
            $longestSecondsLocked = 0;
            $query2 = $pdo->prepare("select 
                l.deleted as l_deleted,
                l.timestamp_locked as l_timestamp_locked,
                l.timestamp_unlocked as l_timestamp_unlocked,
                l.unlocked as l_unlocked
            from Locks_V2 as l where l.user_id = :userID and 
                l.display_in_stats = 1 and 
                l.fake = 0 and 
                l.test = 0 and 
                l.timestamp_locked > 1451606400 and 
                (l.unlocked = 1 or (l.unlocked = 0 and l.deleted = 0))
            order by l.timestamp_locked");
            $query2->execute(array('userID' => $row["u_user_id"]));
            foreach ($query2 as $row2) {
                $deleted = $row2["l_deleted"];
                $timestampLocked = $row2["l_timestamp_locked"];
                $timestampUnlocked = $row2["l_timestamp_unlocked"];
                $unlocked = $row2["l_unlocked"];
                if ($deleted == 0 && $unlocked == 0) { $timestampUnlocked = time(); }
                $secondsLocked = $timestampUnlocked - $timestampLocked;
                if ($secondsLocked <= 0) { continue; }
                $noOfLocks++;
                if ($unlocked == 1) { $noOfLocksCompleted++; }
                if ($secondsLocked > $longestSecondsLocked && $unlocked == 1) { $longestSecondsLocked = $secondsLocked; }
                if ($timestampLocked >= $lastTimestampLocked && $timestampUnlocked <= $lastTimestampUnlocked) { continue; }
                if ($timestampLocked <= $lastTimestampUnlocked) {
                    $timestampLocked = $lastTimestampUnlocked;
                    $secondsLocked = $timestampUnlocked - $timestampLocked;
                }
                if ($timestampLocked >= $lastTimestampLocked && $timestampUnlocked > $lastTimestampUnlocked) { $cumulativeSecondsLocked = $cumulativeSecondsLocked + $secondsLocked; }
                //if ($secondsLocked > $longestSecondsLocked) { $longestSecondsLocked = $secondsLocked; }
                $lastTimestampLocked = $timestampLocked;
                $lastTimestampUnlocked = $timestampUnlocked;
            }
            if ($noOfLocks > 0) {
                $averageTimeLockedInSeconds = $cumulativeSecondsLocked / $noOfLocks;
            } else {
                $averageTimeLockedInSeconds = $cumulativeSecondsLocked;
            }
            $longestCompletedLockInSeconds = $longestSecondsLocked;
            $totalNoOfLocks = $noOfLocks;
            $totalNoOfCompletedLocks = $noOfLocksCompleted;
     
            $averageLockeeRating = 0;
            $noOfLockeeRatings = 0;
            $query2 = $pdo->prepare("select
                coalesce(cast(avg(l.rating_from_keyholder) as decimal(3,2)), 0) as averageRating,
                coalesce(count(*), 0) as noOfRatings
            from Locks_V2 as l
            where l.user_id = :userID and 
                l.display_in_stats = 1 and 
                l.fake = 0 and 
                l.rating_from_keyholder > 0 and 
                l.test = 0");
            $query2->execute(array('userID' => $row["u_user_id"]));
            if ($query2->rowCount() == 1) {
                foreach ($query2 as $row2) {
                    $averageLockeeRating = $row2["averageRating"];
                    $noOfLockeeRatings = $row2["noOfRatings"];
                    if ($noOfLockeeRatings < 5) { $averageLockeeRating = 0; }
                }
            }
            
            if ($cumulativeMonthsLocked >= 24) { $lockeeLevel = 5; }
            elseif ($cumulativeMonthsLocked >= 12) { $lockeeLevel = 4; }
            elseif ($cumulativeMonthsLocked >= 6 && $cumulativeMonthsLocked < 12) { $lockeeLevel = 3; }
            elseif ($cumulativeMonthsLocked >= 2 && $cumulativeMonthsLocked < 6) { $lockeeLevel = 2; }
            else { $lockeeLevel = 1; }
            
            $query2 = $pdo->prepare("select id from Relations where 
            user_two_id = :userTwoID and 
            status = 1");
            $query2->execute(array('userTwoID' => $userNo));
            $followersCount = $query2->rowCount();
            
            $query2 = $pdo->prepare("select id from Relations where 
                user_one_id = :userOneID and 
                status = 1");
            $query2->execute(array('userOneID' => $userNo));
            $followingCount = $query2->rowCount();
        
            $user = array(
                'userID' => (int)$row["u_id"],
                'username' => (string)$row["u_username"],
                'discordID' => (string)$row["u_discord_id"],
                'averageKeyholderRating' => (double)$averageKeyholderRating,
                'averageLockeeRating' => (double)$averageLockeeRating,
                'averageTimeLockedInSeconds' => (int)$averageTimeLockedInSeconds,
                'buildNumberInstalled' => (int)$row["u_build_number_installed"],
                'cumulativeSecondsLocked' => (int)$cumulativeSecondsLocked,
                'dateFirstKeyheld' => $dateFirstKeyheld,
                'displayInStats' => (int)$row["u_display_in_stats"],
                'followersCount' => (int)$followersCount,
                'followingCount' => (int)$followingCount,
                'joined' => $row["u_created"],
                'keyholderLevel' => (int)$keyholderLevel,
                'lockeeLevel' => (int)$lockeeLevel,
                'longestCompletedLockInSeconds' => (int)$longestCompletedLockInSeconds,
                'mainRole' => $mainRole,
                'noOfLocksFlaggedAsTrusted' => (int)$noOfLocksFlaggedAsTrusted,
                'noOfKeyholderRatings' => (int)$noOfKeyholderRatings,
                'noOfLockeeRatings' => (int)$noOfLockeeRatings,
                'noOfLocksManagingNow' => (int)$noOfLocksManagingNow,
                'noOfLocksManagingNowFixed' => (int)$noOfLocksManagingNowFixed,
                'noOfLocksManagingNowVariable' => (int)$noOfLocksManagingNowVariable,
                'noOfSharedLocks' => (int)$noOfSharedLocks,
                'noOfSharedLocksFixed' => (int)$noOfSharedLocksFixed,
                'noOfSharedLocksVariable' => (int)$noOfSharedLocksVariable,
                'secondsLockedInCurrentLock' => (int)$secondsLockedInCurrentLock,
                'status' => $status,
                'timestampFirstKeyheld' => (int)$timestampFirstKeyheld,
                'timestampJoined' => strtotime($row["u_created"]),
                'timestampLastActive' => (int)$row["u_timestamp_last_active"],
                'totalLocksManaged' => (int)$totalLocksManaged,
                'totalNoOfCompletedLocks' => (int)$totalNoOfCompletedLocks,
                'totalNoOfLocks' => (int)$totalNoOfLocks,
                'twitterUsername' => (string)$row["u_twitter_handle"],
                'versionInstalled' => $row["u_version_installed"]
            );
            array_push($array["users"], $user);
        }
        $query = null;
        $pdo = null;
        
        $fp = fopen('../api/v0.5/userdata.json', 'w');
        fwrite($fp, json_encode($array, JSON_PRETTY_PRINT));
        fclose($fp);
        die();
    } else {
        header("HTTP/1.1 204 No Content", true, 204);
        $array["response"] = array('status' => 204, 'message' => 'no records found', 'timestampGenerated' => time());
        echo json_encode($array, JSON_PRETTY_PRINT);
        $query = null;
        $pdo = null;
        die();
    }
} catch (PDOException $e) {
    $query = null;
    $pdo = null;
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>
