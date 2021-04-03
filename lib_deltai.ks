//lib_deltai.ks
//Returns inclination difference between ship and target_body
//Ship and target must be under the same SOI body
//deltai(target_body), eg. deltai(moon)

function deltai {
parameter target.

set tb to target:body.
set sb to ship:body.
set ti to target:obt:inclination.
set si to ship:obt:inclination.
	
	if tb = sb {
		return ti - si.
	}
	else {
		print "Ship SOI:"+sb+ " Target SOI:"+tb.
	}
}