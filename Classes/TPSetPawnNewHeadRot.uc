/**
 *  TPSetPawnNewHeadRot
 *
 *  Creation date: 22.12.2015 02:05
 *  Copyright 2015, Win7
 */
class TPSetPawnNewHeadRot extends SequenceAction;

var float yaw, pitch, roll;
var() bool bSetYaw, bSetPitch, bSetRoll; //mask out unwanted variables
var() name mechname; //mechanism in TargetPawn, which is responsible for head rotation
var ThirdPersonControlledPawn TargetPawn;

event Activated()
{
    local TPPawnHeadRotateMechanism mech;
    mech=TPPawnHeadRotateMechanism(TargetPawn.GetMechanismByName(mechname));
    
    if(mech==none)
        return; // not found / error
        
    //`log("Set y,p,r:" @ yaw @ pitch @ roll);    
    mech.SetNewRotation(yaw, pitch, roll, bSetYaw, bSetPitch, bSetRoll); //ссылка или сам объект?!
}

defaultproperties
{
    bCallHandler=false
    
    ObjName="Set Pawn New Head Rotation"
    ObjCategory="ThirdPersonGame"
    
    VariableLinks(0)=(ExpectedType=class'SeqVar_Float',LinkDesc="Yaw",PropertyName=yaw)
    VariableLinks(1)=(ExpectedType=class'SeqVar_Float',LinkDesc="Pitch",PropertyName=pitch)
    VariableLinks(2)=(ExpectedType=class'SeqVar_Float',LinkDesc="Roll",PropertyName=roll)
    VariableLinks(3)=(ExpectedType=class'SeqVar_Object',LinkDesc="ThirdPersonControlledPawn",PropertyName=TargetPawn)