/**
 *  MyProjMoveBlendMechanism
 *
 *  Creation date: 24.02.2016 23:11
 *  Copyright 2016, Windows7
 */
class MyProjMoveBlendMechanism extends MyProjMovementMechanism
dependson(MyProjMovementBase);

//Важная фишка - возможно везде придётся использовать вместо editinline ключ instanced
var() instanced array<MyProjMovementBase> Movements; //Put here movements
var MovementTransform transform; //the transform of the parent
var float t; //main parameter
var() float t0; //base offset of the main parameter
var() float dt; //inc of main parameter

function FirstTickInit()
{
    super.FirstTickInit();
    
    t=t0;
}

//класс-болванка, не выдаёт полезного действия
//не меняют положение, поворот, размер объекта-владельца
event OwnerTick(float deltatime)
{
    if (bfirsttick==true)
        FirstTickInit();
    if (!benabled)
        return;  
   t=t+dt;     
}

//утсанавиливем преобразования для владельца
function SetTransform(float deltatime)
{
    parent.SetLocation(transform.location);
    parent.SetRotation(transform.rotation);
    //parent.SetScale(transform.scale);        
}

defaultproperties
{
    dt=0.001
    t0=0.0
}
