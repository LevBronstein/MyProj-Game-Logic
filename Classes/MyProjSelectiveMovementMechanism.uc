/**
 *  MyProjSelectiveMovementMechanis
 *
 *  Creation date: 23.02.2016 23:27
 *  Copyright 2016, Windows7
 */
class MyProjSelectiveMovementMechanism extends MyProjMovementMechanism;

//Важная фишка - возможно везде придётся использовать вместо editinline ключ instanced
var() instanced array<MyProjMovementMechanism> MovementMechanisms; //Put here mechanisms
var() int ActiveMovement;

function FirstTickInit()
{
    local int n;
    super.FirstTickInit();
    
    for (n=0;n<MovementMechanisms.Length;n++)
    {
        MovementMechanisms[n].parent=parent;  
    }
    DisableMovement();
    SetActiveMovement(ActiveMovement);
}

event OwnerTick(float deltatime)
{
    if (bfirsttick==true)
        FirstTickInit();
    if (!benabled)
        return;  
    
     LogDebug();
        
     //if (ActiveMovement>=0 && ActiveMovement<MovementMechanisms.Length)   
        MovementMechanisms[ActiveMovement].OwnerTick(deltatime);   
}

function SetActiveMovement(int i)
{
    local int n;
    if (MovementMechanisms.Length==0 || i>=MovementMechanisms.Length)
        return;
    
    ActiveMovement=i;
    
    if (i<0)
    {
        DisableMovement();
        return;   
    }
    
    //супер-затуп, вместо  MovementMechanisms[n] писал  MovementMechanisms[i]
    //и удивлялся, что ж оно не робит!
    for (n=0;n<MovementMechanisms.Length;n++)
    {
        if (n==i)
            MovementMechanisms[n].benabled=true; 
        else
            MovementMechanisms[n].benabled=false;     
    }
}

function LogDebug()
{
    local int n;
    `log("ActiveMovement:"@ActiveMovement);
    for (n=0;n<MovementMechanisms.Length;n++)
    {
        `log(n@":"@MovementMechanisms[n]@MovementMechanisms[n].mechname@MovementMechanisms[n].benabled);
    }
}

function DisableMovement()
{
    local int n;  
    
    //ActiveMovement=-1;
    
    for (n=0;n<MovementMechanisms.Length;n++)
    {
        MovementMechanisms[n].benabled=false;    
    }  
}
   
defaultproperties
{
}
