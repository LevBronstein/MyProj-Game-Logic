/**
 *  TPPawnMovmentMechanism
 *
 *  Creation date: 26.12.2015 00:26
 *  Copyright 2015, Win7
 */
class TPPawnMovmentMechanism extends MyProjPawnMechanismBase;

enum MovementState
{
    DisableMovement,
    GroundMovement,
};

var MovementState PawnMovementState; //state of movement
var int TP_MovDir; //величина в градусах, желаемое определяющая направление движения
var float TP_MovX; //-1, 0, 1 - против X, нет, по X, устанавливается в реальном времени для упраления
var float TP_MovY; //-1, 0, 1 - против Y, нет, по Y, устанавливается в реальном времени для упраления
var vector Velocity; //actural velocity which is being modified
var rotator Rotation; //actual rotation which is being modified
var Rotator R;
var Vector V;
var rotator lastrot;
var float angspeed; //angular speed while rotating the pawn by Yaw
var(Coordinates) bool bUseWorldCoords; //Whether we should move in world coords, or in local coords or in other coord system 
var(Coordinates) Actor CoordSystem; //An actor to use to define coord system
var() const float BaseSpeed; //Basic speed of the pawn
var() const float TP_AccelRate; //Acceleration rate, applied to the pawn [25~100]
var() const int TP_TurnRate; //Turn speed for smooth rotation [40000~90000]

var(MovePercentage) const float TP_WalkPct;
var(MovePercentage) const float TP_CrouchPct;
var(MovePercentage) const float TP_SideStepPct;
var(MovePercentage) const float TP_RunPct;

var(SpeedRestraints) const float GroundSpeed;

var TPBlendByMovementState blendbymove; //animnode blending by move in the animtree
var() name blendbymovename;
var TPBlendByAngularSpeed blendbyangspeed; //animnode blending by angspeed in the animtree
var() name blendbyangspeedname;

/************************supportive functions*************************/
function SetMovX(float X)
{
    if (X == 0)
        TP_MovX=0;
    else
        TP_MovX=Abs(X)/X;
}
    
function SetMovY(float Y)
{
   if (Y == 0)
        TP_MovY=0;
    else
        TP_MovY=Abs(Y)/Y; 
}     

//read input values and return direction in degrees
function int GetAngleByInput(int X, int Y)
{
    local int MovDir;
    
    if (TP_MovX == 0.0f)    
    {
        if (TP_MovY == 1.0f) 
            MovDir=0;

        if (TP_MovY == -1.0f) 
            MovDir=180;
    }
        
    if (TP_MovX == 1.0f)    
    {
        if (TP_MovY == -1.0f) 
            MovDir=225; //-135
    }    
        
    if (TP_MovX == -1.0f)
    {
        if (TP_MovY == -1.0f) 
            MovDir=135;
    }    
        
    if (TP_MovY == 0.0f)    
    {
        if (TP_MovX == 1.0f) 
            MovDir=270; //90 и 270 поменялись местами, т.к. анрилыч походу поехал (-90)

        if (TP_MovX == -1.0f) 
            MovDir=90;
    }    
        
    if (TP_MovY == 1.0f)    
    {
        if (TP_MovX == 1.0f) 
            MovDir=315; //-45

        if (TP_MovX == -1.0f) 
            MovDir=45;
    }     

    return MovDir;
}

//a function which is called from outside (e.g. from kismet via TPSetPawnNewVelocity)      
function SetNewVelocity(float newvelx, float newvely, float newvelz, optional bool bsetvelx=false, optional bool bsetvely=false, optional bool bsetvelz=false)
{
    if(bsetvelx == true)
    {
        SetMovX(newvelx);
    }
    if(bsetvely == true)
    {
        SetMovY(newvely);
    }
}
 
function FirstTickInit()
{
    super.FirstTickInit();
    
    blendbymove=TPBlendByMovementState(parent.Mesh.FindAnimNode(blendbymovename));
    blendbyangspeed=TPBlendByAngularSpeed(parent.Mesh.FindAnimNode(blendbyangspeedname));
    //`log(blendbyangspeed);
}

function UpdateAnimNode()
{
    if (blendbymove != none)
        blendbymove.UpdateCurrentMoveState(PawnMovementState);
    if (blendbyangspeed != none)    
        blendbyangspeed.UpdateAngularSpeed(angspeed);
}

event OwnerTick(float deltatime)
{
    if (bfirsttick==true)
        FirstTickInit();
    
    //`log(PawnMovementState);
    CheckState();
    
    CalcRotation();
    
    switch(PawnMovementState)
    {
        case DisableMovement:
        break;
        case GroundMovement:
            PerformGroundMove(deltatime);
        break;
    }
}

function CalcRotation()
{
    angspeed=lastrot.yaw * UnrRotToDeg - parent.rotation.yaw * UnrRotToDeg;
    if(abs(angspeed) <= 1.5)
        angspeed=0;
    lastrot=parent.rotation;  
    //`log(angspeed);
}

function CheckState()
{
    PawnMovementState=GroundMovement;
    UpdateAnimNode();
}

function ChangeMoveState(float deltatime)
{
    
}

/************************Ground Move*************************/
function PerformGroundMove(float deltatime)
{
    local rotator RT;
    local vector MT;
    local rotator camrot;

    R.Pitch=0;
    R.Roll=0;
    RT.Pitch=0;
    RT.Roll=0;
    
    if (TP_MovX != 0.0f || TP_MovY != 0.0f) //направление не задано
    {
       
        TP_MovDir = GetAngleByInput(TP_MovX, TP_MovY);
        
        //`log("X:"@TP_MovX@"Y:"@TP_MovY@"Dir:"@TP_MovDir);
       
        if(CoordSystem == none)
        {
            CoordSystem=parent; //if there's no availiable actor to use as a coord system, use the pawn
        }

        if (abs(TP_MovX) + abs(TP_MovY) >= 2)
        {
            MT.X=BaseSpeed * TP_WalkPct * TP_MovX * 0.8;
            MT.Y=BaseSpeed * TP_WalkPct * TP_MovY * 0.8;   
        }
        else
        {
            MT.X=BaseSpeed * TP_WalkPct * TP_MovX;
            MT.Y=BaseSpeed * TP_WalkPct * TP_MovY;   
        }      

        camrot=CoordSystem.Rotation;
        camrot.Roll=0;
        camrot.Pitch=0;

        MT=MT >> camrot;
        RT=Rotator(MT);
        RT.Yaw-=90 * DegToUnrRot;
        R=RInterpTo(parent.Rotation, RT, DeltaTime, TP_TurnRate , true);
        V=VInterpTo(parent.Velocity, MT, DeltaTime, TP_AccelRate);
    }
    else
    {
        MT.X=BaseSpeed * TP_WalkPct * TP_MovX;
        MT.Y=BaseSpeed * TP_WalkPct * TP_MovY;   
        V=VInterpTo(parent.Velocity, MT, DeltaTime, TP_AccelRate);
        //Velocity=MT >> camrot;
    }
    
    parent.SetRotation(R);
    parent.Velocity=V;
}
 
defaultproperties
{
    mechname='PawnMovement'
    blendbymovename='BlendByMovementState'
    blendbyangspeedname='BlendByAngularSpeed'
    
    TP_WalkPct = 1.0f
    TP_CrouchPct = 0.5f
    TP_SideStepPct = 0.7f
    TP_RunPct = 2.0f
    
    BaseSpeed = 250.0f
    TP_AccelRate = 15.0f
    TP_TurnRate = 90000
    
    GroundSpeed = 150.0f
}
