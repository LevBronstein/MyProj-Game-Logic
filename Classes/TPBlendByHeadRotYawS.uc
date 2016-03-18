/**
 *  TPBlendByHeadRotYawSmooth
 *
 *  Creation date: 25.12.2015 00:35
 *  Copyright 2015, Win7
 */
class TPBlendByHeadRotYawS extends AnimNodeBlend;

var() float blendtime; //blend time for animation
var ThirdPersonControlledPawn p;
var float pos; //values form -1 to 1, -1 is left, 1 is right, 0 is middle

function SetYawRotationValue(float p)
{
    pos=FClamp(p,-1.0,1.0);
    pos=pos/2; // [-0.5,0.5]
    SetBlendTarget(0.5+pos, abs(blendtime));
    
    // `log("weight 0:" @ Children[0].weight @ "weight 1:" @ Children[1].weight);
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
    
    Children(0)=(Name="Left", weight=0.5)
    Children(1)=(Name="Right", weight=0.5)
    
    BlendTime=0.5
}