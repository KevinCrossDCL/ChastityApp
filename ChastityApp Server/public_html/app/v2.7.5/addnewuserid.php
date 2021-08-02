<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("insert into UserIDs_V2 (
            id,
            user_id,
            build_number_installed,
            created,
            last_active,
            platform,
            timestamp_last_active,
            version_installed
        ) values (
            '',
            :userID,
            :buildNumberInstalled,
            NOW(), 
            NOW(), 
            :platform,
            :timestampLastActive,
            :versionInstalled)");
        $query->execute(array(
            'userID' => $userID1, 
            'buildNumberInstalled' => $_POST['build'],
            'platform' => $_POST['platform'],
            'timestampLastActive' => time(),
            'versionInstalled' => $_POST['version']));
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>