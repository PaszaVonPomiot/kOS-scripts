//lib_stagingSequence.ks
//stagingSequence() will stage until lastStage number is reached

function stagingSequence {
	parameter ls.
	
	//for trigger lastStage must be GLOBAL
	GLOBAL lastStage to ls.
	
	WHEN MAXTHRUST = 0 AND STAGE:READY THEN {
			STAGE.
			PRINT "T+"+round(MISSIONTIME,0)+"  Stage "+STAGE:NUMBER.
			//delete trigger if lastStage with engine reached
			IF STAGE:NUMBER > lastStage {RETURN true.}
	}
}
