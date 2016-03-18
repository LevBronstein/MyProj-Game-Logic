/**
 *  TPSetPawnMovY
 *
 *  Creation date: 12.07.2015 23:58
 *  Copyright 2015, Win7
 */
class TPSetPawnMovY extends SequenceAction;

var float Value;
var ThirdPersonControlledPawn TargetPawn;

event Activated()
{
    TargetPawn.SetMovY(Value);
}

defaultproperties
{
    bCallHandler=false
    
    ObjName="Set BasicPawn MovY"
    ObjCategory="ThirdPersonGame"
    
    VariableLinks(0)=(ExpectedType=class'SeqVar_Float',LinkDesc="MoveByY",PropertyName=Value)
    VariableLinks(1)=(ExpectedType=class'SeqVar_Object',LinkDesc="ThirdPersonControlledPawn",PropertyName=TargetPawn)
}