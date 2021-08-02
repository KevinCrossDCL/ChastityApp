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
            l.id as l_id,
            l.lock_id as l_lock_id,
            l.user_id,
            l.action as l_action,
            l.actioned_by as l_actioned_by,
            l.hidden as l_hidden,
            l.private as l_private,
            l.result as l_result,
            l.timestamp as l_timestamp,
            l.total_action_time as l_total_action_time
        from 
            Locks_Log as l, UserIDs_V2 as u
        where 
            l.id > :lastLogID and 
            l.lock_id = :lockID and 
            l.user_id = u.user_id and 
            u.id = :id 
        order by l.timestamp asc");
        $query->execute(array(
            'lastLogID' => $_POST['lastLogID'],
            'lockID' => $_POST['lockID'], 
            'id' => $_POST['usersID']));
        if ($query->rowCount() > 0) {
            foreach ($query as $row) {
                array_push($JSON, array(
                    'id' => $row["l_id"],
                    'lockID' => $row["l_lock_id"],
                    'action$' => $row["l_action"],
                    'actionedBy$' => $row["l_actioned_by"],
                    'hidden' => ["l_hidden"],
                    'private' => $row["l_private"],
                    'result$' => $row["l_result"],
                    'timestamp' => $row["l_timestamp"],
                    'totalActionTime' => $row["l_total_action_time"]
                ));
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