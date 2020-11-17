<?php
session_start();
require "autoload.php";
use Abraham\TwitterOAuth\TwitterOAuth;

include "../../includes/app.php";

$consumer_key = "xxxxx";
$consumer_secret = "xxxxx";
    
if (isset($_SESSION["oauth_token"])) {
    $oauth_token = $_SESSION["oauth_token"];
    unset($_SESSION["oauth_token"]);
    $connection = new TwitterOAuth($consumer_key, $consumer_secret);
    $params = array(
        "oauth_verifier" => $_GET['oauth_verifier'],
        "oauth_token"=>$_GET['oauth_token']
    );
    $access_token = $connection->oauth("oauth/access_token", $params);
    $connection = new TwitterOAuth($consumer_key, $consumer_secret, $access_token["oauth_token"], $access_token["oauth_token_secret"]);
    $content = $connection->get("account/verify_credentials");
    $contentJSON = json_decode(json_encode($content), true);
    $twitterHandle = $contentJSON["screen_name"];
    
    $_GET["state"] = $_SESSION["state"];

    if ($stateUserIDKey1 == "userID" && strlen($stateUserID) == 23 && time() - $stateUserIDKey2 <= 120) {
        $iPod = stripos($_SERVER["HTTP_USER_AGENT"], "iPod");
        $iPhone = stripos($_SERVER["HTTP_USER_AGENT"], "iPhone");
        $iPad = stripos($_SERVER["HTTP_USER_AGENT"], "iPad");
        $Android = stripos($_SERVER["HTTP_USER_AGENT"], "Android");
        
        $query = $pdo->prepare("select id from UserIDs_V2 where twitter_handle = :twitterHandle");
        $query->execute(array("twitterHandle" => $twitterHandle));
        if ($query->rowCount() == 1) {
            foreach ($query as $row) {
                $query2 = $pdo->prepare("update UserIDs_V2 set twitter_handle = null where id = :id");
                $query2->execute(array("id" => $row["id"]));
            }
        }
                    
        $query = $pdo->prepare("update UserIDs_V2 set twitter_handle = :twitterHandle where user_id = :userID");
        $query->execute(array("twitterHandle" => $twitterHandle, "userID" => $stateUserID));

        if ($Android) {
            header("Location: intent://".$_SERVER['REQUEST_URI']."/#Intent;scheme=".$appIntentScheme.";package=".$appPackageName.";end");
        } elseif ($iPad || $iPhone || $iPod) {
            header("Location: ".$appIntentScheme."://".$_SERVER['REQUEST_URI']."/#Intent;scheme=".$appIntentScheme.";package=".$appPackageName.";end");
        } else {
            echo "Your Twitter handle is now available in the ".$appName." app. You may need to restart/refresh the app for it to appear.";
        }
    }
}
else {
    $_SESSION["state"] = $_GET["state"];
    $connection = new TwitterOAuth($consumer_key, $consumer_secret);
    $temporary_credentials = $connection->oauth("oauth/request_token", array("oauth_callback" => $appServerDomain."/twitteroauth"));
    $_SESSION["oauth_token"] = $temporary_credentials["oauth_token"];
    $_SESSION["oauth_token_secret"] = $temporary_credentials["oauth_token_secret"];
    $url = $connection->url("oauth/authorize", array("oauth_token" => $temporary_credentials["oauth_token"]));
    header("Location: ".$url); 
}
?>