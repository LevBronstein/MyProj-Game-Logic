/**
 *  TPSetCrouch
 *
 *  Creation date: 27.07.2015 22:20
 *  Copyright 2015, Win7
 */
class TPSetCrouch extends SequenceAction;

var ThirdPersonControlledPawn TargetPawn;

event Activated()
{
    TargetPawn.GoToState('Crouching');
    //TargetPawn.BeginCrouch();
}

defaultproperties
{
    bCallHandler=false
    
    ObjName="Make TPPawn crouch"
    ObjCategory="ThirdPersonGame"
    
    VariableLinks(0)=(ExpectedType=class'SeqVar_Object',LinkDesc="ThirdPersonControlledPawn",PropertyName=TargetPawn)
}
