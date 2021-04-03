//lib_navLights.ks
//Enable or disable navigation lights 
//save list all ship parts in tempList variable

function navLights {
	//default parameter
	parameter event is "double flash".
//	set event to "double flash".
	
	LIST parts in tempList.
	SET tempListIterator TO tempList:ITERATOR.

	//set INDEX to -1
	tempListIterator:RESET().

	//NEXT will move to another element and return true if current element is last
	UNTIL NOT tempListIterator:NEXT() {
		
		IF tempListIterator:VALUE:TOSTRING:CONTAINS("lightnav")	{
			//PRINT "Item at position " + tempListIterator:INDEX + " is [" + tempListIterator:VALUE + "].".
			tempListIterator:VALUE:GETMODULE("ModuleNavLight"):DOEVENT(event).
		}
		
	}
}
navLights("flash").