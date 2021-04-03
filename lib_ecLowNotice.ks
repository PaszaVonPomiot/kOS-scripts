//lib_ecLowNotice.ks
//Print hudtext when low Electric Charge 

function ecLowNotice {
	WHEN ship:electriccharge < 10 THEN {
		HUDTEXT("Electric Charge LOW !", 7, 3, 30, red, false).
	}
}

//LIQUIDFUEL
//OXIDIZER
//ELECTRICCHARGE
//MONOPROPELLANT
//INTAKEAIR
//SOLIDFUEL

//LIST resources IN reslist.
//FOR temp_res IN reslist {
//	IF t_res:tostring:CONTAINS("ElectricCharge") {
//	print "prond"+t_res:amount.
//	}
//}.