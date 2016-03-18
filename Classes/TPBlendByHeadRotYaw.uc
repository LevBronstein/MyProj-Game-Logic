/**
 *  TPBlendByHeadRotation
 *
 *  Creation date: 22.12.2015 02:40
 *  Copyright 2015, Win7
 */
class TPBlendByHeadRotYaw extends UDKAnimBlendBase;

var() name mechname;
var ThirdPersonControlledPawn p;

event TickAnim(float DeltaSeconds)
{
    local TPPawnHeadRotateMechanism mech;
    local float pos;
    
    mech=TPPawnHeadRotateMechanism(p.GetMechanismByName(mechname));

    if(mech==none)
        return; // not found / error
  
   pos=(mech.currotation.Yaw * UnrRotToDeg)/(mech.MaxRotationAngle - mech.MinRotationAngle);
   //pos=clamp(pos,-1,1);
   `log("pos:" @ pos);
   
   if(pos < -0.2)
        SetActiveChild(0, BlendTime);
   if(pos >=-0.2 && pos < 0.2)
        SetActiveChild(1, BlendTime);     
   if(pos >= 0.2)
        SetActiveChild(2, BlendTime);     
   
   //if (mech.currotation.Yaw * UnrRotToDeg < 0)// (Abs(mech.MaxRotationAngle) + Abs(mech.MinRotationAngle)) /2)
   //     SetActiveChild(0, BlendTime);
   //else
   //   SetActiveChild(1, BlendTime);
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
    
    Children(0)=(Name="Left")
    Children(1)=(Name="Middle")
    Children(2)=(Name="Right")
    
    BlendTime=0.5
}