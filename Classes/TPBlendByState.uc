/**
*  TPBlendByState
*
*  Creation date: 28.07.2015 16:08
*  Copyright 2015, Win7
*/
class TPBlendByState extends UDKAnimBlendBase;

var ThirdPersonControlledPawn p;

event TickAnim(FLOAT DeltaSeconds)
{
    if (p!=none)
    {
        switch (P.GetStateName()) 
        { 
            case 'Walking':
                SetActiveChild(1, BlendTime);
            break;
            case 'Running':
                SetActiveChild(2, BlendTime);
            break;
            case 'Crouching':
                SetActiveChild(3, BlendTime);
            break;
            case 'SideStepping':
                SetActiveChild(4, BlendTime);
            break;
            default:
                SetActiveChild(0, BlendTime);
            break; 
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
    
    bTickAnimInScript=true
    
    Children(0)=(Name="Other")
    Children(1)=(Name="Walking")
    Children(2)=(Name="Running")
    Children(3)=(Name="Crouching")
    Children(4)=(Name="Sidesptepping")
    
    BlendTime=0.5
}
