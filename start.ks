//Launch Script

// boot only when ship is unpacked on launch pad
wait until ship:unpacked.

// LOAD LIBRARIES //
run once lib_hudStatusUpdate.	//wait 1 sec and add trigger for status change notice
run once lib_ecLowNotice.		//ecLowNotice() - adds one time low electric charge notice
run once lib_vazimuth.			//vazimuth(vessel,vector) - returns compass angle for vector 
run once lib_deltai.			//deltai(target) - returns inclination difference (target-ship)
run once lib_lastEngineStage.	//lastEngineStage() - returns lastStage, lowest stage with engine
run once lib_stagingSequence.	//stagingSequence(lastStage) - adds staging trigger that ends at lastStage
run once lib_navLights.			//navLights("flash") - toggles specified aviation lights
run once lib_countdown.			//countdown(seconds) - countdown timer
run once lib_decoupleRadialSRB. //decoupleRadialSRB()
run once lib_angleOrbPlanes.	//angleOrbPlanes(body1,body2) - will return angle between orbital planes
run once lib_OrbitElements.ks.	//display orbital elements
run once lib_equator.ks.		//equator() - wil display Earth's equator

// SET PARAMETERS //
SET ascend_coefficient to 0.75.		//x^n
SET target_ap to 200*1000.			//km
SET target_pe to target_ap - 0.2*target_ap.
SET target_heading to 90.			//90 - east
SET orbitType to "polar".			//east, equatorial, polar
SET CONFIG:STAT TO false.			//benchmark?
SET v_throttle to 0.
SET waitForWindow to false.			//wait for launch window

// PREFLIGHT //

ecLowNotice().
navLights().
//decoupleRadialSRB().

// MAIN BODY START //


//set initial direction with roll adjustment not to roll at the beginning
SET v_ster TO HEADING(target_heading,90).
//LOCK STEERING TO R(0,0,-90) + v_ster.
LOCK THROTTLE to v_throttle.
LOCK STEERING TO v_ster.


//wait for angleOrbPlanes
 UNTIL NOT waitForWindow {
	print angleOrbPlanes(ship,moon).
	IF angleOrbPlanes(ship,moon) < 1 {
		//check if angleOrbPlanes is getting smaller
		IF angleOrbPlanes(ship,moon) - angleOrbPlanes(ship,moon) > 0 {
			break.
		}
	}
	WAIT 1.
}


//countdown
countdown(3).

//load staging trigger that ends at lastStage
stagingSequence(lastEngineStage()).
set v_throttle to 1.



//achieve apoapsis
UNTIL SHIP:APOAPSIS > target_ap {
	set v_throttle to 1.
	//formula for ascend pitch profile
	SET v_pitch to 90-90*(SHIP:APOAPSIS/target_ap)^ascend_coefficient.
	//print SHIP:APOAPSIS+":"+v_pitch.
	//countersteer if prograde azimuth is off the target,,???? bo ziemie jest kulą!!!
	//set v_azimuth to 180-vazimuth(ship,prograde:vector).
	IF orbitType = "polar" {
		SET v_ster to HEADING(target_heading,v_pitch).
	}
	
	//IF orbitType = "east" {
	//	SET v_ster to
	//}
	
	//print v_pitch AT(50,0).
	wait 0.1.
}




//wait to be close to apoapsis;
print "Shutting down engine".
LOCK THROTTLE TO 0.		//
LOCK STEERING TO v_ster.	//disable roll adjustment
WAIT UNTIL ETA:APOAPSIS <= 60.



//set node and calculate burn duration
set dV to sqrt(BODY:MU/(BODY:RADIUS+APOAPSIS)) - sqrt(BODY:MU*(BODY:RADIUS+PERIAPSIS)/((BODY:RADIUS+APOAPSIS)*(BODY:RADIUS+APOAPSIS+BODY:RADIUS+PERIAPSIS)/2)).
SET nd TO NODE(TIME:SECONDS+ETA:APOAPSIS,0,0,dV).
ADD nd.
print "Node in: " + round(nd:eta) + ", DeltaV: " + round(nd:deltav:mag).
set max_acc to ship:maxthrust/ship:mass.
set burn_duration to nd:deltav:mag/max_acc.
print "Crude Estimated burn duration: " + round(burn_duration) + "s".



//
print "Adjusting ship rotation".
UNTIL nd:ETA <= (burn_duration/3) {
	set v_ster TO HEADING(target_heading,0).
	wait 0.1.
} 


//burn, burn less if eccentricity is small
print "Burning prograde".
WHEN ORBIT:ECCENTRICITY < 1 THEN {LOCK THROTTLE TO 1.
	WHEN ORBIT:ECCENTRICITY < 0.05 THEN {LOCK THROTTLE TO 0.75.
		WHEN ORBIT:ECCENTRICITY < 0.01 THEN {LOCK THROTTLE TO 0.25.
		}
	}
}

//achieve periapsis
UNTIL ORBIT:PERIAPSIS > target_pe {	
	SET v_ster TO PROGRADE.
	wait 0.2.
}


// CLOSURE //

//remove node
REMOVE nd.

//return control to player
LOCK THROTTLE TO 0.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
UNLOCK STEERING.
UNLOCK THROTTLE.

//display summary orbit info
PRINT SHIP:TYPE+" "+SHIP:NAME+" is "+SHIP:STATUS+" "+OBT:BODY:NAME.
PRINT "Ap:"+round(OBT:APOAPSIS/1000,1)+" Pe:"+round(OBT:PERIAPSIS/1000,1)+" Ec:"+round(OBT:ECCENTRICITY,4)+" In:"+round(OBT:INCLINATION,1).



