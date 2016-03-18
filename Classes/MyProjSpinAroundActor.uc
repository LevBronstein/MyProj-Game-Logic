/**
 *  MyProjSpinAroundActor
 *
 *  Creation date: 07.03.2016 22:12
 *  Copyright 2016, Windows7
 */
class MyProjSpinAroundActor extends MyProjAnimatedActor
ClassGroup(MyProj);

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

function MovementTransform CalcMovement(float time)
{
    local vector offset;
    local rotator turn;
    local MovementTransform mt;
    
    //set location
    offset=vect(1,0,0)*Distance;
    offset=offset<<(RotationOffset+RotationPerTick*t);
    
    if(bUseCenterActor)
    {
        if(CenterActor!=none)
            nextpoint=CenterActor.Location+offset; 
    }
    else
    {
        nextpoint=Point+offset;
    }
    mt.location=nextpoint;

    //set rotation
    turn=TurnPerTick*t+TurnPerTick+TurnOffset;
    mt.rotation=turn;
 
    //set scale
    mt.scale=vect(1,1,1);
 
    return mt;   
}

defaultproperties
{
    t0=0.0
    t1=720.0
}
