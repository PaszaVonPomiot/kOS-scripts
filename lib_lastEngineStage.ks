//lib_lastEngineStage.ks
//lastEngineStage() returns lowest stage number with engine.

function lastEngineStage {
	set les to 1000.
	LIST ENGINES in myEngines.
	for eng in myEngines {
		//print eng:name + ":  " + eng:stage.
		IF eng:stage < les {set les to eng:stage.}
	}

	return les.
}