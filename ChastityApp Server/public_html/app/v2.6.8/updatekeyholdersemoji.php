<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("update Locks_V2 set keyholder_emoji = :emojiChosen, keyholder_emoji_colour = :emojiColourSelected where shared_id = :shareID and lock_id = :lockID");
        $query->execute(array('emojiChosen' => $_POST['emojiChosen'], 'emojiColourSelected' => $_POST['emojiColourSelected'], 'shareID' => $_POST['shareID'], 'lockID' => $_POST['lockID']));
        $query = $pdo->prepare("select user_id from UserIDs_V2 where id = :sharedUserID");
        $query->execute(array('sharedUserID' => $_POST['sharedUserID']));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $lockedUserID = $row["user_id"];
            }
            $query = $pdo->prepare("insert into Locks_Log (id, timestamp, lock_id, user_id, action, actioned_by, result, total_action_time, private) values ('', :timestampNow, :lockID, :userID, :action, :actionedBy, :result, :totalActionTime, :private)");
            $query->execute(array('timestampNow' => time(), 'lockID' => $_POST['lockID'], 'userID' => $lockedUserID, 'action' => $_POST['logAction'], 'actionedBy' => $_POST['logActionedBy'], 'result' => $_POST['logResult'], 'totalActionTime' => $_POST['logTotalActionTime'], 'private' => $_POST['logPrivate']));
        }
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>