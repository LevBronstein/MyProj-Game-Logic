/**
 *  TPBlendByAngularSpeed
 *
 *  Creation date: 26.12.2015 04:35
 *  Copyright 2015, Win7
 */
class TPBlendByAngularSpeed extends UDKAnimBlendBase;

var ThirdPersonControlledPawn p;

function UpdateAngularSpeed(float s)
{
    if (p!=none)
    {
        if (s!=0)
        {
            if (s<0)
                SetActiveChild(0, BlendTime);    
            else
                SetActiveChild(2, BlendTime);
        }
        else
        {
            SetActiveChild(1, BlendTime);     
        }
    }
}

event OnBecomeRelevant()
{
    if (ThirdPersonControlledPawn(SkelComponent.Owner) != none)
        p=ThirdPersonControlledPawn(SkelComponent.Owner);
    else
        p=none;
}    

defaultproperties
{
    bCallScriptEventOnBecomeRelevant = true
    
    //bTickAnimInScript=true
    
    Children(0)=(Name="TurningLeft")
    Children(1)=(Name="NotTurning")
    Children(2)=(Name="TurningRight")
    
    BlendTime=0.5
}