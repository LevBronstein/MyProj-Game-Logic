/**
 *  MyProjLinearMovementActor
 *
 *  Creation date: 08.03.2016 23:40
 *  Copyright 2016, Windows7
 */
class MyProjLinearMovementActor extends MyProjAnimatedActor
ClassGroup(MyProj);

var(LinearMovement) vector OriginPoint; //A point to start monvement
var(LinearMovement) vector Speed; //Amount to increase on each step
var(SinusoidalMovement) vector BaseOffset; //Constant offset
var(LinearMovement) actor OriginActor; //An actor which is used as a center for movement
var(LinearMovement) bool bUseOriginActor; //When true - the Points value is overridden with this actors location
var(LinearMovement) bool bUseSelfLocationAsOriginPoint;

function Initialize()
{
    if (bUseSelfLocationAsOriginPoint)
        OriginPoint=location;       
}

function MovementTransform CalcMovement(float time)
{
    local vector offset;
    local MovementTransform mt;
      
    if(bUseOriginActor)
    {
        if(OriginActor!=none)
            offset=BaseOffset+OriginActor.location+Speed*time; 
    }
    else
    {
        offset=BaseOffset+OriginPoint+Speed*time;
    }
     
     mt.location=offset;
     mt.rotation=rotation;
     mt.scale=vect(1,1,1);
     
     return mt;
}

defaultproperties
{
}
