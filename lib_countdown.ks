//lib_countdown.ks
//countdown(seconds)

function countdown {
	parameter seconds.
	
	FROM {local n is seconds.} UNTIL n = 0 STEP {set n to n-1.} DO {
	  print "T -" + n+"...".
	  wait 1.
	}
	print "Lift off...".
}