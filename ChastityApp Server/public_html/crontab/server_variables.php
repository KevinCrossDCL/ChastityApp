<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../includes/app.php";
    
    $JSON = array();
    
    // SERVER VARIABLES
    $query = $pdo->prepare("select variable, value from ServerVariables");
    $query->execute();
    if ($query->rowCount() > 0) {
        foreach ($query as $row) {
            $variable = $row["variable"];
            $value = $row["value"];
            array_push($JSON, array('variable' => $variable, 'value' => $value));
        }
    }
    
    // GENERATED/TEMPLATE LOCKS
    $query = $pdo->prepare("select count(*) as noOfGeneratedLocks from GeneratedLocks where id > 0");
    $query->execute();
    if ($query->rowCount() > 0) {
        foreach ($query as $row) {
            array_push($JSON, array('variable' => 'noOfGeneratedLocks', 'value' => $row["noOfGeneratedLocks"]));
        }
    }
    
    // BOTS DATA
    $query = $pdo->prepare("select shared_id, bot_chosen, count(*) as count from Locks_V2 where shared_id <> '' and bot_chosen > 0 and fake = 0 and unlocked = 0 and deleted = 0 group by shared_id");
    $query->execute();
    foreach ($query as $row) {
        array_push($JSON, array('variable' => 'lockedCount'.$row["shared_id"], 'value' => $row["count"]));
    }
    $query = $pdo->prepare("select shared_id, bot_chosen, count(rating) as no_of_ratings, avg(rating) as average_rating from Locks_V2 where bot_chosen > 0 and rating > 0 and fake = 0 group by shared_id");
    $query->execute();
    foreach ($query as $row) {
        array_push($JSON, array('variable' => 'noOfRatings'.$row["shared_id"], 'value' => $row["no_of_ratings"]));
        array_push($JSON, array('variable' => 'rating'.$row["shared_id"], 'value' => $row["average_rating"]));
    }
    
    $query = null;
    $pdo = null;
    mysqli_close($mysqli);
    
    array_push($JSON, array('variable' => 'keyholderLevelBOT01', 'value' => "5"));
    array_push($JSON, array('variable' => 'keyholderLevelBOT02', 'value' => "5"));
    array_push($JSON, array('variable' => 'keyholderLevelBOT03', 'value' => "5"));
    array_push($JSON, array('variable' => 'keyholderLevelBOT04', 'value' => "5"));
    
    
    /*
    I know you can do it! Close the lock!
    Can I pleeeeease have the keys?
    Let me hold your key xx
    */
    array_push($JSON, array('variable' => 'phraseBOT01', 'value' => "Want me to play with you? xx"));
    /*
    I know a few techniques to make this interesting!
    Let me lock you up
    */
    array_push($JSON, array('variable' => 'phraseBOT02', 'value' => "Relax, we'll take it one step at a time."));
    /*
    Blue is my favorite color!
    At least, I won't regret this.
    Oh sweetie it will only be for a few days, HA HA
    Say goodbye to your key!
    */
    array_push($JSON, array('variable' => 'phraseBOT03', 'value' => "You gave me your keys. They're mine!"));
    /*
    I am in control!
    */
    array_push($JSON, array('variable' => 'phraseBOT04', 'value' => "Access Denied!"));
    
    $fp = fopen('../app/servervariables.json', 'w');
    fwrite($fp, json_encode($JSON));
    fclose($fp);

} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>