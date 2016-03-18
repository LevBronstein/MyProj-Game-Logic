/**
 *  MyProjMovementBase
 *
 *  Creation date: 24.02.2016 23:12
 *  Copyright 2016, Windows7
 */
class MyProjMovementBase extends Object
editinlinenew;

struct MovementTransform
{
    var() vector location;
    var() rotator rotation;
    var() vector scale;    
};

enum CoordinateSystem
{
    World,
    Parent,
    Personal
};

enum TimeManagment
{
    RESET_ON_OVER,
    REVERSE_ON_OVER,
    STOP_ON_OVER
};

enum TimeFlowModel
{
    INFINITE,
    BETWEEN_T0_T1
};

enum PlaybackType
{
    PLAYBACK_ONTICK,
    PLAYBACK_MANUAL
};

var vector curloc;
var rotator currot;
var vector curscale;

//Тут должна быть функция f(t), например sin(t), t - типа параметр
function MovementTransform CalcMovement(float t);

defaultproperties
{
}
