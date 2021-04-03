until false {

VECDRAW(V(0,0,0), ship:sensors:acc, green, "acc", 4, 1, 0.2).
VECDRAW(V(0,0,0), ship:sensors:grav, red, "grav", 4, 1, 0.2).
VECDRAW(V(0,0,0), ship:sensors:acc - ship:sensors:grav, blue, "acc-grav", 4, 1, 0.2).
wait 0.5.
CLEARVECDRAWS().

}