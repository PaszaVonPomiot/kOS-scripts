//lib_vazimuth.ks
//Provides vazimuth(vessel,vector) function that returns value of compass azimuth in degrees
//Example "print vazimuth(ship,north:vector)." will result in 0 or 360 => both pointing North

function vazimuth {
	parameter input_vessel.	//eg. ship
	parameter input_vector.	// i.e. ship:velocity:surface (for prograde) 
							// or ship:facing:forevector (for facing vector rather  than vel vector).

	// What direction is up, north and east right now, as versor
	set up_versor to input_vessel:up:vector.
	set north_versor to input_vessel:north:vector.
	set east_versor to  vcrs(up_versor, north_versor).
	  
	// east component of vector:
	set east_vel to vdot(input_vector, east_versor). 

	// north component of vector:
	set north_vel to vdot(input_vector, north_versor).

	// inverse trig to take north and east components and make an angle:
	set azimuth to arctan2(east_vel, north_vel).

	// Note, azimuth is now in the range -180 to +180 (i.e. a heading of 270 is
	// expressed as -(90) instead.  This is entirely acceptable mathematically,
	// but if you want a number that looks like the navball azimuth, from 0 to 359.99,
	// you can do this to it:
	if azimuth < 0 {
		set azimuth to azimuth + 360.
	}

	return azimuth.
}

//should test?
set test to false.

until NOT test {
	clearscreen.
	print "Press control-C to quit test program".
	until false {
		print "Compass of srf prograde: " + round( vazimuth(ship, ship:velocity:surface), 1) + " deg " at (0,2).
		print "Compass of orb prograde: " + round( vazimuth(ship, ship:velocity:orbit), 1) + " deg " at (0,3).
		print "Compass of ship facing : " + round( vazimuth(ship, ship:facing:forevector), 1) + " deg " at (0,4).
		wait 0.01.
	}
}
// -------------