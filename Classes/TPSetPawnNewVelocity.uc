/**
 *  TPSetPawnNewVelocity
 *
 *  Creation date: 26.12.2015 00:51
 *  Copyright 2015, Win7
 */
class TPSetPawnNewVelocity extends SequenceAction;

var float velx;
var float vely;
var float velz;
var() bool bSetVelx, bSetVely, bSetVelz; //mask out unwanted variables
var() name mechname; //mechanism in TargetPawn, which is responsible for head rotation
var ThirdPersonControlledPawn TargetPawn;

event Activated()
{
    local TPPawnMovmentMechanism mech;
    mech=TPPawnMovmentMechanism(TargetPawn.GetMechanismByName(mechname));
    
    if(mech==none)
        return; // not found / error
        
    `log("Set vel x,y,z:" @ velx @ vely @ velz);  
    
    mech.SetNewVelocity(velx, vely, velz, bSetVelx, bSetVely, bSetVelz);
}

defaultproperties
{
    bCallHandler=false
    
    ObjName="Set Pawn New Velocity"
    ObjCategory="ThirdPersonGame"
    
    VariableLinks(0)=(ExpectedType=class'SeqVar_Float',LinkDesc="VelX",PropertyName=velx)
    VariableLinks(1)=(ExpectedType=class'SeqVar_Float',LinkDesc="VelY",PropertyName=vely)
    VariableLinks(2)=(ExpectedType=class'SeqVar_Float',LinkDesc="VelZ",PropertyName=velz)
    VariableLinks(3)=(ExpectedType=class'SeqVar_Object',LinkDesc="ThirdPersonControlledPawn",PropertyName=TargetPawn)
}
