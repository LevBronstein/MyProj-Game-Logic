/**
 *  MyProjMechanismDrivenActor
 *
 *  Creation date: 21.02.2016 22:46
 *  Copyright 2016, Windows7
 */
class MyProjMechanismDrivenActor extends Actor
placeable;

var(MechanismDrivenActor) editinline array<MyProjActorMechanismBase> AllMechanisms; //mechanisms used for this actor
var(MechanismDrivenActor) const StaticMeshComponent Mesh; //Mesh for this actor

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

function MyProjActorMechanismBase GetMechanismByName(name mechname)
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



defaultproperties
{
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
}
