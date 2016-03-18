/**
*  ThirdPersonBlendByWalk
*
*  Creation date: 27.07.2015 20:40
*  Copyright 2015, Win7
*/
class ThirdPersonBlendByWalk extends UDKAnimBlendBase;

var ThirdPersonControlledPawn p;

event TickAnim(FLOAT DeltaSeconds)
{
    
    if (P.GetStateName() == 'Walking')
        SetActiveChild(1, 0.5);
    else
        SetActiveChild(0, 0.5);

}

event OnBecomeRelevant()
{
    if (ThirdPersonControlledPawn(SkelComponent.Owner) != none)
        p=ThirdPersonControlledPawn(SkelComponent.Owner);
}

defaultproperties
{
    bCallScriptEventOnBecomeRelevant = true
    bCallScriptEventOnInit = true
    bCallScriptEventOnCeaseRelevant = true
    
     bTickAnimInScript=true
    
    Children(0)=(Name="Not Walking", Weight=1.0)
    Children(1)=(Name="Walking")
}
