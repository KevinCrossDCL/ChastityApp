<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select
            r.id as r_id, 
            r.activity_type as r_activity_type, 
            r.lock_id as r_lock_id,
            r.mentioned_user_id as r_mentioned_user_id,
            r.read_activity as r_read_activity,
            r.share_id as r_share_id, 
            r.test_lock as r_test_lock,
            r.timestamp_added as r_timestamp_added,
            if (u.username = '', concat('CKU', u.id), u.username) as r_mentioned_username
        from RecentActivity as r, UserIDs_V2 as u where 
            r.user_id = :userID and 
            ((r.mentioned_user_id > 0 and u.id = r.mentioned_user_id) or r.mentioned_user_id = 0) and 
            ".(time() - 604800)." <= r.timestamp_added"); // Last 7 days
        $query->execute(array('userID' => $userID1));
        foreach ($query as $row) {
            array_push($JSON, array(
                'id' => $row["r_id"],
                'activityType$' => (string)$row["r_activity_type"],
                'lockID$' => (string)$row["r_lock_id"],
                'mentionedUserID' => (integer)$row["r_mentioned_user_id"],
                'mentionedUsername$' => (string)$row["r_mentioned_username"],
                'readActivity' => (integer)$row["r_read_activity"],
                'shareID$' => (string)$row["r_share_id"],
                'testLock' => (integer)$row["r_test_lock"],
                'timestamp' => (integer)$row["r_timestamp_added"]
            ));
        }
        echo json_encode($JSON);
    }
    $query = null;
    $query1 = null;
    $query2 = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>