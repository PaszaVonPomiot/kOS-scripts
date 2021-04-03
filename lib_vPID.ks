//lib_vPID.ks
//vPID(Kp,Ki,Kd,minOutput,maxOutput,SETPOINT) - set velocity


sas on.
WHEN STAGE:LIQUIDFUEL < 0.1 THEN {
    STAGE.
    PRESERVE.
}

function vPID {
	parameter Kp,Ki,Kd,minOutput,maxOutput,setPoint.

	//PID loops have the 3 gains (Kp, Ki, Kd), a setpoint, an input, the input time, and an output. 
	//SET setPoint TO 100.
	//SET minOutput TO 0.01.
	//SET maxOutput TO 1.
	//SET Kp TO 0.1.
	//SET Ki TO 0.006.
	//SET Kd TO 0.006.

	SET PID TO PIDLOOP(Kp, Ki, Kd, minOutput, maxOutput).
	SET PID:SETPOINT TO setPoint.

	SET thrott TO 0.
	LOCK THROTTLE TO thrott.

	UNTIL false {
		//sensor - speed
		set input to ship:velocity:surface:mag.
		//output - throttle
		set output TO PID:UPDATE(TIME:SECONDS, input).
		SET thrott TO output.
		//pid:update() is given the input time and input and returns the output.
		 
		
		print "input:  "+input at(0,0).
		print "output: "+output at(0,1).
		WAIT 0.01.
	}
}

vPID(0.1, 0.006, 0.006, 0.01, 1, 100).