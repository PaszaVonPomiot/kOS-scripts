//lib_angleOrbPlanes
//angleOrbPlanes(body1,body2) - will return angle between orbital planes; orbiters must have the same SOI Body
function angleOrbPlanes {
	parameter orbiter1,orbiter2.
	
	if orbiter1:body <> orbiter2:body {
		print "SOI Body for "+orbiter1:name+" is diffrerent from "+orbiter2:name.
		}
	
	set a1 to sin(orbiter1:obt:inclination)*cos(orbiter1:obt:LAN).
    set a2 to sin(orbiter1:obt:inclination)*sin(orbiter1:obt:LAN).
    set a3 to cos(orbiter1:obt:inclination).

    set b1 to sin(orbiter2:obt:inclination)*cos(orbiter2:obt:LAN).
    set b2 to sin(orbiter2:obt:inclination)*sin(orbiter2:obt:LAN).
    set b3 to cos(orbiter2:obt:inclination).

    set angle to arccos(a1*b1+a2*b2+a3*b3).
	return angle.
}