//lib_decoupleRadialSRB
//decoupleRadialSRB() will decouple radialDecoupler if SRB is empty

function decoupleRadialSRB {
	ON stage:number {
	
		LIST engines IN myEngines.
		FOR eng IN myEngines {
		
			IF stage:number = eng:stage {
				print eng:name+"-->"+eng:parent.
				WHEN eng:resources[0]:amount = 0 THEN {
					IF eng:parent:tostring:contains("radialDecoupler") {
						eng:parent:getmodule("ModuleAnchoredDecoupler"):DOEVENT("decouple").
					}
				}
			}
		}
		
		return true.
	}
}