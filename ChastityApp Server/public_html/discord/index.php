<?php
try {
    include "../../includes/app.php";
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    if (isset($_GET["error"])) {
        echo "There was an error authenticating your Discord account.<br/><br/>Please return to the ".$appName." app to try again";
    } elseif (isset($_GET["code"])) {
        $token = curl_init();
        curl_setopt_array($token, array(
            CURLOPT_URL => "https://discordapp.com/api/oauth2/token",
            CURLOPT_POST => 1,
            CURLOPT_POSTFIELDS => http_build_query(array(
                "grant_type" => "authorization_code",
                "client_id" => "xxxxx",
                "client_secret" => "xxxxx",
                "redirect_uri" => $appServerDomain."/discord/",
                "code" => $_GET["code"]
            ))
        ));
        curl_setopt($token, CURLOPT_RETURNTRANSFER, true);
        $resp = json_decode(curl_exec($token));
        curl_close($token);
        if (isset($resp->access_token)) {
            $access_token = $resp->access_token;
            $info = curl_init();
            curl_setopt_array($info, array(
                CURLOPT_URL => "https://discordapp.com/api/users/@me",
                CURLOPT_HTTPHEADER => array(
                    "Authorization: Bearer {$access_token}"
                ),
                CURLOPT_RETURNTRANSFER => true
            ));
            $user = json_decode(curl_exec($info));
            curl_close($info);
                
            if ($stateUserIDKey1 == "userID" && strlen($stateUserID) == 23 && time() - $stateUserIDKey2 <= 120) {
                $iPod = stripos($_SERVER['HTTP_USER_AGENT'], "iPod");
                $iPhone = stripos($_SERVER['HTTP_USER_AGENT'], "iPhone");
                $iPad = stripos($_SERVER['HTTP_USER_AGENT'], "iPad");
                $Android = stripos($_SERVER['HTTP_USER_AGENT'], "Android");
    
                $query = $pdo->prepare("select id from UserIDs_V2 where discord_id = :discordID");
                $query->execute(array('discordID' => $user->id));
                if ($query->rowCount() == 1) {
                    foreach ($query as $row) {
                        $query2 = $pdo->prepare("update UserIDs_V2 set discord_discriminator = null, discord_username = null, discord_id = null where id = :id");
                        $query2->execute(array('id' => $row["id"]));
                    }
                }
                    
                $query = $pdo->prepare("update UserIDs_V2 set discord_discriminator = :discordDiscriminator, discord_username = :discordUsername, discord_id = :discordID where user_id = :userID");
                $query->execute(array('discordDiscriminator' => $user->discriminator, 'discordUsername' => $user->username, 'discordID' => $user->id, 'userID' => $stateUserID));

                if ($Android) {
                    header("Location: intent://".$_SERVER['REQUEST_URI']."/#Intent;scheme=".$appIntentScheme.";package=".$appPackageName.";end");
                } elseif ($iPad || $iPhone || $iPod) {
                    header("Location: ".$appIntentScheme."://".$_SERVER['REQUEST_URI']."/#Intent;scheme=".$appIntentScheme.";package=".$appPackageName.";end");
                } else {
                    echo "Your Discord username is now available in the ".$appName." app. You may need to restart/refresh the app for it to appear.";
                }
            } else {
                print "Error: Problem with URL tokens";
            }
        } else {
            echo "There was an error authenticating your Discord account.<br/><br/>Please return to the ".$appName." app to try again";
        }
    } else {
        echo "There was an error authenticating your Discord account.<br/><br/>Please return to the ".$appName." app to try again";
    }
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>