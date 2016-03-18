/**
 *  MyProjMovMechSetActiveMovement
 *
 *  Creation date: 23.02.2016 23:45
 *  Copyright 2016, Windows7
 */
class MyProjMovMechSetActiveMovement extends SequenceAction;

var int value;
var MyProjMechanismDrivenActor TargetActor;
var() name MechanismName;

event Activated()
{
    local MyProjSelectiveMovementMechanism mech;
    mech=MyProjSelectiveMovementMechanism(TargetActor.GetMechanismByName(MechanismName));
    
    if(mech==none)
        return; // not found / error
       
    mech.SetActiveMovement(value);            
}

defaultproperties
{
    bCallHandler=false
    
    ObjName="Set Active Movement"
    ObjCategory="My Project Mechanisms"
    
    VariableLinks(0)=(ExpectedType=class'SeqVar_Int',LinkDesc="ActiveMovementID",PropertyName=value)
    VariableLinks(1)=(ExpectedType=class'SeqVar_Object',LinkDesc="MyProjMechanismDrivenActor",PropertyName=TargetActor)
}