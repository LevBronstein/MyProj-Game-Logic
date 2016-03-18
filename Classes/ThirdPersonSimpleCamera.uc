/**
 *  ThirdPersonSimpleCamera
 *
 *  Creation date: 06.07.2015 17:18
 *  Copyright 2015, Win7
 *  Очень странная камера! По оси Yaw глюки!
 */
class ThirdPersonSimpleCamera extends CameraActor
placeable
ClassGroup(MyProj);

enum CameraFollowMode //Camera follow types
{
    CFM_TrackOnly, //Camera tracks the panw, while remaining static
    CFM_PositionOnly, //Camera follows only pawns position, which is added to basic cams offset
    CFM_RelativeTransform, //Camera follows pawns position, rotation, which are added to basic cams offsets
    CFM_OnlyOffset, //Camera follows pawn, copies all its rotations, moves and rotates only around this pawn
};

var (ThirdPersonCamera) Pawn TP_FollowPawn; //A pawn which is being tracked by this cam
var (ThirdPersonCamera) bool TP_bSmoothMove; //Should we smoothly interp of camera movments
var (ThirdPersonCamera) int TP_SmoothInterp; //Set 5~15
var (ThirdPersonCamera) int TP_SmoothInterpCrit; //Set 25~30
var (ThirdPersonCamera) CameraFollowMode TP_CamMode; //Which mode to use

var vector TP_AbsOffset;
var rotator TP_AbsRot;
var rotator TP_BasePawnRot;

var rotator TP_LastPawnRot;

event PostBeginPlay()
{
    super.PostBeginPlay();
    
    TP_AbsOffset=Location-TP_FollowPawn.Location; //запоминаем абсолютный сдвиг
    TP_BasePawnRot=TP_FollowPawn.Rotation; //запоминаем изначальный поворот пауна
    TP_AbsRot.Yaw=atan2(TP_AbsOffset.X, TP_AbsOffset.Y) * RadToUnrRot; //поворот камеры вокруг пауна
    TP_AbsRot.Pitch=0;
    TP_AbsRot.Roll=0;
}

//Камера прикрепляется к пауну, двигается вместе с ним, изменяется только положение
function CalcPositionOnly(float DeltaTime)
{
    local vector TP_DestPos;
    local vector HitLocation, HitNormal;
    local vector loc;
    local Actor HitActor;
    
    TP_DestPos.X=TP_FollowPawn.Location.X + TP_AbsOffset.X;
    TP_DestPos.Y=TP_FollowPawn.Location.Y + TP_AbsOffset.Y;
    TP_DestPos.Z=TP_FollowPawn.Location.Z + TP_AbsOffset.Z;
    
    HitActor = Trace(HitLocation, HitNormal, TP_DestPos, TP_FollowPawn.Location, false);
    
    if (HitActor!=none)
    {
        if (TP_bSmoothMove == false)
            SetLocation(HitLocation);
        else
        {
            loc=VInterpTo(Location, HitLocation, DeltaTime, TP_SmoothInterpCrit);
            SetLocation(loc);
        }
    }
    else
    {
        if (TP_bSmoothMove == false)
            SetLocation(TP_DestPos);
        else
        {
            loc=VInterpTo(Location, TP_DestPos, DeltaTime, TP_SmoothInterp);
            SetLocation(loc);
        }
    }
}

//Камера ведёт себя как камера тпс шутеров
function CalcOnlyOffset(float DeltaTime)
{
    local vector loc;
    local rotator rotr;
    local vector HitLocation, HitNormal;
    local vector TP_DestPos;
    local Actor HitActor;
    
    TP_DestPos.X=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * sin((TP_FollowPawn.Rotation.Yaw) * UnrRotToRad);
    TP_DestPos.Y=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * -cos((TP_FollowPawn.Rotation.Yaw) * UnrRotToRad);
  
    TP_DestPos=TP_DestPos+TP_FollowPawn.Location;

    rotr.Yaw=90 * DegToUnrRot + TP_FollowPawn.Rotation.Yaw;
    rotr.Pitch=TP_FollowPawn.Rotation.Pitch;
    rotr.Roll=TP_FollowPawn.Rotation.Roll;
    
    SetRotation(rotr);
    
    HitActor = Trace(HitLocation, HitNormal, TP_DestPos, TP_FollowPawn.Location, false);
    
    if (HitActor!=none)
    {
        if (TP_bSmoothMove == false)
            SetLocation(HitLocation);
        else
        {
            loc=VInterpTo(Location, HitLocation, DeltaTime, TP_SmoothInterpCrit);
            SetLocation(loc);
        }
    }
    else
    {
        if (TP_bSmoothMove == false)
            SetLocation(TP_DestPos);
        else
        {
            loc=VInterpTo(Location, TP_DestPos, DeltaTime, TP_SmoothInterp);
            SetLocation(loc);
        }
    }
}

