<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

$GLOBALS["build"] = 246;
$GLOBALS["maxRandomDoubleUps"] = 0;
$GLOBALS["maxRandomFreezes"] = 0;
$GLOBALS["maxRandomGreens"] = 0;
$GLOBALS["maxRandomReds"] = 0;
$GLOBALS["maxRandomResets"] = 0;
$GLOBALS["maxRandomStickies"] = 0;
$GLOBALS["maxRandomYellows"] = 0;
$GLOBALS["maxRandomYellowsAdd"] = 0;
$GLOBALS["maxRandomYellowsMinus"] = 0;
$GLOBALS["minRandomDoubleUps"] = 0;
$GLOBALS["minRandomFreezes"] = 0;
$GLOBALS["minRandomGreens"] = 0;
$GLOBALS["minRandomReds"] = 0;
$GLOBALS["minRandomResets"] = 0;
$GLOBALS["minRandomStickies"] = 0;
$GLOBALS["minRandomYellows"] = 0;
$GLOBALS["minRandomYellowsAdd"] = 0;
$GLOBALS["minRandomYellowsMinus"] = 0;
$GLOBALS["minVersionRequired"] = "2.3.0";
$GLOBALS["multipleGreensRequired"] = 0;
$GLOBALS["regularity"] = 1;
$GLOBALS["version"] = "2.6.2.alpha.3";
        
$GLOBALS["simulationCount"] = 0;
$GLOBALS["simulationsToTry"] = 100;
    
$GLOBALS["simulationDeck"] = array();

$GLOBALS["simulationInitialDoubleUps"] = 0;
$GLOBALS["simulationInitialFreezes"] = 0;
$GLOBALS["simulationInitialGreens"] = 0;
$GLOBALS["simulationInitialReds"] = 0;
$GLOBALS["simulationInitialResets"] = 0;
$GLOBALS["simulationInitialStickies"] = 0;
$GLOBALS["simulationInitialYellowsAdd1"] = 0;
$GLOBALS["simulationInitialYellowsAdd2"] = 0;
$GLOBALS["simulationInitialYellowsAdd3"] = 0;
$GLOBALS["simulationInitialYellowsMinus1"] = 0;
$GLOBALS["simulationInitialYellowsMinus2"] = 0;
	
$GLOBALS["simulationNoOfDoubleUps"] = 0;
$GLOBALS["simulationNoOfFreezes"] = 0;
$GLOBALS["simulationNoOfGreens"] = 0;
$GLOBALS["simulationNoOfReds"] = 0;
$GLOBALS["simulationNoOfResets"] = 0;
$GLOBALS["simulationNoOfStickies"] = 0;
$GLOBALS["simulationNoOfYellows"] = 0;
$GLOBALS["simulationNoOfYellowsAdd1"] = 0;
$GLOBALS["simulationNoOfYellowsAdd2"] = 0;
$GLOBALS["simulationNoOfYellowsAdd3"] = 0;
$GLOBALS["simulationNoOfYellowsMinus1"] = 0;
$GLOBALS["simulationNoOfYellowsMinus2"] = 0;
	    
$GLOBALS["simulationAverageMinutesLocked"] = 0;
$GLOBALS["simulationAverageNoOfTurns"] = 0;
$GLOBALS["simulationAverageNoOfCardsDrawn"] = 0;
$GLOBALS["simulationAverageNoOfLockResets"] = 0;
$GLOBALS["simulationBestCaseMinutesLocked"] = 9999999999;
$GLOBALS["simulationBestCaseNoOfTurns"] = 9999999999;
$GLOBALS["simulationBestCaseNoOfCardsDrawn"] = 9999999999;
$GLOBALS["simulationBestCaseNoOfLockResets"] = 9999999999;
$GLOBALS["simulationWorstCaseMinutesLocked"] = 0;
$GLOBALS["simulationWorstCaseNoOfTurns"] = 0;
$GLOBALS["simulationWorstCaseNoOfCardsDrawn"] = 0;
$GLOBALS["simulationWorstCaseNoOfLockResets"] = 0;

$GLOBALS["lockInvalid"] = 0;
	
