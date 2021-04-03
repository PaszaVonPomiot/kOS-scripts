//Classic Orbital Elements fo Ship

set coe_semimax to obt:semimajoraxis.		//a
set coe_semimix to obt:semiminoraxis.		//b
set coe_eccentricity to obt:eccentricity.	//e
set coe_trueanomaly to obt:trueanomaly		//v in deg.

set coe_c to coe_semimax*coe_eccentricity.	//(F1&F2)/2 - focus points, ogniska;polowa ogniskowej



//inclination tilt of the orbital plane with respect to fundamental plane
//ship inclination - best to visualise angle starting from vector up from planet center(from equatorial plane) to 

//set coe_latitude to.
//set coe_longitude to ship .
//set coe_asl_altitude to ship:altitude.
//set coe_agl_altitude to ship:radar:altitude.
//set coe_heading to.
//set coe_verticalvelocity to.