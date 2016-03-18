/**
 *  MyProjSingleMovementMechanism
 *
 *  Creation date: 24.02.2016 23:25
 *  Copyright 2016, Windows7
 */
class MyProjSingleMovementMechanism extends MyProjMoveBlendMechanism;

var() int ActiveMovement;


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
    
    if (ActiveMovement<0 || ActiveMovement>=Movements.Length)
        return;
    
    transform=Movements[ActiveMovement].CalcMovement(t);  
    SetTransform(deltatime);
    t=t+dt;
}

function SetActiveMovement(int i)
{
   ActiveMovement=i; 
}

defaultproperties
{
}
