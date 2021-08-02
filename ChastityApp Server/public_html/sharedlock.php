<?php
header("Cache-Control: no-cache, must-revalidate");
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");

$iPod = stripos($_SERVER['HTTP_USER_AGENT'], "iPod");
$iPhone = stripos($_SERVER['HTTP_USER_AGENT'], "iPhone");
$iPad = stripos($_SERVER['HTTP_USER_AGENT'], "iPad");
$Android = stripos($_SERVER['HTTP_USER_AGENT'], "Android");

    include "../includes/app.php";
    include "phpqrcode/qrlib.php";    

    $errorCorrectionLevel = "L";
    $matrixPointSize = 10;
    
    $shareID = trim(str_replace("/sharedlock/", "", $_SERVER['REQUEST_URI']));
    $shareID = preg_replace("/[&|?].*/", "", strtoupper($shareID));
    if ($shareID == "") { die("Not a valid shared lock ID"); }
    if (strlen($shareID) != 15) { die("Not a valid shared lock ID"); }
    if (preg_match("/[^a-zA-Z0-9]+/", $shareID, $matches, 0) == true) { die("Not a valid shared lock ID"); }

    $query1 = $pdo->prepare("select 
            block_users_already_locked,
            build, 
            card_info_hidden, 
            check_in_frequency_in_seconds,
            cumulative, 
            daily, 
            fixed, 
            force_trust, 
            hide_from_owner, 
            key_disabled, 
            late_check_in_window_in_seconds,
            max_auto_resets,
            max_random_copies,
            max_random_double_ups, 
            max_random_freezes, 
            max_random_greens, 
            max_random_minutes,
            max_random_reds, 
            max_random_resets, 
            max_random_stickies,
            max_random_yellows, 
            max_random_yellows_add, 
            max_random_yellows_minus, 
            maximum_copies,
            maximum_users,
            min_random_copies,
            min_random_double_ups,
            min_random_freezes,
            min_random_greens,
            min_random_minutes,
            min_random_reds,
            min_random_resets,
            min_random_stickies,
            min_random_yellows, 
            min_random_yellows_add,
            min_random_yellows_minus,
            min_rating_required,
            minimum_version_required, 
            multiple_greens_required,
            name,
            regularity, 
            require_dm,
            reset_frequency_in_seconds,
            share_id, 
            start_lock_frozen,
            temporarily_disabled,
            timer_hidden,
            user_id,
            version 
        from ShareableLocks_V2 where share_id = :shareID");
    $query1->execute(array('shareID' => $shareID));
    if ($query1->rowCount() == 1) {
        foreach ($query1 as $row1) {
            $minVersionRequired = $row1["minimum_version_required"];
            if ($minVersionRequired == "") { $minVersionRequired = "2.2.0"; }
            $minCopies = 0;
            $maxCopies = 0;
            if ($row1["max_random_copies"] > 0) {
                $minCopies = $row1["min_random_copies"];
                $maxCopies = $row1["max_random_copies"];
            } elseif ($row1["maximum_copies"] > 0) {
                $minCopies = 0;
                $maxCopies = $row1["maximum_copies"];
            }
            $shareID = $row1["share_id"];
            $lockName = $row1["name"];
            if ($lockName == "") { $lockName = $appName." Lock"; }
            $userID = $row1["user_id"];
            if ($row1["hide_from_owner"] == 0) {
                $query2 = $pdo->prepare("select u.id as u_id, u.username as u_username from UserIDs_V2 as u, ShareableLocks_V2 as s where s.share_id = :shareID and s.user_id = u.user_id");
                $query2->execute(array('shareID' => $shareID));
                if ($query2->rowCount() == 1) {
                    foreach ($query2 as $row2) {
                        $keyholderID = $row2["u_id"];
                        $keyholderUsername = $row2["u_username"];
                        if ($keyholderUsername == "") {
                            $keyholderUsername = "CKU".$keyholderID;
                        }
                    }
                }
            } else {
                $keyholderUsername = "";
            }
            $blockUsersAlreadyLocked = $row1["block_users_already_locked"];
            $build = $row1["build"];
            $cardInfoHidden = $row1["card_info_hidden"];
            $checkInFrequencyInSeconds = $row1["check_in_frequency_in_seconds"];
            $cumulative = $row1["cumulative"];
            $daily = $row1["daily"];
            $fixed = $row1["fixed"];
            $forceTrust = $row1["force_trust"];
            $hiddenFromOwner = $row1["hide_from_owner"];
            $keyDisabled = $row1["key_disabled"];
            $lateCheckInWindowInSeconds = $row1["late_check_in_window_in_seconds"];
            $maxAutoResets = $row1["max_auto_resets"];
            $maxDoubleUps = $row1["max_random_double_ups"];
            $maxFreezes = $row1["max_random_freezes"];
            $maxGreens = $row1["max_random_greens"];
            $maxMinutes = $row1["max_random_minutes"];
            $maxReds = $row1["max_random_reds"];
            $maxResets = $row1["max_random_resets"];
            $maxStickies = $row1["max_random_stickies"];
            $maxUsers = $row1["maximum_users"];
            $maxYellows = $row1["max_random_yellows"];
            $maxYellowsAdd = $row1["max_random_yellows_add"];
            $maxYellowsMinus = $row1["max_random_yellows_minus"];
            $minDoubleUps = $row1["min_random_double_ups"];
            $minFreezes = $row1["min_random_freezes"];
            $minGreens = $row1["min_random_greens"];
            $minMinutes = $row1["min_random_minutes"];
            $minRatingRequired = $row1["min_rating_required"];
            $minReds = $row1["min_random_reds"];
            $minResets = $row1["min_random_resets"];
            $minStickies = $row1["min_random_stickies"];
            $minYellows = $row1["min_random_yellows"];
            $minYellowsAdd = $row1["min_random_yellows_add"];
            $minYellowsMinus = $row1["min_random_yellows_minus"];
            $multipleGreensRequired = $row1["multiple_greens_required"];
            $regularity = $row1["regularity"];
            $requireDM = $row1["require_dm"];
            $resetFrequencyInSeconds = $row1["reset_frequency_in_seconds"];
            $startLockFrozen = $row1["start_lock_frozen"];
            $temporarilyDisabled = $row1["temporarily_disabled"];
            $timerHidden = $row1["timer_hidden"];
            $version = $row1["version"];
        }
        
        $patterns = array();
        $patterns[0] = "/\.alpha.*/";
        $patterns[1] = "/\.beta.*/";
        $replacements = array();
        $replacements[0] = "";
        $replacements[1] = "";
        $minVersionRequired = preg_replace($patterns, $replacements, $minVersionRequired);

        $filename = "phpqrcode/temp/".$appName."-Shareable-Lock-".$shareID.".png";
        QRcode::png($appName."-Shareable-Lock-".$shareID, $filename, $errorCorrectionLevel, $matrixPointSize, 2);
        chmod($filename, 0644);

    } else {
        die("Not a valid shared lock ID");
    }

    $query1 = null;
    $query2 = null;
    $pdo = null;
?>
<html lang="en-GB">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>Shared Lock ID <?php echo $shareID; ?></title>
</style>
<link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
<style>
html { 
    background-color: rgb(244, 244, 249);
    font-family: Tahoma, Verdana;
    font-size: 14px;
    text-align: center;
}
.bottom-right {
  position: relative;
  bottom: 18px;
  text-align: right;
  right: 4px;
  color: rgb(192, 57, 42);
}
.qr-container-inner {
  height: 330px;
  width: 330px;
  margin: auto;
}
.qr-container-outer {
  height: 330px;
  width: 100%;
  text-align: center;
}
.lockInfo {
    color: rgb(58, 128, 113);
    font-weight: bold;
}
.openButton {
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
    border-radius: 10px;
    color: #FFFFFF;
    font-family: Verdana;
    font-size: 20px;
    font-weight: 100;
    padding: 10px;
    background-color: #000000;
    text-decoration: none;
    display: inline-block;
    cursor: pointer;
}
.openButton:hover {
    background-color: #222222;
    text-decoration: none;
}
</style>
<body onload="detectOS()">
<h3><?php echo $lockName; ?></h3>
<div class="qr-container-outer">
    <div class="qr-container-inner">
        <img src="<?php echo "../".$filename; ?>"/>
        <div class="bottom-right"><b>Requires V<?php echo $minVersionRequired; ?>+</b></div>
   </div>
</div>
<?php
function ConvertMinutesToText($minutes, $full) {
	$timeText = "";
	$timeUnit = array();
	$timeUnitCounter = 0;
	// Convert minutes to days, hours, and minutes
	$dd = floor($minutes / 60 / 24);
	$hh = ($minutes / 60) % 24;
	$mm = $minutes % 60;
	// Build time string showing the maximum unit
	if ($full == 0) {
	    if ($dd > 0) {
			if ($dd == 1) {
			    return "1 Day";
			} else {
				return $dd." Days";
			}
		} elseif ($hh > 0) {
			if ($hh == 1) {
			    return "1 Hour";
			} else {
				return $hh." Hours";
			}
		} else {
			if ($mm == 1) {
				return "1 Minute";
			} else {
				return $mm." Minutes";
			}
		}
	}
	// Build full time string
	if ($full == 1) {
		if ($dd > 0) {
			$timeUnitCounter = $timeUnitCounter + 1;
			if ($dd == 1) {
				$timeUnit[$timeUnitCounter] = "1 Day";
			} else {
				$timeUnit[$timeUnitCounter] = $dd." Days";
			}
		}
		if ($hh > 0) {
			$timeUnitCounter = $timeUnitCounter + 1;
			if ($hh == 1) {
				$timeUnit[$timeUnitCounter] = "1 Hour";
			} else {
				$timeUnit[$timeUnitCounter] = $hh." Hours";
			}
		}
		if ($mm > 0) {
			$timeUnitCounter = $timeUnitCounter + 1;
			if ($mm == 1) {
				$timeUnit[$timeUnitCounter] = "1 Minute";
			} else {
				$timeUnit[$timeUnitCounter] = $mm." Minutes";
			}
		}
		if ($timeUnitCounter == 1) { return $timeUnit[1]; }
		if ($timeUnitCounter == 2) { return $timeUnit[1].", and ".$timeUnit[2]; }
		if ($timeUnitCounter == 3) { return $timeUnit[1].", ".$timeUnit[2].", and ".$timeUnit[3]; }
	}
}

function ConvertMinutesRangeToText($minMinutes, $maxMinutes) {
	$timeText = "";
	// Convert min and max minutes to days, hours, and minutes
	$minDD = floor($minMinutes / 60 / 24);
	$minHH = ($minMinutes / 60) % 24;
	$minMM = $minMinutes % 60;
	$maxDD = floor($maxMinutes / 60 / 24);
	$maxHH = ($maxMinutes / 60) % 24;
	$maxMM = $maxMinutes % 60;
	// Work out the unit of time for the min and max part of the time, i.e. days, hours, or minutes
	$firstTimeNumber = 0;
	$firstTimeUnit = "";
	$secondTimeNumber = 0;
	$secondTimeUnit = "";
	if ($minDD > 0) {
		$firstTimeNumber = $minDD;
		if ($firstTimeNumber == 1) {
			$firstTimeUnit = " Day";
		} else {
			$firstTimeUnit = " Days";
		}
	} elseif ($minHH > 0) {
		$firstTimeNumber = $minHH;
		if ($firstTimeNumber == 1) {
			$firstTimeUnit = " Hour";
		} else {
			$firstTimeUnit = " Hours";
		}
	} else {
		$firstTimeNumber = $minMM;
		if ($firstTimeNumber == 1) {
			$firstTimeUnit = " Minute";
		} else {
			$firstTimeUnit = " Minutes";
		}
	}
	if ($maxDD > 0) {
		$secondTimeNumber = $maxDD;
		if ($secondTimeNumber == 1) {
			$secondTimeUnit = " Day";
		} else {
			$secondTimeUnit = " Days";
		}
	} elseif ($maxHH > 0) {
		$secondTimeNumber = $maxHH;
		if ($secondTimeNumber == 1) {
			$secondTimeUnit = " Hour";
		} else {
			$secondTimeUnit = " Hours";
		}
	} else {
		$secondTimeNumber = $maxMM;
		if ($secondTimeNumber == 1) {
			$secondTimeUnit = " Minute";
		} else {
			$secondTimeUnit = " Minutes";
		}
	}
	// Build min and max time string
	if ($firstTimeNumber == $secondTimeNumber) {
		if (substr($firstTimeUnit, 0, 2) == substr($secondTimeUnit, 0, 2)) {
			return $firstTimeNumber.$firstTimeUnit;
		} else {
			if ($firstTimeNumber == 0) {
				return $firstTimeNumber." - ".$secondTimeNumber.$secondTimeUnit;
			} else {
				return $firstTimeNumber.$firstTimeUnit." - ".$secondTimeNumber.$secondTimeUnit;
			}
		}
	} else {
		if (substr($firstTimeUnit, 0, 2) == substr($secondTimeUnit, 0, 2)) {
			return $firstTimeNumber." - ".$secondTimeNumber.$secondTimeUnit;
		} else {
			if ($firstTimeNumber == 0) {
				return $firstTimeNumber." - ".$secondTimeNumber.$secondTimeUnit;
			} else {
				return $firstTimeNumber.$firstTimeUnit." - ".$secondTimeNumber.$secondTimeUnit;
			}
		}
	}
}

function ConvertSecondsToText($seconds, $full) {
	$timeText = "";
	$timeUnit = array();
	$timeUnitCounter = 0;
	// Convert minutes to days, hours, and minutes
	$dd = floor($seconds / 60 / 60 / 24);
	$hh = ($seconds / 60 / 60) % 24;
	$mm = ($seconds / 60) % 60;
	// Build time string showing the maximum unit
	if ($full == 0) {
	    if ($dd > 0) {
			if ($dd == 1) {
			    return "1 Day";
			} else {
				return $dd." Days";
			}
		} elseif ($hh > 0) {
			if ($hh == 1) {
			    return "1 Hour";
			} else {
				return $hh." Hours";
			}
		} else {
			if ($mm == 1) {
				return "1 Minute";
			} else {
				return $mm." Minutes";
			}
		}
	}
	// Build full time string
	if ($full == 1) {
		if ($dd > 0) {
			$timeUnitCounter = $timeUnitCounter + 1;
			if ($dd == 1) {
				$timeUnit[$timeUnitCounter] = "1 Day";
			} else {
				$timeUnit[$timeUnitCounter] = $dd." Days";
			}
		}
		if ($hh > 0) {
			$timeUnitCounter = $timeUnitCounter + 1;
			if ($hh == 1) {
				$timeUnit[$timeUnitCounter] = "1 Hour";
			} else {
				$timeUnit[$timeUnitCounter] = $hh." Hours";
			}
		}
		if ($mm > 0) {
			$timeUnitCounter = $timeUnitCounter + 1;
			if ($mm == 1) {
				$timeUnit[$timeUnitCounter] = "1 Minute";
			} else {
				$timeUnit[$timeUnitCounter] = $mm." Minutes";
			}
		}
		if ($timeUnitCounter == 1) { return $timeUnit[1]; }
		if ($timeUnitCounter == 2) { return $timeUnit[1].", and ".$timeUnit[2]; }
		if ($timeUnitCounter == 3) { return $timeUnit[1].", ".$timeUnit[2].", and ".$timeUnit[3]; }
	}
}

if ($keyholderUsername != "") {
    if ($fixed == 0) {
        echo "<h3>Variable lock managed by ".$keyholderUsername."</h3>";
    } else {
        echo "<h3>Fixed lock managed by ".$keyholderUsername."</h3>";
    }
} else {
    if ($fixed == 0) {
        echo "<h3 style='color: red'>Variable lock no longer managed by a keyholder</h3>";
    } else {
        echo "<h3 style='color: red'>Fixed lock no longer managed by a keyholder</h3>";
    }
}
echo "<div class='lockInfo'>";
if ($temporarilyDisabled == 1) {
    if ($hiddenFromOwner == 0) {
        echo "<h2 style='color: red'>TEMPORARILY DISABLED</h2>";
    } else {
        echo "<h2 style='color: red'>LOCK DISABLED</h2>";
    }
}
elseif ($fixed == 0) {
    if ($regularity == 0.016667) { echo "<h2 style='color: red'>TEST LOCK</h2>"; }
    if ($requireDM == 1 && $hiddenFromOwner == 0) { echo "<span style='color: blue'>Message Keyholder Before Loading</span><br/>"; }
    if ($cumulative == 0) {
        if ($regularity == 0.016667) { echo "Chance Every 1 Minute (Non-Cumulative)<br/>"; }
        if ($regularity == 0.25) { echo "Chance Every 15 Minutes (Non-Cumulative)<br/>"; }
        if ($regularity == 0.5) { echo "Chance Every 30 Minutes (Non-Cumulative)<br/>"; }
        if ($regularity == 1) { echo "Chance Every Hour (Non-Cumulative)<br/>"; }
        if ($regularity == 3) { echo "Chance Every 3 Hours (Non-Cumulative)<br/>"; }
        if ($regularity == 6) { echo "Chance Every 6 Hours (Non-Cumulative)<br/>"; }
        if ($regularity == 12) { echo "Chance Every 12 Hours (Non-Cumulative)<br/>"; }
        if ($regularity == 24) { echo "Chance Every Day (Non-Cumulative)<br/>"; }
    }
    if ($cumulative == 1) {
        if ($regularity == 0.016667) { echo "Chance Every 1 Minute (Cumulative)<br/>"; }
        if ($regularity == 0.25) { echo "Chance Every 15 Minutes (Cumulative)<br/>"; }
        if ($regularity == 0.5) { echo "Chance Every 30 Minutes (Cumulative)<br/>"; }
        if ($regularity == 1) { echo "Chance Every Hour (Cumulative)<br/>"; }
        if ($regularity == 3) { echo "Chance Every 3 Hours (Cumulative)<br/>"; }
        if ($regularity == 6) { echo "Chance Every 6 Hours (Cumulative)<br/>"; }
        if ($regularity == 12) { echo "Chance Every 12 Hours (Cumulative)<br/>"; }
        if ($regularity == 24) { echo "Chance Every Day (Cumulative)<br/>"; }
    }
    if ($cardInfoHidden == 0) {
		if ($minGreens == $maxGreens) {
			if ($maxGreens == 1) {
				echo "1 Green Card";
			} else {
    			echo $maxGreens." Green Cards";
			}
		} else {
			echo $minGreens."-".$maxGreens." Green Cards";
		}
		if ($multipleGreensRequired == 0) { echo " (1 Required to Unlock)<br/>"; }
		if ($multipleGreensRequired == 1) { echo " (All Required to Unlock)<br/>"; }
		if ($maxReds > 0) {
			if ($minReds == $maxReds) {
				if ($minReds == 1) {
				    echo "1 Red Card<br/>";
				    /*
					if ($regularity == 0.25) { echo "1 Red Card (Approx. 15 Minutes)<br/>"; }
					if ($regularity == 0.5) { echo "1 Red Card (Approx. 30 Minutes)<br/>"; }
					if ($regularity == 1) { echo "1 Red Card (Approx. 1 Hour)<br/>"; }
					if ($regularity == 3) { echo "1 Red Card (Approx. 3 Hours)<br/>"; }
					if ($regularity == 6) { echo "1 Red Card (Approx. 6 Hours)<br/>"; }
					if ($regularity == 12) { echo "1 Red Card (Approx. 12 Hours)<br/>"; }
					if ($regularity == 24) { echo "1 Red Card (Approx. 1 Day)<br/>"; }
					*/
				} else {
				    echo $maxReds." Red Cards<br/>";
				    /*
				    if ($regularity == 0.25) { echo $maxReds." Red Cards (Approx. ".ConvertMinutesToText($maxReds * 15, 0).")<br/>"; }
					if ($regularity == 0.5) { echo $maxReds." Red Cards (Approx. ".ConvertMinutesToText($maxReds * 30, 0).")<br/>"; }
					if ($regularity == 1) { echo $maxReds." Red Cards (Approx. ".ConvertMinutesToText($maxReds * 60, 0).")<br/>"; }
					if ($regularity == 3) { echo $maxReds." Red Cards (Approx. ".ConvertMinutesToText($maxReds * 180, 0).")<br/>"; }
					if ($regularity == 6) { echo $maxReds." Red Cards (Approx. ".ConvertMinutesToText($maxReds * 360, 0).")<br/>"; }
					if ($regularity == 12) { echo $maxReds." Red Cards (Approx. ".ConvertMinutesToText($maxReds * 720, 0).")<br/>"; }
					if ($regularity == 24) { echo $maxReds." Red Cards (Approx. ".ConvertMinutesToText($maxReds * 1440, 0).")<br/>"; }
					*/
				}
			} else {
			    if ($minReds <= 1) {
			        echo $minReds."-".$maxReds." Red Cards<br/>";
			    } else {
    				if ($regularity == 0.016667) { echo $minReds."-".$maxReds." Red Cards (Min. ".ConvertMinutesToText($minReds * 1, 0).")<br/>"; }
    				if ($regularity == 0.25) { echo $minReds."-".$maxReds." Red Cards (Min. ".ConvertMinutesToText($minReds * 15, 0).")<br/>"; }
    				if ($regularity == 0.5) { echo $minReds."-".$maxReds." Red Cards (Min. ".ConvertMinutesToText($minReds * 30, 0).")<br/>"; }
    				if ($regularity == 1) { echo $minReds."-".$maxReds." Red Cards (Min. ".ConvertMinutesToText($minReds * 60, 0).")<br/>"; }
    				if ($regularity == 3) { echo $minReds."-".$maxReds." Red Cards (Min. ".ConvertMinutesToText($minReds * 180, 0).")<br/>"; }
    				if ($regularity == 6) { echo $minReds."-".$maxReds." Red Cards (Min. ".ConvertMinutesToText($minReds * 360, 0).")<br/>"; }
    				if ($regularity == 12) { echo $minReds."-".$maxReds." Red Cards (Min. ".ConvertMinutesToText($minReds * 720, 0).")<br/>"; }
    				if ($regularity == 24) { echo $minReds."-".$maxReds." Red Cards (Min. ".ConvertMinutesToText($minReds * 1440, 0).")<br/>"; }
			    }
			}
		}
		if ($maxStickies > 0) {
			if ($minStickies == $maxStickies) {
				if ($minStickies == 1) {
					echo "1 Sticky Card<br/>";
				} else {
					echo $minStickies." Sticky Cards<br/>";
				}
			} else {
				echo $minStickies."-".$maxStickies." Sticky Cards<br/>";
			}
		}
		if ($maxYellowsAdd + $maxYellowsMinus + $maxYellows > 0) {
			if ($minYellowsAdd + $minYellowsMinus + $minYellows == $maxYellowsAdd + $maxYellowsMinus + $maxYellows) {
				if ($minYellowsAdd + $minYellowsMinus + $minYellows == 1) {
					echo "1 Yellow Card<br/>";
				} else {
					echo ($maxYellowsAdd + $maxYellowsMinus + $maxYellows)." Yellow Cards<br/>";
				}
			} else {
				echo ($minYellowsAdd + $minYellowsMinus + $minYellows)."-".($maxYellowsAdd + $maxYellowsMinus + $maxYellows)." Yellow Cards<br/>";
			}
		}
		if ($maxFreezes > 0) {
			if ($minFreezes == $maxFreezes) {
				if ($minFreezes == 1) {
					echo "1 Freeze Card<br/>";
				} else {
					echo $minFreezes." Freeze Cards<br/>";
				}
			} else {
				echo $minFreezes."-".$maxFreezes." Freeze Cards<br/>";
			}
		}
		if ($maxDoubleUps > 0) {
			if ($minDoubleUps == $maxDoubleUps) {
				if ($minDoubleUps == 1) {
					echo "1 Double Up Card<br/>";
				} else {
					echo $minDoubleUps." Double Up Cards<br/>";
				}
			} else {
				echo $minDoubleUps."-".$maxDoubleUps." Double Up Cards<br/>";
			}
		}
		if ($maxResets > 0) {
			if ($minResets == $maxResets) {
				if ($minResets == 1) {
					echo "1 Reset Lock Card<br/>";
				} else {
					echo $minResets." Reset Lock Cards<br/>";
				}
			} else {
				echo $minResets."-".$maxResets." Reset Lock Cards<br/>";
			}
		}
    }
    if ($maxAutoResets > 0) {
        if ($cardInfoHidden == 0) {
            echo "Resets Every ".ConvertSecondsToText($resetFrequencyInSeconds, 1)."<br/>Maximum Of ".$maxAutoResets." Auto Resets<br/>";
        } else {
            echo "Auto Resets (Max. ".$maxAutoResets.")<br/>";
        }
    }
    if ($cardInfoHidden == 1) { echo "Card Information Hidden<br/>"; }	
	if ($minCopies > 0) {
	    if ($minCopies == $maxCopies) {
	        if ($maxCopies == 1) {
	            echo "1 Fake Copy Required<br/>";
	        } else {
		        echo $maxCopies." Fake Copies Required<br/>";
	        }
	    } else {
	        echo $minCopies."-".$maxCopies." Fake Copies Required<br/>";
	    }
	} elseif ($maxCopies > 0) {
	    echo "Fake Copies Allowed (Max. ".$maxCopies.")<br/>";
	} else {
		echo "No Fake Copies<br/>";
	}
	if ($maxUsers > 0) {
		if ($maxUsers == 1) {
			echo "Maximum of ".$maxUsers." User at Any One Time<br/>";
		} else {
			echo "Maximum of ".$maxUsers." Users at Any One Time<br/>";
		}
	}
	if ($minRatingRequired > 0) {
		if ($minRatingRequired < 5) {
			echo "Requires a rating of ".$minRatingRequired."+ to load<br/>";
		} else {
			echo "Requires a rating of ".$minRatingRequired." to load<br/>";
		}
	}
	if ($checkInFrequencyInSeconds > 0) {
        echo "Check-Ins Required Every ".ConvertSecondsToText($checkInFrequencyInSeconds, 1)."<br/>";
        if ($lateCheckInWindowInSeconds == 0) {
            echo "Check-Ins Late After ".ConvertSecondsToText($regularity * 3600, 1)."<br/>";
        } else {
            echo "Check-Ins Late After ".ConvertSecondsToText($lateCheckInWindowInSeconds, 1)."<br/>";
        }
    }
	if ($keyDisabled == 1) {
		echo "<span style='color: red'>Emergency Keys Disabled</span><br/>";
	}
	if ($forceTrust == 1 && $hiddenFromOwner == 0) { 
	    echo "<span style='color: red'>Keyholder Limitations Removed</span><br/>"; 
	}
	if ($startLockFrozen == 1 && $hiddenFromOwner == 0) { 
	    echo "<span style='color: red'>Lock Starts Frozen</span><br/>"; 
	}
}
elseif ($fixed == 1) {
    if ($requireDM == 1 && $hiddenFromOwner == 0) { echo "<span style='color: blue'>Message Keyholder Before Loading</span><br/>"; }
    if ($timerHidden == 0) {
        if ($maxMinutes > 0) {
            if ($minMinutes == $maxMinutes) {
                echo ConvertMinutesToText($maxMinutes, 0)."<br/>";
            } else {
                echo ConvertMinutesRangeToText($minMinutes, $maxMinutes)."<br/>";
            }
        } elseif ($maxReds > 0) {
		    if ($minReds == $maxReds) {
    			if ($minReds == 1) {
    				if ($regularity == 0.25) { echo "15 Minutes<br/>"; }
    				if ($regularity == 1) { echo "1 Hour<br/>"; }
    				if ($regularity == 24) { echo "1 Day<br/>"; }
    			} else {
    				if ($regularity == 0.25) { echo ConvertMinutesToText($maxReds * 15, 0)."<br/>"; }
    				if ($regularity == 1) { echo ConvertMinutesToText($maxReds * 60, 0)."<br/>"; }
    				if ($regularity == 24) { echo ConvertMinutesToText($maxReds * 1440, 0)."<br/>"; }
    			}
    		} else {
    			if ($regularity == 0.25) { echo ConvertMinutesRangeToText($minReds * 15, $maxReds * 15)."<br/>"; }
    			if ($regularity == 1) { echo ConvertMinutesRangeToText($minReds * 60, $maxReds * 60)."<br/>"; }
    			if ($regularity == 24) { echo ConvertMinutesRangeToText($minReds * 1440, $maxReds * 1440)."<br/>"; }
    		}
		}
    }
    if ($timerHidden == 1) { 
        echo "Timer Hidden<br/>"; 
    } else {
        echo "Timer Visible<br/>";
    }
    if ($minCopies > 0) {
	    if ($minCopies == $maxCopies) {
	        if ($maxCopies == 1) {
	            echo "1 Fake Copy Required<br/>";
	        } else {
		        echo $maxCopies." Fake Copies Required<br/>";
	        }
	    } else {
	        echo $minCopies."-".$maxCopies." Fake Copies Required<br/>";
	    }
	} elseif ($maxCopies > 0) {
	    echo "Fake Copies Allowed (Max. ".$maxCopies.")<br/>";
	} else {
		echo "No Fake Copies<br/>";
	}
	if ($maxUsers > 0) {
		if ($maxUsers == 1) {
			echo "Maximum of ".$maxUsers." User at Any One Time<br/>";
		} else {
			echo "Maximum of ".$maxUsers." Users at Any One Time<br/>";
		}
	}
	if ($minRatingRequired > 0) {
		if ($minRatingRequired < 5) {
			echo "Requires a rating of ".$minRatingRequired."+ to load<br/>";
		} else {
			echo "Requires a rating of ".$minRatingRequired." to load<br/>";
		}
	}
	if ($checkInFrequencyInSeconds > 0) {
        echo "Check-Ins Required Every ".ConvertSecondsToText($checkInFrequencyInSeconds, 1)."<br/>";
        if ($lateCheckInWindowInSeconds == 0) {
            echo "Check-Ins Late After ".ConvertSecondsToText(min($checkInFrequencyInSeconds / 2, 86400), 1)."<br/>";
        } else {
            echo "Check-Ins Late After ".ConvertSecondsToText($lateCheckInWindowInSeconds, 1)."<br/>";
        }
    }
	if ($keyDisabled == 1) {
		echo "<span style='color: red'>Emergency Keys Disabled</span><br/>";
	}
	if ($forceTrust == 1 && $hiddenFromOwner == 0) { 
	    echo "<span style='color: red'>Keyholder Limitations Removed</span><br/>"; 
	}
	if ($startLockFrozen == 1 && $hiddenFromOwner == 0) { 
	    echo "<span style='color: red'>Lock Starts Frozen</span><br/>"; 
	}
}
echo "<br/></div>";
?>
<?php if ($Android && $temporarilyDisabled == 0) { ?>
<a href="intent://<?php echo $_SERVER['REQUEST_URI']; ?>/#Intent;scheme=<?php echo $appIntentScheme; ?>;package=<?php echo $appPackageName; ?>;end" class="openButton">Open in <?php $appName; ?><small></small></a>
<p id="referenceNote"><small><sup>The 'Open in <?php $appName; ?>' button requires v2.4.2+ of <?php $appName; ?> on this device.<br/>You can also load the lock by scanning the QR code with the <?php $appName; ?> app</sup></small></p>
<?php } elseif (($iPad || $iPhone || $iPod) && $temporarilyDisabled == 0) { ?>
<a href="<?php echo $appIntentScheme; ?>://<?php echo $_SERVER['REQUEST_URI']; ?>/#Intent;scheme=<?php echo $appIntentScheme; ?>;package=<?php echo $appPackageName; ?>;end" class="openButton">Open in <?php $appName; ?><small></small></a>
<p id="referenceNote"><small><sup>The 'Open in <?php $appName; ?>' button requires v2.4.2+ of <?php $appName; ?> on this device.<br/>You can also load the lock by scanning the QR code with the <?php $appName; ?> app</sup></small></p>
<?php } elseif ($temporarilyDisabled == 0) { ?>
<p id="referenceNote"><small><sup>If you open this page on your device where <?php $appName; ?> is installed you should see an 'Open with <?php $appName; ?>' button.<br/>You can also load the lock by scanning the QR code with the <?php $appName; ?> app</sup></small></p>
<?php } ?>
</body>
</html>

