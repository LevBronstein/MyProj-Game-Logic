/**
 *  TPBlendByMovementState
 *
 *  Creation date: 26.12.2015 03:42
 *  Copyright 2015, Win7
 */
class TPBlendByMovementState extends UDKAnimBlendBase;

var ThirdPersonControlledPawn p;
var MovementState curstate;

function UpdateCurrentMoveState(MovementState s)
{
    if (p!=none)
    {
        curstate=s;
        switch (curstate) 
        { 
            case DisableMovement:
                SetActiveChild(0, BlendTime);
            break;
            case GroundMovement:
                SetActiveChild(1, BlendTime);
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
    
    //bTickAnimInScript=true
    
    Children(0)=(Name="Other")
    Children(1)=(Name="GroundMove")
    
    BlendTime=0.5
}