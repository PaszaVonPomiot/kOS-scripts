CLEARSCREEN.
//Standard Earth Gravity Acceleration
set c_Earth_G0 to (earth:mass*constant:g/earth:radius^2).

//Standard Earth Gravity Acceleration
set g to Earth:MU/Earth:radius^2.

until false {
//Calculate actual thrust
	LIST engines in l_Engines.
	set v_Ft to 0.
	FOR eng IN l_Engines {
		IF eng:IGNITION set v_Ft to v_Ft + eng:THRUST.
	}
	//Thrust force Ft in kN
	print "Ft:"+round(v_Ft,2) at(50,2).
	
//Earth gravitional acceleration with altitude
set v_Earth_Gh to c_Earth_G0*(earth:radius/(earth:radius+ship:altitude))^2.
//Earth gravitional force with altitude
set v_Earth_Fg to ship:mass*v_Earth_Gh.

//Potential acceleration without air drag on Earth
set v_Earth_Ap to (v_Ft-v_Earth_Fg)/ship:mass.
	print "Ap:"+round(v_Earth_Ap,2) at(50,5).
	
//Calculate dV and dT
set T_temp to sessiontime.
set V_temp_vector to SHIP:VELOCITY:SURFACE.
wait 0.1.
set delta_T to sessiontime - T_temp.
set delta_V_vector to SHIP:VELOCITY:SURFACE - V_temp_vector.
set delta_V_vector_mag to delta_V_vector:MAG.

//Real acceleration
//in direction of velocity
set v_Ar to delta_V_vector_mag/delta_T.
print "Ar:"+round(v_Ar,2) at(50,4).

//Airdrag Ad = Ap - Ar
Set v_Earth_Ad to v_Earth_Ap - v_Ar.
print "Ad:"+round(v_Earth_Ad,2) at(50,6).
	
}
