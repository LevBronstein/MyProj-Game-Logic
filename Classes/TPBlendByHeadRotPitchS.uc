/**
 *  TPBlendByHeadRotPitchS
 *
 *  Creation date: 25.12.2015 01:57
 *  Copyright 2015, Win7
 */
class TPBlendByHeadRotPitchS extends AnimNodeBlend;

var() float blendtime; //blend time for animation
var ThirdPersonControlledPawn p;
var float pos; //values form -1 to 1, -1 is down, 1 is up, 0 is middle

function SetPitchRotationValue(float p)
{
    pos=FClamp(p,-1.0,1.0);
    pos=pos/2; // [-0.5,0.5]
    SetBlendTarget(0.5+pos, abs(blendtime));
    
    //`log("weight 0:" @ Children[0].weight @ "weight 1:" @ Children[1].weight);
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
    
    Children(0)=(Name="Down", weight=0.5)
    Children(1)=(Name="Up", weight=0.5)
    
    BlendTime=0.5
}