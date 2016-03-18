/**
 *  MyProjAnimatedActorFactory
 *
 *  Creation date: 09.03.2016 00:43
 *  Copyright 2016, Windows7
 */
 class MyProjAnimatedActorFactory extends Actor
 placeable 
 ClassGroup(MyProj);

var(Factory) class<MyProjAnimatedActor> ArchetypeClass;
var(Factory) string ArchetypeName;

var(Factory) int TotalCount;
var(Factory) bool bImmediateConstruction;

var(Factory) vector ConstructLocation;
var(Factory) vector ConstructLocationOffset;

var bool bfinished;

event Tick(float deltatime)
{
    if (bImmediateConstruction && !bfinished)
        CreateActors();
}

function array<MyProjAnimatedActor> CreateActors()
{
    local MyProjAnimatedActor a;
    local MyProjAnimatedActor aact;
    local array<MyProjAnimatedActor> actors;
    local int count;
    local vector offset;
   
    a=MyProjAnimatedActor(DynamicLoadObject(ArchetypeName,ArchetypeClass));
    
    actors.length=0;
    bfinished=false;
    
    if (a==none)
        return actors;  
     
    for (count=0;count<TotalCount;count++)
    {
        offset=ConstructLocation+ConstructLocationOffset*count;
        aact=Spawn(a.class,,,offset,rot(0,0,0),a); 
        actors.additem(aact);   
    } 
 
    bfinished=true;
    
    return actors;  
}

defaultproperties
{
   ConstructLocation=(X=-4096,Y=-4096,Z=1024) 
   ConstructLocationOffset=(X=-512,Y=0,Z=0)
  
  Begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EditorResources.S_Actor'
        HiddenGame=TRUE
        AlwaysLoadOnClient=FALSE
        AlwaysLoadOnServer=FALSE
        SpriteCategoryName="ImageReflection"
    End Object
    Components.Add(Sprite)
}
