/**
 *  MyProjAggregatorActor
 *
 *  Creation date: 07.03.2016 22:46
 *  Copyright 2016, Windows7
 */
class MyProjAggregatorActor extends MyProjAnimatedActor
ClassGroup(MyProj);

var(Aggregator) array<MyProjAnimatedActor> Children; //All actors which are affected by this mechanism

function AddChild(MyProjAnimatedActor child)
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

function PerformTransform()
{
    //сейчас не нужно предвидеть передвижения подчинённых акторов
    //но потом может понадобиться
    //mt=CaclMovement(t);

    PerformChildTransform(t);
    
}    
    
function MovementTransform CalcMovement(float time)
{
    local MovementTransform mt;
    
    CalcChildMovement(time);
    
    mt.location=location;
    mt.rotation=rotation;
    mt.scale=vect(1,1,1);
    
    return mt;
}
 
function array<MovementTransform> CalcChildMovement(float time)
{
    local int i;
    local MovementTransform mt;
    local array<MovementTransform> childmts;
    
    for(i=0;i<Children.length;i++)
    {
        mt=Children[i].CalcMovement(time);
        childmts.additem(mt);  
    }  
   
   return childmts; 
}
  
function PerformChildTransform(float time)
{
    local int i;
    
    for(i=0;i<Children.length;i++)
    {
        Children[i].PlayFrame(time);  
    }   
}
 
defaultproperties
{
    
    Begin Object Class=SpriteComponent Name=Sprite
        Sprite=Texture2D'EditorResources.S_Actor'
        HiddenGame=TRUE
        AlwaysLoadOnClient=FALSE
        AlwaysLoadOnServer=FALSE
        SpriteCategoryName="ImageReflection"
    End Object
    Components.Add(Sprite)
    
    Components.Remove(BaseMesh)    
}
