/**
 *  MyProjAggregateMechanism
 *
 *  A mechanism that gives actor the ability to aggregate other actors
 *
 *
 *  Creation date: 06.03.2016 22:11
 *  Copyright 2016, Windows7
 */
class MyProjAggregateMechanism extends MyProjActorMechanismBase;

var() array<Actor> Children; //All actors which are affected by this mechanism

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
        
    Aggregate(deltatime); //полиморфизм должен работать     
}

function AddChild(actor child)
{
    if (child!=none)
        children.additem(child);
}

function ClearChildren()
{
    children.length=0;
}

function Actor GetChild(int id)
{
    if (id>0 && id<Children.Length)
        return children[id];
    else
        return none;
}

function Aggregate(float deltatime)
{
    //dummy
}
    
defaultproperties
{
}
