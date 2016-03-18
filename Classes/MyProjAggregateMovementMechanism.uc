/**
 *  MyProjAggregateMovementMechanism
 *
 *  Creation date: 06.03.2016 22:27
 *  Copyright 2016, Windows7
 */
class MyProjAggregateMovementMechanism extends MyProjAggregateMechanism
dependson(MyProjMovementBase);

var() float t0;
var() float t1;
var() float dt;
var float t;
var array<MovementTransform> zeromt;
var() CoordinateSystem Coordinates;
var() TimeFlowModel TimeFlow; // do we need to limit time between t0 and t1
var() TimeManagment TimeManager; // what to do after timer reaches t1

function FirstTickInit()
{
    super.FirstTickInit();
    Initialize();
}

function Aggregate(float deltatime)
{
    CaclMovement(t);
    ApplyTransform(t); 
    IncreaseTime();
}

function Initialize();

function CaclMovement(float time);

function ApplyTransform(float time)
{
    local MovementTransform mt;
   
    `log(t@":"@mt.location@mt.rotation);    
    
    switch (Coordinates)
    {
        case World:
            PerformWorldTransform(mt);
        break;
        case Parent:
            PerformParentTransform(mt);
        break;
        case Personal:
            PerformPersonalTransform(mt);
        break;
    }           
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

function PerformWorldTransform(MovementTransform mt)
{
    local int i;
    
    for(i=0;i<Children.length;i++)
    {
        Children[i].SetLocation(mt.location);
        Children[i].SetRotation(mt.rotation);
        //Children[i].SetScale(mt.scale);    
    }
}

function PerformParentTransform(MovementTransform mt)
{
    local int i;
        
    for(i=0;i<Children.length;i++)
    {
        Children[i].SetLocation(zeromt[i].location+parent.location+mt.location);
        Children[i].SetRotation(zeromt[i].rotation+parent.rotation+mt.rotation);
        //Children[i].SetScale(parent.scale+mt.scale);   
    }
}

function PerformPersonalTransform(MovementTransform mt)
{
    local int i;
    
    for(i=0;i<Children.length;i++)
    {
        Children[i].SetLocation(zeromt[i].location+mt.location);
        Children[i].SetRotation(zeromt[i].rotation+mt.rotation);
        //Children[i].SetScale(Children[i].scale+mt.scale);   
    }
}

defaultproperties
{
}
