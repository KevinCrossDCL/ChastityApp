<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("update ShareableLocks_V2 set 
            block_test_locks = :blockTestLocks,
            block_users_already_locked = :blockUsersAlreadyLocked,
            block_users_with_stats_hidden = :blockUsersWithStatsHidden,
            card_info_hidden = :cardInfoHidden, 
            check_in_frequency_in_seconds = :checkInFrequencyInSeconds,
            force_trust = :forceTrust,
            key_disabled = :keyDisabled, 
            keyholder_decision_disabled = :keyholderDecisionDisabled,
            late_check_in_window_in_seconds = :lateCheckInWindowInSeconds,
            max_auto_resets = :maxAutoResets,
            max_random_copies = :maxCopies,
            maximum_users = :maxUsers,
            min_random_copies = :minCopies, 
            min_rating_required = :minRatingRequired,
            minimum_version_required = :minVersionRequired,
            name = :name,
            require_dm = :requireDM, 
            reset_frequency_in_seconds = :resetFrequencyInSeconds,
            share_in_api = :shareInAPI,
            start_lock_frozen = :startLockFrozen,
            temporarily_disabled = :temporarilyDisabled,
            timer_hidden = :timerHidden 
        where user_id = :userID and share_id = :shareID");
        $query->execute(array(
            'blockTestLocks' => $_POST['blockTestLocks'],
            'blockUsersAlreadyLocked' => $_POST['blockUsersAlreadyLocked'],
            'blockUsersWithStatsHidden' => $_POST['blockUsersWithStatsHidden'],
            'cardInfoHidden' => $_POST['cardInfoHidden'],
            'checkInFrequencyInSeconds' => $_POST['checkInFrequencyInSeconds'],
            'forceTrust' => $_POST['forceTrust'], 
            'keyDisabled' => $_POST['keyDisabled'], 
            'keyholderDecisionDisabled' => $_POST['keyholderDecisionDisabled'],
            'lateCheckInWindowInSeconds' => $_POST['lateCheckInWindowInSeconds'],
            'maxAutoResets' => $_POST['maxAutoResets'],
            'maxCopies' => $_POST['maxCopies'],
            'maxUsers' => $_POST['maxUsers'],
            'minCopies' => $_POST['minCopies'],
            'minRatingRequired' => $_POST['minRatingRequired'],
            'minVersionRequired' => $_POST['minVersionRequired'],
            'name' => $_POST['name'], 
            'requireDM' => $_POST['requireDM'], 
            'resetFrequencyInSeconds' => $_POST['resetFrequencyInSeconds'],
            'shareInAPI' => $_POST['shareInAPI'], 
            'startLockFrozen' => $_POST['startLockFrozen'],
            'temporarilyDisabled' => $_POST['temporarilyDisabled'],
            'timerHidden' => $_POST['timerHidden'],
            'userID' => $userID1,
            'shareID' => $_POST['shareID']));
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>