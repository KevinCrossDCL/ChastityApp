<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    if ($userID1 == $userID2) {
        
        // FOLLOWERS
        $query = $pdo->prepare("select 
            r.user_one_id as r_user_one_id, 
            u.discord_id as u_discord_id, 
            u.keyholder_level as u_keyholder_level,
            u.lockee_level as u_lockee_level,
            u.main_role as u_main_role,
            u.status as u_status,
            u.timestamp_last_active as u_timestamp_last_active,
            u.twitter_handle as u_twitter_handle,
            if (u.username = '', concat('CKU', u.id), u.username) as u_username
        from Relations as r, UserIDs_V2 as u where 
            r.user_two_id = :userTwoID and 
            r.status = 1 and 
            r.user_one_id = u.id"); // and u.display_in_stats = 1
        $query->execute(array('userTwoID' => $_POST['profileID']));
        foreach ($query as $row) {
            array_push($JSON, array(
                'jsonNo' => 5,
                'id' => (int)$row["r_user_one_id"],
                'discordID$' => (string)$row["u_discord_id"],
                'keyholderLevel' => (int)$row["u_keyholder_level"],
                'lockeeLevel' => (int)$row["u_lockee_level"],
                'mainRole' => (int)$row["u_main_role"],
                'onlineStatus' => (int)$row["u_status"],
                'relationStatus' => 1,
                'timestampLastActive' => (int)$row["u_timestamp_last_active"],
                'twitterHandle$' => (string)$row["u_twitter_handle"],
                'username$' => $row["u_username"]
            ));
        }
        
        // FOLLOWING
        $query = $pdo->prepare("select 
            r.user_two_id as r_user_two_id, 
            u.discord_id as u_discord_id, 
            u.keyholder_level as u_keyholder_level,
            u.lockee_level as u_lockee_level,
            u.main_role as u_main_role,
            u.status as u_status,
            u.timestamp_last_active as u_timestamp_last_active,
            u.twitter_handle as u_twitter_handle,
            if (u.username = '', concat('CKU', u.id), u.username) as u_username
        from Relations as r, UserIDs_V2 as u where 
            r.user_one_id = :userOneID and 
            r.status = 1 and 
            r.user_two_id = u.id"); // and u.display_in_stats = 1
        $query->execute(array('userOneID' => $_POST['profileID']));
        foreach ($query as $row) {
            array_push($JSON, array(
                'jsonNo' => 6,
                'id' => (int)$row["r_user_two_id"],
                'discordID$' => (string)$row["u_discord_id"],
                'keyholderLevel' => (int)$row["u_keyholder_level"],
                'lockeeLevel' => (int)$row["u_lockee_level"],
                'mainRole' => (int)$row["u_main_role"],
                'onlineStatus' => (int)$row["u_status"],
                'relationStatus' => 1,
                'timestampLastActive' => (int)$row["u_timestamp_last_active"],
                'twitterHandle$' => (string)$row["u_twitter_handle"],
                'username$' => $row["u_username"]
            ));
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