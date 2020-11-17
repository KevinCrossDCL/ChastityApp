<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();
    
    $username = "";
    // Status 0 = Pending, 1 = Accepted, 2 = Declined, 3 = Blocked
    // THE FOLLOWING IF LINE WON'T WORK BECAUSE DECRYPTION CODE HAS BEEN REMOVED BUT IT'S CHECKING TO SEE IF TWO USER ID TOKENS (ENCRYPTED DIFFERENTLY) ARE THE SAME AND TIME SENT IS WITHIN THE LAST 60 SECONDS
    if ($userID1 == $userID2 && time() - $userID1Key2 <= 60) {
        $query = $pdo->prepare("select id from UserIDs_V2 where user_id = :userID");
        $query->execute(array('userID' => $userID1));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $userOneID = $row["id"];
            }
        }
        $userTwoID = $_POST['profileID'];
        $query = $pdo->prepare("select id, status from Relations where user_one_id = :userTwoID and user_two_id = :userOneID and status = 0");
        $query->execute(array('userOneID' => $userOneID, 'userTwoID' => $userTwoID));
        if ($query->rowCount() == 1) {
            $query = $pdo->prepare("update Relations set status = 1 where user_one_id = :userTwoID and user_two_id = :userOneID and status = 0");
            $result = $query->execute(array('userOneID' => $userOneID, 'userTwoID' => $userTwoID));
            if ($result == 1) { echo "Successfully Accepted Follow Request"; }
        }
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>