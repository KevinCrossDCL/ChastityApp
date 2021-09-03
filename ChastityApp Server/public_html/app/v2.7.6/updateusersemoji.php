<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("update Locks_V2 set user_emoji = :emojiChosen, user_emoji_colour = :emojiColourSelected where user_id = :userID and lock_id  = :lockID");
        $query->execute(array('emojiChosen' => $_POST['emojiChosen'], 'emojiColourSelected' => $_POST['emojiColourSelected'], 'userID' => $userID1, 'lockID' => $_POST['lockID']));
        $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :private)");
        $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $userID1, 'action' => $_POST['logAction'], 'actionedBy' => $_POST['logActionedBy'], 'result' => $_POST['logResult'], 'totalActionTime' => $_POST['logTotalActionTime'], 'private' => $_POST['logPrivate']));
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>