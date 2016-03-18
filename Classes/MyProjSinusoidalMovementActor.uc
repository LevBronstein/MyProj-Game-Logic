/**
 *  MyProjSinusoidalMovementActor
 *
 *  Creation date: 08.03.2016 23:59
 *  Copyright 2016, Windows7
 */
class MyProjSinusoidalMovementActor extends MyProjLinearMovementActor
ClassGroup(MyProj);

var(SinusoidalMovement) vector Amplitude;
var(SinusoidalMovement) vector Wavelength;
var(SinusoidalMovement) float SinCorrection; //Correct x in Sin(x) to fit functions nature

function MovementTransform CalcMovement(float time)
{
    local vector offset;
    local vector sinusoid;
    local MovementTransform mt;
    local float f;
    
    f=SinCorrection+0.01;
    
    sinusoid.x=Amplitude.x*cos(Wavelength.x*time/f);
    sinusoid.y=Amplitude.y*cos(Wavelength.y*time/f);
    sinusoid.z=Amplitude.z*cos(Wavelength.z*time/f);
     
    if(bUseOriginActor)
    {
        if(OriginActor!=none)
            offset=BaseOffset+OriginActor.location+Speed*time+sinusoid; 
    }
    else
    {
        offset=BaseOffset+OriginPoint+Speed*time+sinusoid;
    }
     
     mt.location=offset;
     mt.rotation=rotation;
     mt.scale=vect(1,1,1);
     
     return mt;
}

defaultproperties
{
    SinCorrection=100.0
}