try {
    include "../../includes/app.php";
    
    function AddCardToSimulationDeck($card) {
        if ($card == "DoubleUp") { $GLOBALS["simulationNoOfDoubleUps"]++; }
        elseif ($card == "Freeze") { $GLOBALS["simulationNoOfFreezes"]++; }
        elseif ($card == "Green") { $GLOBALS["simulationNoOfGreens"]++; }
        elseif ($card == "Red") { $GLOBALS["simulationNoOfReds"]++; }
        elseif ($card == "Reset") { $GLOBALS["simulationNoOfResets"]++; }
        elseif ($card == "Sticky") { $GLOBALS["simulationNoOfStickies"]++; }
        elseif ($card == "YellowAdd1") { $GLOBALS["simulationNoOfYellowsAdd1"]++; $GLOBALS["simulationNoOfYellows"]++; }
        elseif ($card == "YellowAdd2") { $GLOBALS["simulationNoOfYellowsAdd2"]++; $GLOBALS["simulationNoOfYellows"]++; }
        elseif ($card == "YellowAdd3") { $GLOBALS["simulationNoOfYellowsAdd3"]++; $GLOBALS["simulationNoOfYellows"]++; }
        elseif ($card == "YellowMinus1") { $GLOBALS["simulationNoOfYellowsMinus1"]++; $GLOBALS["simulationNoOfYellows"]++; }
        elseif ($card == "YellowMinus2") { $GLOBALS["simulationNoOfYellowsMinus2"]++; $GLOBALS["simulationNoOfYellows"]++; }
        array_push($GLOBALS["simulationDeck"], $card);
    }
    
    function CreateSimulationDeck() {
        $GLOBALS["simulationDeck"] = array();
	    $GLOBALS["simulationNoOfDoubleUps"] = 0;
	    $GLOBALS["simulationNoOfFreezes"] = 0;
	    $GLOBALS["simulationNoOfGreens"] = 0;
        $GLOBALS["simulationNoOfReds"] = 0;
	    $GLOBALS["simulationNoOfResets"] = 0;
	    $GLOBALS["simulationNoOfStickies"] = 0;
	    $GLOBALS["simulationNoOfYellows"] = 0;
	    $GLOBALS["simulationNoOfYellowsAdd1"] = 0;
	    $GLOBALS["simulationNoOfYellowsAdd2"] = 0;
	    $GLOBALS["simulationNoOfYellowsAdd3"] = 0;
	    $GLOBALS["simulationNoOfYellowsMinus1"] = 0;
	    $GLOBALS["simulationNoOfYellowsMinus2"] = 0;

        for ($i = 1; $i <= rand($GLOBALS["minRandomDoubleUps"], $GLOBALS["maxRandomDoubleUps"]); $i++) {
	        AddCardToSimulationDeck("DoubleUp");
	    }
	    for ($i = 1; $i <= rand($GLOBALS["minRandomFreezes"], $GLOBALS["maxRandomFreezes"]); $i++) {
		    AddCardToSimulationDeck("Freeze");
	    }
        for ($i = 1; $i <= rand($GLOBALS["minRandomGreens"], $GLOBALS["maxRandomGreens"]); $i++) {
		    AddCardToSimulationDeck("Green");
	    }
        for ($i = 1; $i <= rand($GLOBALS["minRandomReds"], $GLOBALS["maxRandomReds"]); $i++) {
		    AddCardToSimulationDeck("Red");
	    }
	    for ($i = 1; $i <= rand($GLOBALS["minRandomResets"], $GLOBALS["maxRandomResets"]); $i++) {
		    AddCardToSimulationDeck("Reset");
	    }
        for ($i = 1; $i <= rand($GLOBALS["minRandomStickies"], $GLOBALS["maxRandomStickies"]); $i++) {
		    AddCardToSimulationDeck("Sticky");
	    }
        for ($i = 1; $i <= rand($GLOBALS["minRandomYellows"], $GLOBALS["maxRandomYellows"]); $i++) {
            $randYellow = rand(1, 5);
            if ($randYellow == 1) { AddCardToSimulationDeck("YellowAdd1"); }
            if ($randYellow == 2) { AddCardToSimulationDeck("YellowAdd2"); }
            if ($randYellow == 3) { AddCardToSimulationDeck("YellowAdd3"); }
            if ($randYellow == 4) { AddCardToSimulationDeck("YellowMinus1"); }
            if ($randYellow == 5) { AddCardToSimulationDeck("YellowMinus2"); }
	    }
	    for ($i = 1; $i <= rand($GLOBALS["minRandomYellowsAdd"], $GLOBALS["maxRandomYellowsAdd"]); $i++) {
            $randYellow = rand(1, 3);
            if ($randYellow == 1) { AddCardToSimulationDeck("YellowAdd1"); }
            if ($randYellow == 2) { AddCardToSimulationDeck("YellowAdd2"); }
            if ($randYellow == 3) { AddCardToSimulationDeck("YellowAdd3"); }
	    }
        for ($i = 1; $i <= rand($GLOBALS["minRandomYellowsMinus"], $GLOBALS["maxRandomYellowsMinus"]); $i++) {
            $randYellow = rand(1, 2);
            if ($randYellow == 1) { AddCardToSimulationDeck("YellowMinus1"); }
            if ($randYellow == 2) { AddCardToSimulationDeck("YellowMinus2"); }
	    }

	    $GLOBALS["simulationInitialDoubleUps"] = $GLOBALS["simulationNoOfDoubleUps"];
        $GLOBALS["simulationInitialFreezes"] = $GLOBALS["simulationNoOfFreezes"];
        $GLOBALS["simulationInitialGreens"] = $GLOBALS["simulationNoOfGreens"];
        $GLOBALS["simulationInitialReds"] = $GLOBALS["simulationNoOfReds"];
        $GLOBALS["simulationInitialResets"] = $GLOBALS["simulationNoOfResets"];
        $GLOBALS["simulationInitialStickies"] = $GLOBALS["simulationNoOfStickies"];
        $GLOBALS["simulationInitialYellowsAdd1"] = $GLOBALS["simulationNoOfYellowsAdd1"];
        $GLOBALS["simulationInitialYellowsAdd2"] = $GLOBALS["simulationNoOfYellowsAdd2"];
        $GLOBALS["simulationInitialYellowsAdd3"] = $GLOBALS["simulationNoOfYellowsAdd3"];
        $GLOBALS["simulationInitialYellowsMinus1"] = $GLOBALS["simulationNoOfYellowsMinus1"];
        $GLOBALS["simulationInitialYellowsMinus2"] = $GLOBALS["simulationNoOfYellowsMinus2"];
        
        if ($GLOBALS["maxRandomReds"] == 0) {
			$GLOBALS["simulationMinimumRedCards"] = 1;
		} elseif ($GLOBALS["minRandomReds"] == $GLOBALS["maxRandomReds"]) {
			$GLOBALS["simulationMinimumRedCards"] = 1;
		} else {
			$GLOBALS["simulationMinimumRedCards"] = $GLOBALS["minRandomReds"];
        }
    }
    
    function RemoveCardFromSimulationDeck($card) {
        if (($key = array_search($card, $GLOBALS["simulationDeck"])) !== false) {
            if ($card == "DoubleUp") { $GLOBALS["simulationNoOfDoubleUps"]--; }
            if ($card == "Freeze") { $GLOBALS["simulationNoOfFreezes"]--; }
            if ($card == "Green") { $GLOBALS["simulationNoOfGreens"]--; }
            if ($card == "Red") { $GLOBALS["simulationNoOfReds"]--; }
            if ($card == "Reset") { $GLOBALS["simulationNoOfResets"]--; }
            if ($card == "Sticky") { $GLOBALS["simulationNoOfStickies"]--; }
            if ($card == "YellowAdd1") { $GLOBALS["simulationNoOfYellowsAdd1"]--; $GLOBALS["simulationNoOfYellows"]--; }
            if ($card == "YellowAdd2") { $GLOBALS["simulationNoOfYellowsAdd2"]--; $GLOBALS["simulationNoOfYellows"]--; }
            if ($card == "YellowAdd3") { $GLOBALS["simulationNoOfYellowsAdd3"]--; $GLOBALS["simulationNoOfYellows"]--; }
            if ($card == "YellowMinus1") { $GLOBALS["simulationNoOfYellowsMinus1"]--; $GLOBALS["simulationNoOfYellows"]--; }
            if ($card == "YellowMinus2") { $GLOBALS["simulationNoOfYellowsMinus2"]--; $GLOBALS["simulationNoOfYellows"]--; }
            unset($GLOBALS["simulationDeck"][$key]);
        }
    }
    
    function RunSimulation() {
        if ($GLOBALS["simulationCount"] < $GLOBALS["simulationsToTry"]) {
            $GLOBALS["simulationCount"]++;
            $GLOBALS["simulationMinutesLocked"] = 0;
		    $GLOBALS["simulationNoOfTurns"] = 0;
		    $GLOBALS["simulationNoOfCardsDrawn"] = 0;
		    $GLOBALS["simulationNoOfLockResets"] = 0;
		    $GLOBALS["simulationSecondsLocked"] = 0;
		    if ($GLOBALS["simulationCount"] == 1) {
			    $GLOBALS["simulationAverageMinutesLocked"] = 0;
			    $GLOBALS["simulationAverageNoOfTurns"] = 0;
			    $GLOBALS["simulationAverageNoOfCardsDrawn"] = 0;
			    $GLOBALS["simulationAverageNoOfLockResets"] = 0;
			    $GLOBALS["simulationBestCaseMinutesLocked"] = 9999999999;
			    $GLOBALS["simulationBestCaseNoOfTurns"] = 9999999999;
			    $GLOBALS["simulationBestCaseNoOfCardsDrawn"] = 9999999999;
			    $GLOBALS["simulationBestCaseNoOfLockResets"] = 9999999999;
			    $GLOBALS["simulationWorstCaseMinutesLocked"] = 0;
			    $GLOBALS["simulationWorstCaseNoOfTurns"] = 0;
			    $GLOBALS["simulationWorstCaseNoOfCardsDrawn"] = 0;
			    $GLOBALS["simulationWorstCaseNoOfLockResets"] = 0;
            }
            CreateSimulationDeck();
            ShuffleSimulationDeck();
            
            while(count($GLOBALS["simulationDeck"]) > 0) {
                $picked = array_rand($GLOBALS["simulationDeck"], 1);
                
                if ($GLOBALS["simulationDeck"][$picked] == "Green" && $GLOBALS["simulationNoOfTurns"] < $GLOBALS["simulationMinimumRedCards"] && ($GLOBALS["simulationNoOfDoubleUps"] > 0 || $GLOBALS["simulationNoOfFreezes"] > 0 || $GLOBALS["simulationNoOfReds"] > 0 || $GLOBALS["simulationNoOfResets"] > 0 || $GLOBALS["simulationNoOfYellows"] > 0)) {
				    continue;
                }
				
			    if ($GLOBALS["simulationDeck"][$picked] == "DoubleUp") {
    				RemoveCardFromSimulationDeck("DoubleUp");
    				$originalNoOfReds = $GLOBALS["simulationNoOfReds"];
    				for ($i = 1; $i <= $originalNoOfReds; $i++) {
    					if ($GLOBALS["simulationNoOfReds"] < 599) { AddCardToSimulationDeck("Red"); }
    				}
    				$originalNoOfYellowsAdd1 = $GLOBALS["simulationNoOfYellowsAdd1"];
    				for ($i = 1; $i <= $originalNoOfYellowsAdd1; $i++) {
    					if ($GLOBALS["simulationNoOfYellowsAdd1"] < 299) { AddCardToSimulationDeck("YellowAdd1"); }
    				}
    				$originalNoOfYellowsAdd2 = $GLOBALS["simulationNoOfYellowsAdd2"];
    				for ($i = 1; $i <= $originalNoOfYellowsAdd2; $i++) {
    					if ($GLOBALS["simulationNoOfYellowsAdd2"] < 299) { AddCardToSimulationDeck("YellowAdd2"); }
    				}
    				$originalNoOfYellowsAdd3 = $GLOBALS["simulationNoOfYellowsAdd3"];
    				for ($i = 1; $i <= $originalNoOfYellowsAdd3; $i++) {
    					if ($GLOBALS["simulationNoOfYellowsAdd3"] < 299) { AddCardToSimulationDeck("YellowAdd3"); }
    				}
    				$originalNoOfYellowsMinus1 = $GLOBALS["simulationNoOfYellowsMinus1"];
    				for ($i = 1; $i <= $originalNoOfYellowsMinus1; $i++) {
    					if ($GLOBALS["simulationNoOfYellowsMinus1"] < 299) { AddCardToSimulationDeck("YellowMinus1"); }
    				}
    				$originalNoOfYellowsMinus2 = $GLOBALS["simulationNoOfYellowsMinus2"];
    				for ($i = 1; $i <= $originalNoOfYellowsMinus2; $i++) {
    					if ($GLOBALS["simulationNoOfYellowsMinus2"] < 299) { AddCardToSimulationDeck("YellowMinus2"); }
    				}
    				$GLOBALS["simulationAverageNoOfCardsDrawn"]++;
    				$GLOBALS["simulationNoOfCardsDrawn"]++;
    			} elseif ($GLOBALS["simulationDeck"][$picked] == "Freeze") {
    				RemoveCardFromSimulationDeck("Freeze");
    				$minutesFrozen = rand((60 * $GLOBALS["regularity"]) * 2, (60 * $GLOBALS["regularity"]) * 4);
    				$GLOBALS["simulationAverageMinutesLocked"] = $GLOBALS["simulationAverageMinutesLocked"] + $minutesFrozen;
    				$GLOBALS["simulationMinutesLocked"] = $GLOBALS["simulationMinutesLocked"] + $minutesFrozen;
    				$GLOBALS["simulationSecondsLocked"] = $GLOBALS["simulationSecondsLocked"] + ($minutesFrozen * 60);
    				$GLOBALS["simulationAverageNoOfTurns"]++;
    				$GLOBALS["simulationAverageNoOfCardsDrawn"]++;
    				$GLOBALS["simulationNoOfTurns"]++;
    				$GLOBALS["simulationNoOfCardsDrawn"]++;
    			} elseif ($GLOBALS["simulationDeck"][$picked] == "Green") {
    				RemoveCardFromSimulationDeck("Green");
    				$GLOBALS["simulationAverageNoOfCardsDrawn"]++;
    				$GLOBALS["simulationNoOfCardsDrawn"]++;
    				if ($GLOBALS["multipleGreensRequired"] == 0) {
    					$GLOBALS["simulationDeck"] = array();
    					break;
    				} elseif ($GLOBALS["multipleGreensRequired"] == 1 && $GLOBALS["simulationNoOfGreens"] == 0) {
    					$GLOBALS["simulationDeck"] = array();
    					break;
    				}
    			} elseif ($GLOBALS["simulationDeck"][$picked] == "Red") {
    				RemoveCardFromSimulationDeck("Red");
    				$GLOBALS["simulationAverageMinutesLocked"] = $GLOBALS["simulationAverageMinutesLocked"] + (60 * $GLOBALS["regularity"]);
    				$GLOBALS["simulationMinutesLocked"] = $GLOBALS["simulationMinutesLocked"] + (60 * $GLOBALS["regularity"]);
    				$GLOBALS["simulationSecondsLocked"] = $GLOBALS["simulationSecondsLocked"] + ((60 * $GLOBALS["regularity"]) * 60);
    				$GLOBALS["simulationAverageNoOfTurns"]++;
    				$GLOBALS["simulationAverageNoOfCardsDrawn"]++;
    				$GLOBALS["simulationNoOfTurns"]++;
    				$GLOBALS["simulationNoOfCardsDrawn"]++;
    			} elseif ($GLOBALS["simulationDeck"][$picked] == "Reset") {
    				RemoveCardFromSimulationDeck("Reset");
    				$originalNoOfGreens = $GLOBALS["simulationNoOfGreens"];
    				if ($originalNoOfGreens > $GLOBALS["simulationInitialGreens"]) {
    					for ($i = $originalNoOfGreens; $i >= $GLOBALS["simulationInitialGreens"] + 1; $i--) {
    						RemoveCardFromSimulationDeck("Green");
    					}
    				} elseif ($originalNoOfGreens < $GLOBALS["simulationInitialGreens"]) {
    					for ($i = $originalNoOfGreens + 1; $i <= $GLOBALS["simulationInitialGreens"]; $i++) {
    						AddCardToSimulationDeck("Green");
    					}
    				}
    				$originalNoOfReds = $GLOBALS["simulationNoOfReds"];
    				if ($originalNoOfReds > $GLOBALS["simulationInitialReds"]) {
    					for ($i = $originalNoOfReds; $i >= $GLOBALS["simulationInitialReds"] + 1; $i--) {
    						RemoveCardFromSimulationDeck("Red");
    					}
    				
    				} elseif ($originalNoOfReds < $GLOBALS["simulationInitialReds"]) {
    					for ($i = $originalNoOfReds + 1; $i <= $GLOBALS["simulationInitialReds"]; $i++) {
    						AddCardToSimulationDeck("Red");
    					}
    				}
    				$originalNoOfYellowsAdd1 = $GLOBALS["simulationNoOfYellowsAdd1"];
    				if ($originalNoOfYellowsAdd1 > $GLOBALS["simulationInitialYellowsAdd1"]) {
    					for ($i = $originalNoOfYellowsAdd1; $i >= $GLOBALS["simulationInitialYellowsAdd1"] + 1; $i--) {
    						RemoveCardFromSimulationDeck("YellowAdd1");
    					}
    				} elseif ($originalNoOfYellowsAdd1 < $GLOBALS["simulationInitialYellowsAdd1"]) {
    					for ($i = $originalNoOfYellowsAdd1 + 1; $i <= $GLOBALS["simulationInitialYellowsAdd1"]; $i++) {
    						AddCardToSimulationDeck("YellowAdd1");
    					}
    				}
    				$originalNoOfYellowsAdd2 = $GLOBALS["simulationNoOfYellowsAdd2"];
    				if ($originalNoOfYellowsAdd2 > $GLOBALS["simulationInitialYellowsAdd2"]) {
    					for ($i = $originalNoOfYellowsAdd2; $i >= $GLOBALS["simulationInitialYellowsAdd2"] + 1; $i--) {
    						RemoveCardFromSimulationDeck("YellowAdd2");
    					}
    				} elseif ($originalNoOfYellowsAdd2 < $GLOBALS["simulationInitialYellowsAdd2"]) {
    					for ($i = $originalNoOfYellowsAdd2 + 1; $i <= $GLOBALS["simulationInitialYellowsAdd2"]; $i++) {
    						AddCardToSimulationDeck("YellowAdd2");
    					}
    				}
    				$originalNoOfYellowsAdd3 = $GLOBALS["simulationNoOfYellowsAdd3"];
    				if ($originalNoOfYellowsAdd3 > $GLOBALS["simulationInitialYellowsAdd3"]) {
    					for ($i = $originalNoOfYellowsAdd3; $i >= $GLOBALS["simulationInitialYellowsAdd3"] + 1; $i--) {
    						RemoveCardFromSimulationDeck("YellowAdd3");
    					}
    				} elseif ($originalNoOfYellowsAdd3 < $GLOBALS["simulationInitialYellowsAdd3"]) {
    					for ($i = $originalNoOfYellowsAdd3 + 1; $i <= $GLOBALS["simulationInitialYellowsAdd3"]; $i++) {
    						AddCardToSimulationDeck("YellowAdd3");
    					}
    			    }
    				$originalNoOfYellowsMinus1 = $GLOBALS["simulationNoOfYellowsMinus1"];
    				if ($originalNoOfYellowsMinus1 > $GLOBALS["simulationInitialYellowsMinus1"]) {
    					for ($i = $originalNoOfYellowsMinus1; $i >= $GLOBALS["simulationInitialYellowsMinus1"] + 1; $i--) {
    						RemoveCardFromSimulationDeck("YellowMinus1");
    					}
    				} elseif ($originalNoOfYellowsMinus1 < $GLOBALS["simulationInitialYellowsMinus1"]) {
    					for ($i = $originalNoOfYellowsMinus1 + 1; $i <= $GLOBALS["simulationInitialYellowsMinus1"]; $i++) {
    						AddCardToSimulationDeck("YellowMinus1");
    					}
    				}
    				$originalNoOfYellowsMinus2 = $GLOBALS["simulationNoOfYellowsMinus2"];
    				if ($originalNoOfYellowsMinus2 > $GLOBALS["simulationInitialYellowsMinus2"]) {
    					for ($i = $originalNoOfYellowsMinus2; $i >= $GLOBALS["simulationInitialYellowsMinus2"] + 1; $i--) {
    						RemoveCardFromSimulationDeck("YellowMinus2");
    					}
    				} elseif ($originalNoOfYellowsMinus2 < $GLOBALS["simulationInitialYellowsMinus2"]) {
    					for ($i = $originalNoOfYellowsMinus2 + 1; $i <= $GLOBALS["simulationInitialYellowsMinus2"]; $i++) {
    						AddCardToSimulationDeck("YellowMinus2");
    					}
    				}
    				$GLOBALS["simulationAverageNoOfTurns"]++;
    				$GLOBALS["simulationAverageNoOfCardsDrawn"]++;
    				$GLOBALS["simulationAverageNoOfLockResets"]++;
    				$GLOBALS["simulationNoOfTurns"]++;
    				$GLOBALS["simulationNoOfCardsDrawn"]++;
    				$GLOBALS["simulationNoOfLockResets"]++;
    			} elseif ($GLOBALS["simulationDeck"][$picked] == "Sticky") {
    				$GLOBALS["simulationAverageMinutesLocked"] = $GLOBALS["simulationAverageMinutesLocked"] + (60 * $GLOBALS["regularity"]);
    				$GLOBALS["simulationMinutesLocked"] = $GLOBALS["simulationMinutesLocked"] + (60 * $GLOBALS["regularity"]);
    				$GLOBALS["simulationSecondsLocked"] = $GLOBALS["simulationSecondsLocked"] + ((60 * $GLOBALS["regularity"]) * 60);
    				$GLOBALS["simulationAverageNoOfTurns"]++;
    				$GLOBALS["simulationAverageNoOfCardsDrawn"]++;
    				$GLOBALS["simulationNoOfTurns"]++;
    				$GLOBALS["simulationNoOfCardsDrawn"]++;
    			} elseif ($GLOBALS["simulationDeck"][$picked] == "YellowAdd1") {
    				RemoveCardFromSimulationDeck("YellowAdd1");
    				if ($GLOBALS["simulationNoOfReds"] < 599) { AddCardToSimulationDeck("Red"); }
    				$GLOBALS["simulationAverageNoOfCardsDrawn"]++;
    				$GLOBALS["simulationNoOfCardsDrawn"]++;
    			} elseif ($GLOBALS["simulationDeck"][$picked] == "YellowAdd2") {
    				RemoveCardFromSimulationDeck("YellowAdd2");
    				if ($GLOBALS["simulationNoOfReds"] < 599) { AddCardToSimulationDeck("Red"); }
    				if ($GLOBALS["simulationNoOfReds"] < 599) { AddCardToSimulationDeck("Red"); }
    				$GLOBALS["simulationAverageNoOfCardsDrawn"]++;
    				$GLOBALS["simulationNoOfCardsDrawn"]++;
    			} elseif ($GLOBALS["simulationDeck"][$picked] == "YellowAdd3") {
    				RemoveCardFromSimulationDeck("YellowAdd3");
    				if ($GLOBALS["simulationNoOfReds"] < 599) { AddCardToSimulationDeck("Red"); }
    				if ($GLOBALS["simulationNoOfReds"] < 599) { AddCardToSimulationDeck("Red"); }
    				if ($GLOBALS["simulationNoOfReds"] < 599) { AddCardToSimulationDeck("Red"); }
    				$GLOBALS["simulationAverageNoOfCardsDrawn"]++;
    				$GLOBALS["simulationNoOfCardsDrawn"]++;
    			} elseif ($GLOBALS["simulationDeck"][$picked] == "YellowMinus1") {
    				RemoveCardFromSimulationDeck("YellowMinus1");
    				RemoveCardFromSimulationDeck("Red");
    				$GLOBALS["simulationAverageNoOfCardsDrawn"]++;
    				$GLOBALS["simulationNoOfCardsDrawn"]++;
    			} elseif ($GLOBALS["simulationDeck"][$picked] == "YellowMinus2") {
    				RemoveCardFromSimulationDeck("YellowMinus2");
    				RemoveCardFromSimulationDeck("Red");
    				RemoveCardFromSimulationDeck("Red");
    				$GLOBALS["simulationAverageNoOfCardsDrawn"]++;
    				$GLOBALS["simulationNoOfCardsDrawn"]++;
    			}
    			
    			if ($GLOBALS["simulationMinutesLocked"] > 525600) {
    			    $GLOBALS["lockInvalid"] = 1;
    			    break;
    			}
            }
        }
    }
    
    function ShuffleSimulationDeck() {
        shuffle($GLOBALS["simulationDeck"]); 
    }
    
    for ($a = 1; $a <= 10; $a++) {
        for ($b = 1; $b <= 7; $b++) {
            if ($b == 1) { $GLOBALS["regularity"] = 0.25; }
            if ($b == 2) { $GLOBALS["regularity"] = 0.5; }
            if ($b == 3) { $GLOBALS["regularity"] = 1; }
            if ($b == 4) { $GLOBALS["regularity"] = 3; }
            if ($b == 5) { $GLOBALS["regularity"] = 6; }
            if ($b == 6) { $GLOBALS["regularity"] = 12; }
            if ($b == 7) { $GLOBALS["regularity"] = 24; }
            $GLOBALS["maxRandomDoubleUps"] = rand(0, ((30 / 100) * ($a * 10)));
            $GLOBALS["maxRandomFreezes"] = rand(0, ((30 / 100) * ($a * 10)));
            $GLOBALS["maxRandomGreens"] = rand(1, ((30 / 100) * ($a * 10)));
            $GLOBALS["maxRandomReds"] = rand(0, ((399 / 100) * ($a * 10)));
            $GLOBALS["maxRandomResets"] = rand(0, ((30 / 100) * ($a * 10)));
            $GLOBALS["maxRandomStickies"] = rand(0, ((30 / 100) * ($a * 10)));
            $GLOBALS["maxRandomYellows"] = rand(0, ((199 / 100) * ($a * 10)));
            $GLOBALS["maxRandomYellowsAdd"] = rand(0, ((199 / 100) * ($a * 10)));
            $GLOBALS["maxRandomYellowsMinus"] = rand(0, ((199 / 100) * ($a * 10)));
            $GLOBALS["minRandomDoubleUps"] = rand(0, $maxRandomDoubleUps);
            $GLOBALS["minRandomFreezes"] = rand(0, $maxRandomFreezes);
            $GLOBALS["minRandomGreens"] = rand(1, $maxRandomGreens);
            $GLOBALS["minRandomReds"] = rand(0, $maxRandomReds);
            $GLOBALS["minRandomResets"] = rand(0, $maxRandomResets);
            $GLOBALS["minRandomStickies"] = rand(0, $maxRandomStickies);
            $GLOBALS["minRandomYellows"] = rand(0, $maxRandomYellows);
            $GLOBALS["minRandomYellowsAdd"] = rand(0, $maxRandomYellowsAdd);
            $GLOBALS["minRandomYellowsMinus"] = rand(0, $maxRandomYellowsMinus);
            $GLOBALS["multipleGreensRequired"] = rand(0, 1);
            if ($GLOBALS["maxRandomGreens"] == 1) { $GLOBALS["multipleGreensRequired"] = 0; }
            if ($GLOBALS["maxRandomReds"] == 0 && $GLOBALS["maxRandomStickies"] == 0 && $GLOBALS["maxRandomYellowsAdd"] == 0 && $GLOBALS["maxRandomYellows"] == 0 && $GLOBALS["maxRandomFreezes"] == 0) { continue; }
            
            $GLOBALS["simulationCount"] = 0;
            $GLOBALS["lockInvalid"] = 0;
            for ($j = 1; $j <= 100; $j++) {
                RunSimulation();
                if ($GLOBALS["lockInvalid"] == 1) { break; }
                if ($GLOBALS["simulationMinutesLocked"] < $GLOBALS["simulationBestCaseMinutesLocked"]) { $GLOBALS["simulationBestCaseMinutesLocked"] = $GLOBALS["simulationMinutesLocked"]; }
    			if ($GLOBALS["simulationNoOfTurns"] < $GLOBALS["simulationBestCaseNoOfTurns"]) { $GLOBALS["simulationBestCaseNoOfTurns"] = $GLOBALS["simulationNoOfTurns"]; }
    			if ($GLOBALS["simulationNoOfCardsDrawn"] < $GLOBALS["simulationBestCaseNoOfCardsDrawn"]) { $GLOBALS["simulationBestCaseNoOfCardsDrawn"] = $GLOBALS["simulationNoOfCardsDrawn"]; }
    			if ($GLOBALS["simulationNoOfLockResets"] < $GLOBALS["simulationBestCaseNoOfLockResets"]) { $GLOBALS["simulationBestCaseNoOfLockResets"] = $GLOBALS["simulationNoOfLockResets"]; }
    			if ($GLOBALS["simulationMinutesLocked"] > $GLOBALS["simulationWorstCaseMinutesLocked"]) { $GLOBALS["simulationWorstCaseMinutesLocked"] = $GLOBALS["simulationMinutesLocked"]; }
    			if ($GLOBALS["simulationNoOfTurns"] > $GLOBALS["simulationWorstCaseNoOfTurns"]) { $GLOBALS["simulationWorstCaseNoOfTurns"] = $GLOBALS["simulationNoOfTurns"]; }
    			if ($GLOBALS["simulationNoOfCardsDrawn"] > $GLOBALS["simulationWorstCaseNoOfCardsDrawn"]) { $GLOBALS["simulationWorstCaseNoOfCardsDrawn"] = $GLOBALS["simulationNoOfCardsDrawn"]; }
    			if ($GLOBALS["simulationNoOfLockResets"] > $GLOBALS["simulationWorstCaseNoOfLockResets"]) { $GLOBALS["simulationWorstCaseNoOfLockResets"] = $GLOBALS["simulationNoOfLockResets"]; }
            }
            
            if ($GLOBALS["lockInvalid"] == 0) {
                $query = $pdo->prepare("insert into GeneratedLocks (
                    id,
                    build,
                    created,
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
                ) values (
                    '',
                    :build,
                    NOW(),
                    :level,
                    :maxRandomDoubleUps,
                    :maxRandomFreezes,
                    :maxRandomGreens,
                    :maxRandomReds,
                    :maxRandomResets,
                    :maxRandomStickies,
                    :maxRandomYellows,
                    :maxRandomYellowsAdd,
                    :maxRandomYellowsMinus,
                    :minRandomDoubleUps,
                    :minRandomFreezes,
                    :minRandomGreens,
                    :minRandomReds,
                    :minRandomResets,
                    :minRandomStickies,
                    :minRandomYellows,
                    :minRandomYellowsAdd,
                    :minRandomYellowsMinus,
                    :minVersionRequired,
                    :multipleGreensRequired,
                    :regularity,
                    :simulationAverageMinutesLocked,
                    :simulationBestCaseMinutesLocked,
                    :simulationWorstCaseMinutesLocked,
                    :version)");
                $query->execute(array(
                    'build' => $GLOBALS["build"],
                    'level' => $a,
                    'maxRandomDoubleUps' => $GLOBALS["maxRandomDoubleUps"],
                    'maxRandomFreezes' => $GLOBALS["maxRandomFreezes"],
                    'maxRandomGreens' => $GLOBALS["maxRandomGreens"],
                    'maxRandomReds' => $GLOBALS["maxRandomReds"],
                    'maxRandomResets' => $GLOBALS["maxRandomResets"],
                    'maxRandomStickies' => $GLOBALS["maxRandomStickies"],
                    'maxRandomYellows' => $GLOBALS["maxRandomYellows"],
                    'maxRandomYellowsAdd' => $GLOBALS["maxRandomYellowsAdd"],
                    'maxRandomYellowsMinus' => $GLOBALS["maxRandomYellowsMinus"],
                    'minRandomDoubleUps' => $GLOBALS["minRandomDoubleUps"],
                    'minRandomFreezes' => $GLOBALS["minRandomFreezes"],
                    'minRandomGreens' => $GLOBALS["minRandomGreens"],
                    'minRandomReds' => $GLOBALS["minRandomReds"],
                    'minRandomResets' => $GLOBALS["minRandomResets"],
                    'minRandomStickies' => $GLOBALS["minRandomStickies"],
                    'minRandomYellows' => $GLOBALS["minRandomYellows"],
                    'minRandomYellowsAdd' => $GLOBALS["minRandomYellowsAdd"],
                    'minRandomYellowsMinus' => $GLOBALS["minRandomYellowsMinus"],
                    'minVersionRequired' => $GLOBALS["minVersionRequired"],
                    'multipleGreensRequired' => $GLOBALS["multipleGreensRequired"],
                    'regularity' => $GLOBALS["regularity"],
                    'simulationAverageMinutesLocked' => ($GLOBALS["simulationAverageMinutesLocked"] / $GLOBALS["simulationsToTry"]),
                    'simulationBestCaseMinutesLocked' => $GLOBALS["simulationBestCaseMinutesLocked"],
                    'simulationWorstCaseMinutesLocked' => $GLOBALS["simulationWorstCaseMinutesLocked"],
                    'version' => $GLOBALS["version"]));
            }
        }
    }
    
    $query = null;
    $pdo = null;
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>