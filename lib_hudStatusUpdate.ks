//lib_hudStatusUpdate.ks
//Display HUDTEXT when ship status changes

//first status before trigger
//HUDTEXT("STATUS: "+status, 3, 3, 30, green, false).

//display status message
//ON will will detect change in status and launch trigger
ON status {
	HUDTEXT("STATUS: "+status, 3, 3, 30, green, false).
	return true.
}
