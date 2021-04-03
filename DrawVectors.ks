//vecdraw(start,vec,color,label,scale,show,width)
VECDRAW(V(0,0,0), ship:facing:forevector*5, red, "forevector", 1, true, 0.2).
VECDRAW(V(0,0,0), ship:facing:topvector*5, blue, "topvector", 1, true, 0.2).
VECDRAW(V(0,0,0), ship:facing:starvector*5, green, "starvector", 1, true, 0.2).

//rotation planes
//VECDRAW(V(0,0,0), ship:facing:forevector*5*R(15,0,0), white, "+X", 1, true, 0.2).
//VECDRAW(V(0,0,0), ship:facing:forevector*5*R(-15,0,0), white, "-X", 1, true, 0.2).
//VECDRAW(V(0,0,0), ship:facing:forevector*5*R(0,15,0), white, "+Y", 1, true, 0.2).
//VECDRAW(V(0,0,0), ship:facing:forevector*5*R(0,-15,0), white, "-Y", 1, true, 0.2).
