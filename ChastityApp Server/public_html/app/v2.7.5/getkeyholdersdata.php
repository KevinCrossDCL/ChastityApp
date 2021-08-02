<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    if ($userID1 == $userID2) {
        $query1 = $pdo->prepare("select 
            id, 
            lock_id, 
            shared_id, 
            name,
            keyholder_emoji,
            keyholder_emoji_colour from Locks_V2 where user_id = :userID and deleted = 0 order by lock_id asc");
        $query1->execute(array('userID' => $userID1));
        if ($query1->rowCount() > 0) {
            foreach ($query1 as $row1) {
                $hiddenFromOwner = 0;
                $timestampHiddenFromOwner = 0;
                $id = $row1["id"];
                $keyholderEmoji = $row1["keyholder_emoji"];
                $keyholderEmojiColour = $row1["keyholder_emoji_colour"];
                if ($keyholderEmojiColour == 0) { $keyholderEmojiColour = 1; }
                $keyholderLastActive = 0;
                $keyholderStatus = 0;
                $keyholderUsername = "";
                $sharedID = $row1["shared_id"];
                $lockName = $row1["name"];
                if ($sharedID != "") {
                    $query2 = $pdo->prepare("select 
                        l.id as l_id, 
                        l.shared_id as l_shared_id,
                        l.user_id as l_user_id, 
                        l.removed_by_keyholder as l_removed_by_keyholder,
                        l.timestamp_removed_by_keyholder as l_timestamp_removed_by_keyholder,
                        s.hide_from_owner as s_hide_from_owner, 
                        s.name as s_name,
                        s.timestamp_hidden as s_timestamp_hidden, 
                        s.share_id as s_shared_id, 
                        s.user_id as s_user_id, 
                        u.build_number_installed as u_build_number_installed, 
                        u.id as u_keyholder_id, 
                        u.keyholder_level as u_keyholder_level,
                        u.lockee_level as u_lockee_level,
                        u.main_role as u_main_role,
                        u.status as u_status, 
                        u.timestamp_last_active as u_timestamp_last_active, 
                        u.user_id as u_user_id, 
                        u.username as u_username
                    from 
                        Locks_V2 as l,
                        ShareableLocks_V2 as s,
                        UserIDs_V2 as u 
                    where 
                        l.id = :id and 
                        l.shared_id = s.share_id and 
                        s.user_id = u.user_id");
                    $query2->execute(array('id' => $row1["id"]));
                    if ($query2->rowCount() == 1) {
                        foreach ($query2 as $row2) {
                            $hiddenFromOwner = $row2["s_hide_from_owner"];
                            $timestampHiddenFromOwner = $row2["s_timestamp_hidden"];
                            $removedByKeyholder = $row2["l_removed_by_keyholder"];
                            $timestampRemovedByKeyholder = $row2["l_timestamp_removed_by_keyholder"];
                            $keyholderBuildNumberInstalled = $row2["u_build_number_installed"];
                            $keyholderID = $row2["u_keyholder_id"];
                            $keyholderLastActive = $row2["u_timestamp_last_active"];
                            $keyholderMainRole = $row2["u_main_role"];
                            $keyholderMainRoleLevel = 0;
                            if ($keyholderMainRole == 1) {
                                $keyholderMainRoleLevel = $row2["u_keyholder_level"];
                            }
                            if ($keyholderMainRole == 2) {
                                $keyholderMainRoleLevel = $row2["u_lockee_level"];
                            }
                            $keyholderStatus = $row2["u_status"];
                            $keyholderUsername = $row2["u_username"];
                            if ($keyholderUsername == "") {
                                $keyholderUsername = "CKU".$keyholderID;
                            }
                            if ($row2["s_name"] != "") { $lockName = $row2["s_name"]; }
                        }
                    }
                }
                array_push($JSON, array(
                    'hiddenFromOwner' => $hiddenFromOwner,
                    'id' => $row1["lock_id"],
                    'keyholderBuildNumberInstalled' => $keyholderBuildNumberInstalled,
                    'keyholderEmojiChosen' => $keyholderEmoji,
                    'keyholderEmojiColourSelected' => $keyholderEmojiColour,
                    'keyholderID' => $keyholderID,
                    'keyholderLastActive' => $keyholderLastActive,
                    'keyholderMainRole' => $keyholderMainRole,
                    'keyholderMainRoleLevel' => $keyholderMainRoleLevel,
                    'keyholderStatus' => $keyholderStatus,
                    'keyholderUsername$' => $keyholderUsername,
                    'lockName$' => $lockName,
                    'removedByKeyholder' => $removedByKeyholder,
                    'rowInDB' => $id,
                    'timestampHiddenFromOwner' => $timestampHiddenFromOwner,
                    'timestampRemovedByKeyholder' => $timestampRemovedByKeyholder
                ));
            }
            echo json_encode($JSON);
        } else {
            echo "No Locks";
        }
    }
    $query1 = null;
    $query2 = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>