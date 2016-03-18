/**
 *  MyProjAnimatedActor
 *
 *  Creation date: 07.03.2016 21:34
 *  Copyright 2016, Windows7
 */
class MyProjAnimatedActor extends Actor
placeable dependson(MyProjMovementBase)
ClassGroup(MyProj);

var(Appearance) const StaticMeshComponent Mesh; //Mesh for this actor
 
var(Timeline) float t0;
var(Timeline) float t1;
var(Timeline) float dt;
var(Playback) PlaybackType Playback;
var(Playback) TimeFlowModel TimeFlow; // do we need to limit time between t0 and t1
var(Playback) TimeManagment TimeManager; // what to do after timer reaches t1

var float t;
var float _deltatime; //Ай-ай!!!
var float _interpspeed;

event PostBeginPlay()
{
    super.PostBeginPlay();
    
    Initialize();    
}

event Tick(float deltatime)
{
    if (Playback==PLAYBACK_ONTICK)
    {
        PerformTransform();   
        IncreaseTime(); 
    }
}

function PlayNextFrame()
{
    PerformTransform();   
    IncreaseTime();     
}

//Plays even frame, just sets t equal to the parameter
function PlayFrame(float time)
{
   t=time;
   PerformTransform();  
}

function IncreaseTime()
{
    if (TimeManager==RESET_ON_OVER)
    {
        if (TimeFlow==BETWEEN_T0_T1)
        {
            if (t>t1)
            {
                 ResetTime();    
            }            
        }
        
    }
    else if (TimeManager==RESET_ON_OVER)
    {
        if (TimeFlow==BETWEEN_T0_T1)
        {
            if (t>t1 || t<t0)
            {
                ReverseTimeStep();  
            }            
        }    
    }
    
    t=t+dt; 
}

function DecreaseTime()
{
    t=t-dt;   
}

function ResetTime()
{
    t=t0;   
    dt=abs(dt);
}

function ReverseTimeStep()
{
    dt=-dt;
}

function PerformTransform()
{
    local MovementTransform mt;
    local vector loc;
    local rotator rot;
    
    mt=CalcMovement(t);
    
    //loc=VInterpTo(location, mt.location, _deltatime, _interpspeed);
   
    SetLocation(mt.location);
    SetRotation(mt.rotation);
    //SetScale(mt.scale);
}

function Initialize();

function MovementTransform CalcMovement(float time);

defaultproperties
{
    dt=1.0
    
    _interpspeed=1.0
    
    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
        bEnabled=TRUE
    End Object
 
    LightEnvironment=MyLightEnvironment
    Components.Add(MyLightEnvironment)
    
    Begin Object Class=StaticMeshComponent Name=BaseMesh
        StaticMesh=StaticMesh'EngineMeshes.Sphere'
        LightEnvironment=MyLightEnvironment
    End Object
    Components.Add(BaseMesh)
    Mesh=BaseMesh
