/**
 *  MyProjProgrammedMovement
 *
 *  Creation date: 11.03.2016 21:40
 *  Copyright 2016, Windows7
 */
class MyProjProgrammedMovement extends MyProjMovementBase;

enum MovementOperator
{
    Forward,
    Backward,
    TurnRight,
    TurnLeft
};

struct MovementCommand
{
    var() MovementOperator Command;
    var() float Value;
    var() float ExecLength; //how long is this command executed
};

var(ProgrammedMovement) array<MovementCommand> MovementProgramm;
var(ProgrammedMovement) MovementTransform ZeroTransform;

//выдаст преобразования, получившиеся в том числе при сложении с предыдущими преобразованиями
function MovementTransform ExecCommand(int command, MovementTransform prev)
{
    local MovementTransform mt;
    local float value;
    
    mt.location=vect(0,0,0);
    mt.rotation=rot(0,0,0);
    mt.scale=vect(0,0,0);
    
    if (command<0 || command>=MovementProgramm.Length)
        return mt;
        
    switch (MovementProgramm[command].Command)
    {
        case Forward:
            mt.location=(vect(1,0,0)*MovementProgramm[command].Value)<<prev.rotation;
            mt.location=mt.location+prev.location;
            mt.rotation=prev.rotation;
            break;
        case Backward:  
            mt.location=(vect(-1,0,0)*MovementProgramm[command].Value)<<prev.rotation;
            mt.location=mt.location+prev.location;
            mt.rotation=prev.rotation;
            break;
        case TurnRight:
            mt.rotation.Yaw=MovementProgramm[command].Value*DegToUnrRot;
            mt.rotation=mt.rotation+prev.rotation;
            mt.location=prev.location;
            break;
        case TurnLeft:
            mt.rotation.Yaw=-MovementProgramm[command].Value*DegToUnrRot;
            mt.rotation=mt.rotation+prev.rotation;
            mt.location=prev.location;
            break;
    } 
    
    //`log(command@":"@MovementProgramm[command].Command@"|"@MovementProgramm[command].Value@"loc:"@mt.location@"rot:"@mt.rotation);
        
    return mt;
}

//то же, что и выше, но без учёта накопленных преобразований
function MovementTransform ExecCommandDynamic(int command, MovementTransform prev)
{
    local MovementTransform mt;
    local float value;
    
    mt.location=vect(0,0,0);
    mt.rotation=rot(0,0,0);
    mt.scale=vect(0,0,0);
    
    if (command<0 || command>=MovementProgramm.Length)
        return mt;
        
    switch (MovementProgramm[command].Command)
    {
        case Forward:
            mt.location=(vect(1,0,0)*MovementProgramm[command].Value)<<prev.rotation;
            mt.rotation=rot(0,0,0);
            break;
        case Backward:  
            mt.location=(vect(-1,0,0)*MovementProgramm[command].Value)<<prev.rotation;
            mt.rotation=rot(0,0,0);
            break;
        case TurnRight:
            mt.rotation.Yaw=MovementProgramm[command].Value*DegToUnrRot;
            mt.location=vect(0,0,0);
            break;
        case TurnLeft:
            mt.rotation.Yaw=-MovementProgramm[command].Value*DegToUnrRot;
            mt.location=vect(0,0,0);
            break;
    } 
   
    return mt;
}


function MovementTransform CalcMovement(float t)
{
    local int i;
    local int lastcommand;
    local float ct;
    local float t0;
    local MovementTransform mt;
    local MovementTransform res;
    
    if (MovementProgramm.Length==0)
        return ZeroTransform;
    
    ct=MovementProgramm[0].ExecLength;
    
    //определяем, сколько команд надо выполнить до этого положения во времени
    for (i=0;i<MovementProgramm.Length;i++)
    {
        if (t<ct)
        {
            lastcommand=i;
            break;
        }
        ct=ct+MovementProgramm[i].ExecLength;
    }
    
    //при t больше всех допустимых значений выдаёт нулевую команду
    
    `log("time:"@t@"ctime:"@ct@"command:"@lastcommand@MovementProgramm[lastcommand].command);
    
    res=ZeroTransform;
    
    //прогоняем всю программу до нужной команды
    
    //`log("time:"@t@"ctime:"@ct@"t0:"@t0);
    
    if (lastcommand==0)
    {
        mt=ExecCommandDynamic(0, res);
        
        t0=min(abs(t-ct),MovementProgramm[lastcommand].ExecLength);
        t0=1-(t0/MovementProgramm[lastcommand].ExecLength);
        
        mt.location=vlerp(vect(0,0,0),mt.location,t0);
        mt.rotation=rlerp(rot(0,0,0),mt.rotation,t0,false);
        mt.scale=vlerp(vect(0,0,0),mt.scale,t0);
        
        res.location=res.location+mt.location;
        res.rotation=res.rotation+mt.rotation;
        res.scale=res.scale+mt.scale;
        return res;
    }
    else
    {
        for (i=0;i<lastcommand;i++)
        {
            mt=ExecCommand(i, res);
            res=mt;
        }
        
        mt=ExecCommandDynamic(lastcommand, res);
        
        t0=min(abs(t-ct),MovementProgramm[lastcommand].ExecLength);
        t0=1-(t0/MovementProgramm[lastcommand].ExecLength);
        
        mt.location=vlerp(vect(0,0,0),mt.location,t0);
        mt.rotation=rlerp(rot(0,0,0),mt.rotation,t0,false);
        mt.scale=vlerp(vect(0,0,0),mt.scale,t0);
        
        res.location=res.location+mt.location;
        res.rotation=res.rotation+mt.rotation;
        res.scale=res.scale+mt.scale;
        
        return res;     
    }
}

defaultproperties
{
}
