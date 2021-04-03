//boot.ks

//Set volume to 0
switch to 0.

//Notify that kOS is running
HUDTEXT("Booting kOS...", 3, 3, 30, green, false).
wait 3.

//BOOT LIBRARIES
run once lib_config.ks.				//load configs
run once lib_terminal.ks.			//load terminal settings

HUDTEXT("STATUS: "+status, 3, 3, 30, green, false).
CLEARSCREEN.

