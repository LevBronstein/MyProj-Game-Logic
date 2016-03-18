/**
 *  MyProjLinearMovement
 *
 *  Creation date: 24.02.2016 23:36
 *  Copyright 2016, Windows7
 */
class MyProjLinearMovement extends MyProjMovementBase;

var() vector Speed;

//s=v*t
function MovementTransform CalcMovement(float t)
{
    local MovementTransform mt;
    
    mt.location=Speed*t;
    mt.rotation=rot(0,0,0);
    mt.scale=vect(0,0,0);
    return mt;
}

defaultproperties
{
}
