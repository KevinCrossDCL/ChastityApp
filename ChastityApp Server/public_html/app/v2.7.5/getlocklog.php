<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    if ($userID1 == $userID2) {
        if ($_POST['build'] < 134) {
            array_unshift($JSON, array(
                'id' => 0,
                'lockID' => $_POST['lockID'],
                'action$' => "OldVersion",
                'actionedBy$' => "App",
                'hidden' => 0,
                'private' => 0,
                'result$' => "",
                'timestamp' => 0,
                'totalActionTime' => 0
            )); 
        }
        $query = $pdo->prepare("select
            id,
            lock_id,
            user_id,
            action,
            actioned_by,
            hidden,
            private,
            result,
            timestamp,
            total_action_time
        from 
            Locks_Log 
        where 
            id > :lastLogID and 
            lock_id = :lockID and
            user_id = :userID 
        order by timestamp asc");
        $query->execute(array(
            'userID' => $userID1,
            'lockID' => $_POST['lockID'], 
            'lastLogID' => $_POST['lastLogID']));
        if ($query->rowCount() > 0) {
            foreach ($query as $row) {
                if ($lastHidden == 1 && $row["hidden"] == 1 && $lastTimestamp == $row["timestamp"]) {
                    continue;
                }
                array_push($JSON, array(
                    'id' => $row["id"],
                    'lockID' => $row["lock_id"],
                    'action$' => $row["action"],
                    'actionedBy$' => $row["actioned_by"],
                    'hidden' => $row["hidden"],
                    'private' => $row["private"],
                    'result$' => $row["result"],
                    'timestamp' => $row["timestamp"],
                    'totalActionTime' => $row["total_action_time"]
                ));
                $lastHidden = $row["hidden"];
                $lastTimestamp = $row["timestamp"];
            }
        }
        echo json_encode($JSON);
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>