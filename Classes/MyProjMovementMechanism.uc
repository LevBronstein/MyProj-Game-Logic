/**
 *  MyProjMovementMechanism
 *
 *  Creation date: 21.02.2016 22:53
 *  Copyright 2016, Windows7
 */
class MyProjMovementMechanism extends MyProjActorMechanismBase;

var(Coordinates) bool bUseWorldCoords; //Whether we should move in world coords, or in local coords or in other coord system 
var(Coordinates) Actor CoordSystem; //An actor which is used to define coordinate system

//do we really need this class?
//Yes, we do!

defaultproperties
{
    mechname='MovementDummy'
    
    bUseWorldCoords=true 
    CoordSystem=none
}
