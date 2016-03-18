/**
 *  TPPawnHeadRotateMechanism
 *
 *  Rotating pawn's head in Yaw Pitch Roll, blending thorugh animtree; Has a bug when rotating on angle >90
 *  Creation date: 22.12.2015 00:28
 *  Copyright 2015, Win7
 */
class TPPawnHeadRotateMechanism extends MyProjPawnMechanismBase;

var() const float MaxRotationAngle; //max availiable angle of rotation 
var() const float MinRotationAngle; //min availiable angle of rotation 
var() const float RotationSpeed; //rotation speed
var() const name animnodenameY; //which animnode is used in the animtree for yaw rotation
var() const name animnodenameP; //which animnode is used in the animtree for pitch rotation

var rotator currotation; //current rotation
var rotator desiredrotation; //desired rotation

var TPBlendByHeadRotYawS curnodeY;
var TPBlendByHeadRotPitchS curnodeP;


function FirstTickInit()
{
    super.FirstTickInit();
    
    curnodeY=TPBlendByHeadRotYawS(parent.Mesh.FindAnimNode(animnodenameY));
    curnodeP=TPBlendByHeadRotPitchS(parent.Mesh.FindAnimNode(animnodenameP));
    //`log("*****************" @ mechname @ self @ "anim node Y:" @ curnodeY);
    //`log("*****************" @ mechname @ self @ "anim node P:" @ curnodeP);
}
 

function RotateYaw()
{
    local float pos;
    
    if (curnodeY == none)
        return;
    pos=(currotation.Yaw * UnrRotToDeg)/(MaxRotationAngle - MinRotationAngle);
    curnodeY.SetYawRotationValue(pos); 
}

function RotatePitch()
{
    local float pos;
    
    if (curnodeP == none)
        return;
    pos=(currotation.Pitch * UnrRotToDeg)/(MaxRotationAngle - MinRotationAngle);
    curnodeP.SetPitchRotationValue(pos); 
}

event OwnerTick(float deltatime)
{
    if (bfirsttick==true)
        FirstTickInit();
    //`log(mechname @ self @ "parent:" @ parent @ "\n" @ "Rotation:" @ currotation @ "/" @ desiredrotation @ "Node:" @ curnodeY);
   
    currotation=RInterpTo(currotation, desiredrotation, deltatime, RotationSpeed, true); 
    
    RotateYaw();
    RotatePitch();
    
    //`log(currotation * UnrRotToDeg @ "/" @ desiredrotation * UnrRotToDeg);
}

function SetNewRotation(float yaw, float pitch, float roll, optional bool bSetYaw=true, optional bool bSetPitch=true, optional bool bSetRoll=true)
{
    local float tyaw, tpitch, troll;
    
    tyaw=FClamp(yaw,MinRotationAngle,MaxRotationAngle);
    tpitch=FClamp(pitch,MinRotationAngle,MaxRotationAngle);
    troll=FClamp(roll,MinRotationAngle,MaxRotationAngle);
    
    if(bSetYaw==true) desiredrotation.yaw=tyaw * DegToUnrRot;
    if(bSetPitch==true) desiredrotation.pitch=tpitch * DegToUnrRot;    
    if(bSetRoll==true) desiredrotation.roll=troll * DegToUnrRot;        
}

defaultproperties
{
    MaxRotationAngle=75.0
    MinRotationAngle=-75.0
    RotationSpeed=9000.0
    
    currotation=(X=0.0,Y=0.0,Z=0.0)
    desiredrotation=(X=0.0,Y=0.0,Z=0.0)
    
    animnodenameY="blendheadrotationY"
    animnodenameP="blendheadrotationP"
}
