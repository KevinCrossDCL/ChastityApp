<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

try {
    include "../../../includes/app.php";
    
    $JSON = array();

    if ($userID1 == $userID2) {
        $query = $pdo->prepare("select id
        from GeneratedLocks where 
            simulation_average_minutes_locked >= :min and
            simulation_worst_case_minutes_locked <= :max and 
            ((regularity >= :regularity and :regularity = 0) or
            (regularity = :regularity and :regularity > 0)) order by rand() limit 1000"); 
        $query->execute(array('min' => $_POST['min'], 'max' => $_POST['max'], 'regularity' => $_POST['regularity']));
        $noOfMatches = $query->rowCount();
        $query = $pdo->prepare("select
            id,
            build,
            level,
            max_random_double_ups,
            max_random_freezes,
            max_random_greens,
            max_random_reds,
            max_random_resets,
            max_random_stickies,
            max_random_yellows,
            max_random_yellows_add,
            max_random_yellows_minus,
            min_random_double_ups,
            min_random_freezes,
            min_random_greens,
            min_random_reds,
            min_random_resets,
            min_random_stickies,
            min_random_yellows,
            min_random_yellows_add,
            min_random_yellows_minus,
            minimum_version_required,
            multiple_greens_required,
            regularity,
            simulation_average_minutes_locked,
            simulation_best_case_minutes_locked,
            simulation_worst_case_minutes_locked,
            version
        from GeneratedLocks where 
            simulation_average_minutes_locked >= :min and
            simulation_worst_case_minutes_locked <= :max and 
            ((regularity >= :regularity and :regularity = 0) or
            (regularity = :regularity and :regularity > 0)) order by rand() limit 20"); // limit 20
        $query->execute(array('min' => $_POST['min'], 'max' => $_POST['max'], 'regularity' => $_POST['regularity']));
        $iteration = 0;
        if ($query->rowCount() > 0) {
            foreach ($query as $row) {
                $iteration++;
                if ($iteration > 20) { break; }
                array_push($JSON, array(
                    'id' => $row["id"],
                    'build' => $row["build"],
                    'level' => $row["level"],
                    'maxRandomDoubleUps' => $row["max_random_double_ups"],
                    'maxRandomFreezes' => $row["max_random_freezes"],
                    'maxRandomGreens' => $row["max_random_greens"],
                    'maxRandomReds' => $row["max_random_reds"],
                    'maxRandomResets' => $row["max_random_resets"],
                    'maxRandomStickies' => $row["max_random_stickies"],
                    'maxRandomYellows' => $row["max_random_yellows"],
                    'maxRandomYellowsAdd' => $row["max_random_yellows_add"],
                    'maxRandomYellowsMinus' => $row["max_random_yellows_minus"],
                    'minRandomDoubleUps' => $row["min_random_double_ups"],
                    'minRandomFreezes' => $row["min_random_freezes"],
                    'minRandomGreens' => $row["min_random_greens"],
                    'minRandomReds' => $row["min_random_reds"],
                    'minRandomResets' => $row["min_random_resets"],
                    'minRandomStickies' => $row["min_random_stickies"],
                    'minRandomYellows' => $row["min_random_yellows"],
                    'minRandomYellowsAdd' => $row["min_random_yellows_add"],
                    'minRandomYellowsMinus' => $row["min_random_yellows_minus"],
                    'minVersionRequired$' => $row["minimum_version_required"],
                    'multipleGreensRequired' => $row["multiple_greens_required"],
                    'noOfMatches' => $noOfMatches,
                    'regularity#' => $row["regularity"],
                    'simulationAverageMinutesLocked' => $row["simulation_average_minutes_locked"],
                    'simulationBestCaseMinutesLocked' => $row["simulation_best_case_minutes_locked"],
                    'simulationWorstCaseMinutesLocked' => $row["simulation_worst_case_minutes_locked"],
                    'version$' => $row["version"]
                ));
            }
            echo json_encode($JSON);
        } else {
            echo "No Matches";
        }
    }
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>