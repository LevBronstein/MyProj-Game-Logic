/**
 *  MyProjSpinAroundMoveMech
 *
 *  Creation date: 21.02.2016 22:56
 *  Copyright 2016, Windows7
 */
class MyProjSpinAroundMoveMech extends MyProjMovementMechanism;

enum RotationOrbit
{
    OrbitXY,
    OrbitXZ,
    OrbitBoth    
};

var(SpinOrbit) vector Point; //A point which is used as a center for rotation
var(SpinOrbit) actor CenterActor; //An actor which is used as a center for rotation
var(SpinOrbit) bool bUseCenterActor; //When true - the Points value is overridden with this actors location
var(SpinOrbit) float Distance; //A value which is used to calculate an offset from the center point
var(SpinOrbit) rotator RotationPerTick; //Amount of rotation per tick
var(SpinOrbit) rotator RotationOffset; //A vector of X,Y,Z offsets in orbit

var(SpinTurn) rotator TurnPerTick;
var(SpinTurn) rotator TurnOffset;

var vector nextpoint;
var rotator currot;
var rotator curturn;

function FirstTickInit()
{
    super.FirstTickInit();
}

event OwnerTick(float deltatime)
{
    if (bfirsttick==true)
        FirstTickInit();
    if (!benabled)
        return;  
        
    PerformOrbitRotation();
    PerformTurnRotation();
}
   
function PerformOrbitRotation()
{
    local vector offset;
    
    offset=vect(1,0,0)*Distance;
    offset=offset<<(RotationOffset+currot);
    
    if(bUseCenterActor)
    {
        if(CenterActor!=none)
            nextpoint=CenterActor.Location+offset; 
    }
    else
    {
        nextpoint=Point+offset;
    }
    
    parent.SetLocation(nextpoint);
    
    currot=currot+RotationPerTick;
}

function PerformTurnRotation()
{
    local rotator turn;
    
    turn=curturn+TurnPerTick+TurnOffset;
    
    parent.SetRotation(turn);
    
    curturn=curturn+TurnPerTick;    
}

defaultproperties
{
    mechname='SpinAround'
}
