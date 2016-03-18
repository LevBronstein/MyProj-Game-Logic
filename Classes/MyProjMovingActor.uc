/**
 *  MyProjMovingActor
 *
 *  Creation date: 10.03.2016 22:23
 *  Copyright 2016, Windows7
 */
class MyProjMovingActor extends MyProjAnimatedActor
dependson(MyProjMovementBase)
ClassGroup(MyProj);

//instanced ?
var(MovingActor) editinline MyProjMovementBase Movement;  

function MovementTransform CalcMovement(float time)
{
    local MovementTransform mt;
    
    mt=Movement.CalcMovement(t);    
    
    return mt;
}

defaultproperties
{
}
