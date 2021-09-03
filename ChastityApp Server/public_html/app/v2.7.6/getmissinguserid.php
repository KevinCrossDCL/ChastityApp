<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    $updateCount = 0;
    
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select
            user_id
        from Locks_V2 where 
            id = :rowInDB and 
            lock_id = :lockID and
            lock_group_id = :groupID and 
            shared_id = :sharedID and
            combination = :combination");
        $query->execute(array('rowInDB' => $_POST['rowInDB'], 'lockID' => $_POST['lockID'], 'groupID' => $_POST['groupID'], 'sharedID' => $_POST['sharedID'], 'combination' => $_POST['combination']));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                array_push($JSON, array('variable' => 'userID', 'value' => $row["user_id"]));
            }
            echo json_encode($JSON);
        } else {
            echo "User ID Not Found";
        }
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>