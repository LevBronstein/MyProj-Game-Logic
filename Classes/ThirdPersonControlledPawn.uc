/**
 *  ThirdPersonControlledPawn
 *
 *  Creation date: 04.07.2015 18:59
 *  Copyright 2015, Win7
 */
class ThirdPersonControlledPawn extends BasicPawn;

var int TP_MovDir; //величина в градусах, желаемое определяющая направление движения
var float TP_MovX; //-1, 0, 1 - против X, нет, по X, устанавливается в реальном времени для упраления
var float TP_MovY; //-1, 0, 1 - против Y, нет, по Y, устанавливается в реальном времени для упраления
var (ThirdPersonPawn) CameraActor TP_ViewCamera; //Current viewing camera, used for moving in view coords [optional]
var (ThirdPersonPawn) const float TP_AccelRate; //Acceleration rate, applied to pawn [25~100]
var (ThirdPersonPawn) const int TP_TurnRate; //Turn speed for smooth rotation [40000~90000]
var (ThirdPersonPawn) bool TP_WorldCoords; //Whether we should move in world coords, or in view coords [true]
var (ThirdPersonPawn) bool TP_LogStats; //Check to show debug stats of this pawn in main game window
var (ThirdPersonPawn) editinline array<MyProjPawnMechanismBase> AllMechanisms; //mechanisms used for this pawn
var Rotator R;

var (PawnMovment) const float TP_WalkPct;
var (PawnMovment) const float TP_CrouchPct;
var (PawnMovment) const float TP_SideStepPct;
var (PawnMovment) const float TP_RunPct;

var float TP_PDefault;
var float TP_PWalking;
var float TP_PCrouching;

var (PawnGabarits) CylinderComponent WalkCyl;
var (PawnGabarits) CylinderComponent CrouchCyl;
var (PawnGabarits) CylinderComponent SideStepCyl;

event PostBeginPlay()
{
    super.PostBeginPlay();
    
    InitMechanisms();
}

function InitMechanisms()
{
    local int i;
    
    //init mechanisms
    for(i=0;i<AllMechanisms.length;i++)
    {
        AllMechanisms[i].parent=self;
    }
}

function TickAllMechanisms(float deltatime)
{
    local int i;
    
    for(i=0;i<AllMechanisms.length;i++)
    {
        AllMechanisms[i].OwnerTick(deltatime);
    }
}

function MyProjPawnMechanismBase GetMechanismByName(name mechname)
{
    local int i;
    
    for(i=0;i<AllMechanisms.length;i++)
    {
        if(AllMechanisms[i].mechname==mechname)
            return AllMechanisms[i];
    }
    return none;
}

event Tick(float deltatime)
{
    TickAllMechanisms(deltatime);
}

function SetMovX(float X)
{
   
}
    
function SetMovY(float Y)
{
   
}     

function SetActiveViewCamera(CameraActor newcam)
{
    
} 
    
defaultproperties
{
    bRunPhysicsWithNoController=true
    
    TP_AccelRate = 30.0f
    TP_TurnRate = 90000
    
    TP_WalkPct = 1.0f
    TP_CrouchPct = 0.5f
    TP_SideStepPct = 0.7f
    TP_RunPct = 2.0f
    
    TP_CylRadius=8.0f
    TP_CylHeight=56.0f
    
    /*Begin Object Class=CylinderComponent Name=CCyl
        CollisionRadius=+0034.000000
        CollisionHeight=+0078.000000
        BlockNonZeroExtent=true
        BlockZeroExtent=true
        BlockActors=true
        CollideActors=true
    End Object
    CrouchCyl=CCyl*/
}
