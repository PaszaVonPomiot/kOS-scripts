// VARIABLES and CONSTANS

//Standard Earth Gravity Acceleration
set c_Earth_G0 to (earth:mass*constant:g/earth:radius^2).

//Earth gravity acceleration with altitude
set v_Earth_Gh to c_Earth_G0*(earth:radius/(earth:radius+ship:altitude))^2.

//Earth gravitional force
set v_Earth_Fg to ship:mass*v_Earth_Gh.

//Earth atmospheric drag
//set v_Earth_Fd to



set v_checkspeed to 0.005.			//what speed is considered stable
set v_countdown to 5.				//seconds to launch
set v_throttle to 1.0.				//dynamic throttle
set v_steering to up+r(0,0,0).		//up as a reference adjusted by rotation
									//r(pitch,yaw,roll)
//set v_steering to heading(90,90)	//(east,up)								
set v_ReqEarthApo to 80000.     	//required earth apoapsis
set v_CurrThrust to 0.				//Store info about current thrust


  SET ASCENT_PROFILE TO LIST(
    // Altitude,  Angle,
    0,            85,     
    2500,         80,     
    10000,        75,     
    15000,        70,     
    20000,        65,     
    25000,        60,     
    32000,        50,     
    45000,        35,     
    50000,        25,     
    60000,        0,      
    70000,        0,      
    72000,        0      
  ).

/////////////////////////////////////////////////////////////////////////////////

CLEARSCREEN.

// PRELAUNCH SEQUENCE
print "Ship stability check...".

// wait if ship is moving
until SHIP:VELOCITY:SURFACE:MAG < v_checkspeed {
	print "Velocity magnitude: "+SHIP:VELOCITY:SURFACE:MAG.
	wait 0.5.
}

print "Ship stable".

//Setting flying triggers
LOCK THROTTLE TO v_throttle.
LOCK STEERING TO v_steering.


// COUNTDOWN
print "Countdown initiated:".
FROM {local n is v_countdown.} UNTIL n = 0 STEP {set n to n-1.} DO {
  print "T -" + n.
  wait 1.
}

// multitrigger: stage when there is no thrust
WHEN MAXTHRUST = 0 THEN {
    PRINT "Staging".
    STAGE.
    PRESERVE.
}.

//Turn
WHEN SHIP:VELOCITY:SURFACE:MAG > 100 THEN {
	set v_steering to heading(90,85).
}


//loop until you reach achieve apoapsis
UNTIL SHIP:APOAPSIS > v_ReqEarthApo {
wait 0.1.
print "Ap: "+round(ship:apoapsis) at(60,0).
}
print "Apo reached".

SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
UNLOCK STEERING.
UNLOCK THROTTLE.
//SHUTDOWN.


//////////////////////////////
//////////////////////////////

//sum thrust (kN) of all active thrusters
