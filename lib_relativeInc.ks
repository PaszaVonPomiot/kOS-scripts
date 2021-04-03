//lib_relativeInc.ks
//relativeInc(body1,body2) - returns relative inclination between two bodies
//eg. relativeInc(ship,moon)

function orbit_normal {
	parameter orbit_in.
	
	//moon:position = RAW?
	return VCRS(orbit_in:body:position - orbit_in:position,
				orbit_in:velocity:orbit):normalized.
}

function swapYZ {
	parameter vec_in.

	return V(vec_in:X, vec_in:Z, vec_in:Y).
}

function swapped_orbit_normal {
	parameter orbit_in.

	return -swapYZ(orbit_normal(orbit_in)).
}

function relativeInc {
	parameter orbiter_a, orbiter_b.

	return abs(vang(swapped_orbit_normal(orbiter_a), swapped_orbit_normal(orbiter_b))).
}


