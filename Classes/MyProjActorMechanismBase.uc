/**
 *  MyProjActorMechanismBase
 *
 *  Creation date: 21.02.2016 22:45
 *  Copyright 2016, Windows7
 */
class MyProjActorMechanismBase extends Object 
editinlinenew;

 var actor parent; //parent actor
 var(MechanismBase) bool benabled; //whether this mechanism is currently enabled
 
 var bool bfirsttick; //whether this is the first tick and we should do some inits
 
 var(MechanismBase) name mechname; //id of the current mech to find it out
 
 
function FirstTickInit()
{
    if (bfirsttick==true)
    {
        bfirsttick=false;
    }
}
 
event OwnerTick(float deltatime)
{
    FirstTickInit();
    if(benabled==false)
        return;
}



defaultproperties
{
    bfirsttick=true
    benabled=true
}