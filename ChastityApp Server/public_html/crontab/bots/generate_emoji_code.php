<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

ini_set("memory_limit","256M");

try {
    include "../../../includes/app.php";

    $file = fopen("emoji_code2.php", "w");
    
    fwrite($file, "<?php\n");
    
    echo "Generating Emoji Code<br />";
    fwrite($file, "// SET EMOJI\n");
    fwrite($file, "if (\$skipIfLines == 0) {\n");
    fwrite($file, "\t\$chanceRoll = mt_rand(1, 1000000);\n");
    fwrite($file, "\tif (\$keyholderEmoji == 0 || (\$keyholderEmoji > 0 && \$chanceRoll <= 50000 && time() - \$timestampLastChangedEmoji >= mt_rand(86400, 354600))) {\n");
    for ($userEmoji = 0; $userEmoji <= 78; $userEmoji++) {
        $query = $pdo->prepare("select
            count(*) as matches,
            keyholder_emoji
        from Locks_V2 where
            build >= 134 and 
            keyholder_emoji > 0 and 
            shared_id <> '' and 
            shared_id not like 'BOT0%' and
            user_emoji = :userEmoji
        group by keyholder_emoji
        order by matches desc limit 10");
        $query->execute(array("userEmoji" => $userEmoji));
        $rowCount = $query->rowCount();
        $rowsLooped = 0;
        if ($rowCount > 0) {
            $emojiString = "";
            foreach ($query as $row) {
                for ($i = $rowCount - $rowsLooped; $i > 0; $i--) {
                    if ($i > floor($rowCount / 2)) {
                        $emojiString = $emojiString.", 0, ".$row["keyholder_emoji"];
                    } else {
                        $emojiString = $emojiString.", ".$row["keyholder_emoji"];
                    }
                }
                $rowsLooped++;
            }
            fwrite($file, "\t\tif (\$userEmoji == $userEmoji) { array_push(\$emoji $emojiString); }\n");
        }
    }
    fwrite($file, "\t\tif (count(\$emoji) > 0) { \$newKeyholderEmoji = \$emoji[mt_rand(0, count(\$emoji) - 1)]; }\n");
    fwrite($file, "\t\tif (\$build < 166 && \$newKeyholderEmoji > 0 && \$newKeyholderEmoji <= 72) { \$keyholderEmoji = \$newKeyholderEmoji; }\n");
    fwrite($file, "\t\tif (\$build >= 166 && \$newKeyholderEmoji > 0 && \$newKeyholderEmoji <= 78) { \$keyholderEmoji = \$newKeyholderEmoji; }\n");
    fwrite($file, "\t}\n");
    fwrite($file, "}\n");
    
    fwrite($file, "?>");
    
    fclose($file);
    rename("emoji_code2.php", "emoji_code.php");
    $query = null;
    $pdo = null;

} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>