<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

$JSON1 = array();
    
// SERVER TIME
array_push($JSON1, array('variable' => 'dateDay', 'value' => date("d")));
array_push($JSON1, array('variable' => 'dateMonth', 'value' => date("m")));
array_push($JSON1, array('variable' => 'dateYear', 'value' => date("Y")));
array_push($JSON1, array('variable' => 'dateHour', 'value' => date("H")));
array_push($JSON1, array('variable' => 'dateMinute', 'value' => date("i")));
array_push($JSON1, array('variable' => 'dateSecond', 'value' => date("s")));
array_push($JSON1, array('variable' => 'timestamp', 'value' => strval(time())));

$JSON2 = json_decode(file_get_contents('servervariables.json'), true);

$JSON = array_merge($JSON1, $JSON2);

echo json_encode($JSON);

?>