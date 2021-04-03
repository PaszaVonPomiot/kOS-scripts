//lib_equator.ks
//equator(body) - visualises equator of specified body

function equator {
	parameter eqbody to ship:body.
	
	CLEARVECDRAWS().
	FROM { LOCAL ang is 0.} UNTIL ang >= 360 STEP {set ang to ang + 1.} DO {
		vecdraw(eqbody:position, (eqbody:direction:starvector*eqbody:radius*1.02)*R(0,ang,0) , yellow, "", 1, true, 0.5).
	}
}