//Не пашет никак!!!
function CalcRelativeTransform(float DeltaTime)
{
    local vector TP_DestPos;
    local vector HitLocation, HitNormal;
    local vector loc;
    local rotator rotr;
    local rotator pawnrot, deltarot, curorbit;
    local Actor HitActor;
    
    //curorbit.Yaw=atan2(Location.X-TP_FollowPawn.Location.X, Location.Y-TP_FollowPawn.Location.Y) * RadToUnrRot;

    TP_DestPos.X=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * sin((TP_FollowPawn.Rotation.Yaw + TP_AbsRot.Yaw) * UnrRotToRad);
    TP_DestPos.Y=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * cos((TP_FollowPawn.Rotation.Yaw + TP_AbsRot.Yaw) * UnrRotToRad);
    TP_DestPos.Z=TP_AbsOffset.Z;   
    //TP_DestPos.X=TP_FollowPawn.Location.X + sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * sin((TP_FollowPawn.Rotation.Yaw + TP_AbsRot.Yaw) * UnrRotToRad);
    //TP_DestPos.Y=TP_FollowPawn.Location.Y + sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * cos((TP_FollowPawn.Rotation.Yaw + TP_AbsRot.Yaw) * UnrRotToRad);
    //TP_DestPos.Z=TP_FollowPawn.Location.Z + TP_AbsOffset.Z;
    
    TP_DestPos=TP_DestPos + TP_FollowPawn.Location;
    
    //rotr=Rotation;
    //rotr.Yaw=TP_FollowPawn.Rotation.Yaw + TP_AbsRot.Yaw;
    //SetRotation(rotr);
    
    SetLocation(TP_DestPos);
    
    //rotr=Rotation;
    //rotr.Yaw=atan2(Location.X-TP_FollowPawn.Location.X, Location.Y-TP_FollowPawn.Location.Y) * RadToUnrRot;
    `log(rotr * UnrRotToDeg);
    
    SetRotation(rotr);
    
    HitActor = Trace(HitLocation, HitNormal, TP_DestPos, TP_FollowPawn.Location, false);
    
    //SetLocation(TP_DestPos);

    /*if (HitActor!=none)
    {
        if (TP_bSmoothMove == false)
            SetLocation(HitLocation);
        else
        {
            loc=VInterpTo(Location, HitLocation, DeltaTime, TP_SmoothInterpCrit);
            SetLocation(loc);
        }
    }
    else
    {
        if (TP_bSmoothMove == false)
            SetLocation(TP_DestPos);
        else
        {
            loc=VInterpTo(Location, TP_DestPos, DeltaTime, TP_SmoothInterp);
            SetLocation(loc);
        }
    }*/
}

function CalcTrackOnly(float DeltaTime)
{
    SetRotation(Rotator(TP_FollowPawn.Location-Location));
}

event Tick(float deltatime)
{
    switch (TP_CamMode)
    {
        case CFM_PositionOnly:
            CalcPositionOnly(deltatime);
        break;
        case CFM_OnlyOffset:
            CalcOnlyOffset(deltatime);
        break;
        case CFM_RelativeTransform:
            CalcRelativeTransform(deltatime);
        break;
        case CFM_TrackOnly:
            CalcTrackOnly(deltatime);
        break;
        default:
            CalcPositionOnly(deltatime);
        break;
    }
}

/*
event Tick(float deltatime)
{
    local vector loc;
    local rotator rotr;
    local vector HitLocation, HitNormal;
    local vector TP_DestPos;
    local Actor HitActor;
    
    //TP_DestPos.X=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * sin((TP_FollowPawn.Rotation.Yaw + TP_AbsRot.Yaw) * UnrRotToRad);
    //TP_DestPos.Y=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * -cos((TP_FollowPawn.Rotation.Yaw + TP_AbsRot.Yaw) * UnrRotToRad);
    //TP_DestPos.X=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * sin(atan(TP_AbsOffset.X/TP_AbsOffset.Y) * UnrRotToRad);
    //TP_DestPos.Y=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * -cos(atan(TP_AbsOffset.X/TP_AbsOffset.Y) * UnrRotToRad);
    TP_DestPos.X=TP_FollowPawn.Location.X + TP_AbsOffset.X;
    TP_DestPos.Y=TP_FollowPawn.Location.Y + TP_AbsOffset.Y;
    TP_DestPos.Z=TP_FollowPawn.Location.Z + TP_AbsOffset.Z;
    
    //TP_DestPos=TP_DestPos+TP_FollowPawn.Location;

    rotr.Yaw=90 * DegToUnrRot + TP_FollowPawn.Rotation.Yaw + TP_AbsRot.Yaw;
    rotr.Pitch=TP_FollowPawn.Rotation.Pitch + TP_AbsRot.Pitch;
    rotr.Roll=TP_FollowPawn.Rotation.Roll + TP_AbsRot.Roll;
    
    //SetRotation(rotr);
    
    `log("PawnRot: " @ TP_FollowPawn.Rotation @ " \nMyRot: " @ Rotation);
    
    HitActor = Trace(HitLocation, HitNormal, TP_DestPos, TP_FollowPawn.Location, false);
    
    if (HitActor!=none)
    {
        if (TP_bSmoothMove == false)
            SetLocation(HitLocation);
        else
        {
            loc=VInterpTo(Location, HitLocation, DeltaTime, TP_SmoothInterpCrit);
            SetLocation(loc);
        }
    }
    else
    {
        if (TP_bSmoothMove == false)
            SetLocation(TP_DestPos);
        else
        {
            loc=VInterpTo(Location, TP_DestPos, DeltaTime, TP_SmoothInterp);
            SetLocation(loc);
        }
    }
}
*/

defaultproperties
{

}
