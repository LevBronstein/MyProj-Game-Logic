/**
 *  ThirdPersonCamera
 *
 *  Creation date: 05.07.2015 14:32
 *  Copyright 2015, Win7
 */
class ThirdPersonCamera extends CameraActor
placeable
ClassGroup(MyProj);

var (ThirdPersonCamera) Pawn TP_FollowPawn; //паун, за которым наблюдает и следует камера
var (ThirdPersonCamera) float TP_InterpSpeed; //степень плавности передвижения камеры [0.5~2]
var (ThirdPersonCamera) float TP_CritInterpSpeed; //плавность передвижения при столкновениями со стенами итд [10~25]
var (ThirdPersonCamera) float TP_TurnSpeed; //степень плавности поворотов [5]
var (ThirdPersonCamera) bool TP_bCanRotate; //может ли данная камера поворачиваться вокруг пауна [true]
var (ThirdPersonCamera) bool TP_bFollowPawn; //следует ли камера за пауном (TP_FollowPawn) [true]
var (ThirdPersonCamera) bool TP_bRotateWithPawn; //повтторяет ли камера повороты пауна [true]
var (ThirdPersonCamera) bool TP_bAdditiveRot; //абсолютный или относительный поворот камеры [true]

var int TP_DesRotYaw,TP_DesRotPitch,TP_DesRotRoll;

var vector TP_AbsOffset;
var rotator TP_AbsRot;
var vector TP_DestPos;
var rotator TP_SummRot;

event PostBeginPlay()
{
    super.PostBeginPlay();
    
    TP_AbsOffset=Location-TP_FollowPawn.Location; //запоминаем абсолютный сдвиг
    TP_AbsRot=Rotation; //запоминаем абсолютный поворот
}

event Tick(float deltatime)
{
    local vector loc, l;
    local rotator rt, resrot;
    local vector HitLocation, HitNormal;
    local Actor HitActor;
    
    if (TP_bFollowPawn == true)
    {
        
        TP_DestPos=TP_FollowPawn.Location+TP_AbsOffset;
        
        if (TP_bCanRotate == true)
        {
            if(TP_bRotateWithPawn == true)
            {
                 l.X=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * -cos(TP_FollowPawn.Rotation.Yaw * UnrRotToRad);
                 l.Y=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * -sin(TP_FollowPawn.Rotation.Yaw * UnrRotToRad);
                 SetRotation(RInterpTo(Rotation, TP_FollowPawn.Rotation, DeltaTime, TP_TurnSpeed , true));
            }
            else
            {
                if(TP_bAdditiveRot == true)
                {
                    TP_SummRot.Yaw+=TP_DesRotYaw * DegToUnrRot; 
                    if (TP_SummRot.Yaw * UnrRotToDeg > 360) 
                        TP_SummRot.Yaw=(TP_SummRot.Yaw * UnrRotToDeg - 360) * DegToUnrRot;
                    if (TP_SummRot.Yaw * UnrRotToDeg < 0) 
                        TP_SummRot.Yaw=(360 - TP_SummRot.Yaw * UnrRotToDeg) * DegToUnrRot;    
                    
                    TP_SummRot.Pitch+=TP_DesRotPitch * DegToUnrRot;
                    if (TP_SummRot.Pitch * UnrRotToDeg > 360) 
                        TP_SummRot.Pitch=(TP_SummRot.Pitch * UnrRotToDeg - 360) * DegToUnrRot;
                    if (TP_SummRot.Pitch * UnrRotToDeg < 0) 
                        TP_SummRot.Pitch=(360 - TP_SummRot.Pitch * UnrRotToDeg) * DegToUnrRot;
                    
                    TP_SummRot.Roll+=TP_DesRotRoll * DegToUnrRot;
                    if (TP_SummRot.Roll * UnrRotToDeg > 360) 
                        TP_SummRot.Roll=(TP_SummRot.Roll * UnrRotToDeg - 360) * DegToUnrRot;
                    if (TP_SummRot.Roll * UnrRotToDeg < 0) 
                        TP_SummRot.Roll=(360 - TP_SummRot.Roll * UnrRotToDeg) * DegToUnrRot;
        
                    l.X=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * -cos(TP_SummRot.Yaw * UnrRotToRad);
                    l.Y=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * -sin(TP_SummRot.Yaw * UnrRotToRad);
                    SetRotation(RInterpTo(Rotation, TP_SummRot, DeltaTime, TP_TurnSpeed , true));
                }
                else
                {
                    rt.Yaw=TP_DesRotYaw * DegToUnrRot;
                    rt.Pitch=TP_DesRotPitch * DegToUnrRot;
                    rt.Roll=TP_DesRotRoll * DegToUnrRot; 
                    l.X=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * -cos(rt.Yaw * UnrRotToRad);
                    l.Y=sqrt(square(TP_AbsOffset.X) + square(TP_AbsOffset.Y)) * -sin(rt.Yaw * UnrRotToRad);
                    SetRotation(RInterpTo(Rotation, rt, DeltaTime, TP_TurnSpeed , true));
                }
            }
           
            TP_DestPos=TP_FollowPawn.Location+l;
        }
       
        HitActor = Trace(HitLocation, HitNormal, TP_DestPos, TP_FollowPawn.Location, false);
        
        if (HitActor!=none)
        {
            loc=VInterpTo(Location, HitLocation, DeltaTime, TP_CritInterpSpeed);
            SetLocation(loc);
        }
        else
        {
            loc=VInterpTo(Location, TP_DestPos, DeltaTime, TP_InterpSpeed);
            SetLocation(loc);
        }
    }
}

defaultproperties
{
    Physics=PHYS_Flying 
    
    /*TP_InterpSpeed=1.0f
    TP_CritInterpSpeed=25.0f
    TP_TurnSpeed=5.0f
    TP_bCanRotate=true;
    TP_bFollowPawn=false;
    TP_bAdditiveRot=false;*/
}
