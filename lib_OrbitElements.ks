//lib_OrbitElements.ks

ON round(time:seconds,1) {

	set origin_x to 45.
	set origin_y to 1.
	set offset to 0.
	
	set l_OrbElements to list().
	
	IF SAS {set SAS_Status to "On ".} ELSE {set SAS_Status to "Off".}.
	IF RCS {set RCS_Status to "On ".} ELSE {set RCS_Status to "Off".}.
		
	l_OrbElements:ADD(LIST("Alt  :", round(ship:altitude,0))).
	l_OrbElements:ADD(LIST("Ap   :", round(ship:apoapsis,0),round(ETA:apoapsis,0))).
	l_OrbElements:ADD(LIST("Pe   :", round(ship:periapsis,0),round(ETA:periapsis,0))).
	l_OrbElements:ADD(LIST("Ecc  :", round(ship:obt:eccentricity,4))).
	l_OrbElements:ADD(LIST("Inc  :", round(ship:obt:inclination,1))).
	l_OrbElements:ADD(LIST()).
	l_OrbElements:ADD(LIST("SAS ", SAS_Status)).
	l_OrbElements:ADD(LIST("RCS ", RCS_Status)).
	
	
	until offset = l_OrbElements:length {
					
		IF l_OrbElements[offset]:length = 2 {
			print l_OrbElements[offset][0]+l_OrbElements[offset][1] at(origin_x,origin_y+offset).
		}
		
		IF l_OrbElements[offset]:length = 3 {
			print l_OrbElements[offset][0]+l_OrbElements[offset][1]+" ("+l_OrbElements[offset][2]+")" at(origin_x,origin_y+offset).
		}
		
		set offset to offset + 1.		
	}
	
	return true.
}
