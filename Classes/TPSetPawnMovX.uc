/**
 *  TPSetPawnMovX
 *
 *  Creation date: 12.07.2015 23:54
 *  Copyright 2015, Win7
 */
class TPSetPawnMovX extends SequenceAction;

var float Value;
var ThirdPersonControlledPawn TargetPawn;

event Activated()
{
    TargetPawn.SetMovX(Value);
}

defaultproperties
{
    bCallHandler=false
    
    ObjName="Set BasicPawn MovX"
    ObjCategory="ThirdPersonGame"
    
    VariableLinks(0)=(ExpectedType=class'SeqVar_Float',LinkDesc="MoveByX",PropertyName=Value)
    VariableLinks(1)=(ExpectedType=class'SeqVar_Object',LinkDesc="ThirdPersonControlledPawn",PropertyName=TargetPawn)
}