/**
 *  MyProjKeyFramedMovement
 *
 *  Creation date: 18.03.2016 22:58
 *  Copyright 2016, Windows7
 */
class MyProjKeyFramedMovement extends MyProjMovementBase
ClassGroup(MyProj);

struct PhaseParameter
{
    var() float PhaseValue;
    var() float PhaseLength;
    var() bool bDiscrete;
};

struct ParameterFrame
{
        //CONSTANT!!!
    var() string ParameterName; //the name of the parameter
    var() array<PhaseParameter> KeyFrames; //array of phase parameters to be used as keyframes
};

var(KeyFramedMovement) editfixedsize array<ParameterFrame> BasicMovementParams;

function float CalcBasicParamValue(int param, float t)
{
    local int i;
    local int lastkey;
    local float ct;
    local float t0;
    local float res;
    
    if (BasicMovementParams.Length==0 ||BasicMovementParams[param].KeyFrames.Length==0)
        return 0; //когда что-то пошло не так
        
    ct=BasicMovementParams[param].KeyFrames[0].PhaseLength;    
    lastkey=0;
    
    //нулевой phasevalue - значение по умолчанию, начинаем с первого
    //определяем промежуток времени, а по нему и необходимый параметр
    for (i=1; i<BasicMovementParams[param].KeyFrames.Length; i++)
    {
        if (t<ct)
        {
            lastkey=i; //firstcommand=i-1
            break;
        }  
        ct=ct+BasicMovementParams[param].KeyFrames[i].PhaseLength;   
    }
    
    if (lastkey==0)
        return BasicMovementParams[param].KeyFrames[0].PhaseValue;
        
    //иначе переходит из состояния lastkey-1 в состояние lastkey
    //расстояние между lastkey-1 и lastkey равняется KeyFrames[lastkey-1].PhaseLength 
    //итого получаем процент отдаления от lastkey-1 к lastkey   
    t0=min(abs(t-ct), BasicMovementParams[param].KeyFrames[lastkey-1].PhaseLength);
    t0=1-(t0/BasicMovementParams[param].KeyFrames[lastkey-1].PhaseLength); //что, если PhaseLength=0?
    
    //если фазовый параметр в lastkey не является дискретным, то применяется интерполяция
    if(!BasicMovementParams[param].KeyFrames[lastkey].bDiscrete)
    {
        res=lerp(BasicMovementParams[param].KeyFrames[lastkey-1].PhaseValue, BasicMovementParams[param].KeyFrames[lastkey].PhaseValue, t0);
    }
    else
    {
        res=BasicMovementParams[param].KeyFrames[lastkey-1].PhaseValue;
    }
    //`log(t@"param"@param@"value"@res);
    return res;
}

function MovementTransform CalcMovement(float t)
{
    local MovementTransform mt;   
    local vector v;
    local rotator r;
    
    mt.location.x=CalcBasicParamValue(0, t);
    mt.location.y=CalcBasicParamValue(1, t); 
    mt.location.z=CalcBasicParamValue(2, t);
    mt.rotation.yaw=CalcBasicParamValue(3, t);
    mt.rotation.pitch=CalcBasicParamValue(4, t);
    mt.rotation.roll=CalcBasicParamValue(5, t);
    mt.scale=vect(0,0,0);
    
    `log(t@"loc"@CalcBasicParamValue(0, t));
    
    return mt;
}   

defaultproperties
{
    BasicMovementParams.Add((ParameterName="Location.X"))           //0
    BasicMovementParams.Add((ParameterName="Location.Y"))           //1
    BasicMovementParams.Add((ParameterName="Location.Z"))           //2
    BasicMovementParams.Add((ParameterName="Rotation.Y"))           //3
    BasicMovementParams.Add((ParameterName="Rotation.P"))           //4
    BasicMovementParams.Add((ParameterName="Rotation.R"))           //5
    BasicMovementParams.Add((ParameterName="Scale.X"))              //6
    BasicMovementParams.Add((ParameterName="Scale.Y"))              //7
    BasicMovementParams.Add((ParameterName="Scale.Z"))              //8
    BasicMovementParams.Add((ParameterName="CoordCenter.X"))        //9
    BasicMovementParams.Add((ParameterName="CoordCenter.Y"))        //10
    BasicMovementParams.Add((ParameterName="CoordCenter.Z"))        //11
    BasicMovementParams.Add((ParameterName="CoordOrientation.Y"))   //12
    BasicMovementParams.Add((ParameterName="CoordOrientation.P"))   //13
    BasicMovementParams.Add((ParameterName="CoordOrientation.R"))   //14
    BasicMovementParams.Add((ParameterName="CoordScaling.X"))       //15
    BasicMovementParams.Add((ParameterName="CoordScaling.Y"))       //16
    BasicMovementParams.Add((ParameterName="CoordScaling.Z"))       //17
}
