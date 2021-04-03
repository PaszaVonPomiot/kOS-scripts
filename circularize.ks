//Circularise orbit on apoapsis
SET v_throttle TO 0.
LOCK THROTTLE TO v_throttle.
set isDone to false.

//WAIT UNTIL ETA:APOAPSIS < 60.

//print ap and pe altitude
print "T+" + round(missiontime) + " Apoapsis: " + round(orbit:apoapsis/1000,2) + "km, Periapsis: " + round(orbit:periapsis/1000,2) + "km".

//Calculate required dV to circularize on apoapsis
set dV to sqrt(BODY:MU/(BODY:RADIUS+APOAPSIS)) - sqrt(BODY:MU*(BODY:RADIUS+PERIAPSIS)/((BODY:RADIUS+APOAPSIS)*(BODY:RADIUS+APOAPSIS+BODY:RADIUS+PERIAPSIS)/2)).

//eta time needs to be added to actual game time
SET nd TO NODE(TIME:SECONDS+ETA:APOAPSIS,0,0,0).
SET nd:prograde to dV.
ADD nd.

//Calculate approximate burn duration; should be rocket equation
SET max_acc TO ship:maxthrust/ship:mass.
SET burn_duration to nd:DELTAV:MAG/max_acc.



//align with delta-v vector
LOCK STEERING TO v_steering.
set v_steering to nd:DELTAV.

WAIT UNTIL burn_duration/2 > nd:ETA.

WHEN nd:DELTAV:MAG < 1000 THEN {
	SET v_throttle to 1.
	WHEN nd:DELTAV:MAG < 200 THEN {
		SET v_throttle to 0.5.
		WHEN nd:DELTAV:MAG < 50 THEN {
			SET v_throttle to 0.1.
			WHEN nd:DELTAV:MAG < 2 THEN {
				SET v_throttle to 0.
				SET isDone to true.
			}
		}
	}
}

UNTIL isDone {
	set v_steering to nd:DELTAV.
	wait 0.1.
}




//COMPLETE
//Ap and pe after circularization
print "T+" + round(missiontime) + " Apoapsis: " + round(orbit:apoapsis/1000,2) + "km, Periapsis: " + round(orbit:periapsis/1000,2) + "km".
REMOVE nd.

//return control to player
LOCK THROTTLE TO 0.
UNLOCK THROTTLE.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
UNLOCK STEERING.