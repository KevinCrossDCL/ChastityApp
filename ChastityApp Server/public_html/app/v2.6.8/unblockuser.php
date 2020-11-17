<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    $username = "";
    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select id from UserIDs_V2 where user_id = :userID");
        $query->execute(array('userID' => $userID1));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $userOneID = $row["id"];
            }
        }
        $userTwoID = $_POST['profileID'];
        $query = $pdo->prepare("delete from Relations where user_one_id = :userOneID and user_two_id = :userTwoID and status = 3");
        $result = $query->execute(array('userOneID' => $userOneID, 'userTwoID' => $userTwoID));
        if ($result == 1) { echo "Successfully Unblocked"; }
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>