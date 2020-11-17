<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../includes/app.php";
    
    // DELETE LOCK LOG ITEMS IF THE LOCK WAS DELETED 31+ DAYS AGO
    $query = $pdo->prepare("delete from Locks_Log where lock_id in (select lock_id from Locks_V2 where deleted = 1 and timestamp_deleted < UNIX_TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 31 DAY)))");
    $query->execute();
    $locksLogCount = $query->rowCount();
    
    // DELETE ACCOUNTS THAT HAVE BEEN INACTIVE FOR 24 MONTHS
    $query = $pdo->prepare("delete from Locks_Log where user_id in (select user_id from UserIDs_V2 where last_active > '0000-00-00' and last_active < DATE_SUB(CURDATE(), INTERVAL 24 MONTH) and left(user_id, 3) <> 'BOT')");
    $query->execute();
    $locksLogCount = $locksLogCount + $query->rowCount();
    
    $query = $pdo->prepare("delete from Locks_V2 where user_id in (select user_id from UserIDs_V2 where last_active > '0000-00-00' and last_active < DATE_SUB(CURDATE(), INTERVAL 24 MONTH) and left(user_id, 3) <> 'BOT')");
    $query->execute();
    $locksCount = $query->rowCount();
    
    // DELETE TEST LOCK IF THE LOCK WAS DELETED 31+ DAYS AGO
    $query = $pdo->prepare("delete from Locks_V2 where test = 1 and deleted = 1 and timestamp_deleted < UNIX_TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 31 DAY))");
    $query->execute();
    $testLocksCount = $query->rowCount();
    
    $query = $pdo->prepare("delete from ModifiedLocks_V2 where user_id in (select user_id from UserIDs_V2 where last_active > '0000-00-00' and last_active < DATE_SUB(CURDATE(), INTERVAL 24 MONTH) and left(user_id, 3) <> 'BOT')");
    $query->execute();
    $modifiedLocksCount = $query->rowCount();
    
    $query = $pdo->prepare("delete from ShareableLocks_V2 where user_id in (select user_id from UserIDs_V2 where last_active > '0000-00-00' and last_active < DATE_SUB(CURDATE(), INTERVAL 24 MONTH) and left(user_id, 3) <> 'BOT')");
    $query->execute();
    $shareableLocksCount = $query->rowCount();
    
    $query = $pdo->prepare("delete from UserIDs_V2 where last_active > '0000-00-00' and last_active < DATE_SUB(CURDATE(), INTERVAL 24 MONTH) and left(user_id, 3) <> 'BOT'");
    $query->execute();
    $userIDsCount = $query->rowCount();
    
    $query = $pdo->prepare("insert into Records_Deleted (
        id, 
        locks_deleted, 
        locks_log_deleted, 
        modified_locks_deleted, 
        shareable_locks_deleted, 
        test_locks_deleted,
        user_ids_deleted, 
        date_deleted
    ) values (
        '',
        :locksDeleted, 
        :locksLogDeleted, 
        :modifiedLocksDeleted, 
        :shareableLocksDeleted,
        :testLocksDeleted,
        :userIDsDeleted,
        NOW())");
    $query->execute(array(
        'locksDeleted' => $locksCount, 
        'locksLogDeleted' => $locksLogCount, 
        'modifiedLocksDeleted' => $modifiedLocksCount,
        'shareableLocksDeleted' => $shareableLocksCount,
        'testLocksDeleted' => $testLocksCount,
        'userIDsDeleted' => $userIDsCount));
    
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>