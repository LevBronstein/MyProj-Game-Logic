/**
 *  MyProjPawnMechanismBase
 *
 *  Creation date: 22.12.2015 00:24
 *  Copyright 2015, Win7
 */
 class MyProjPawnMechanismBase extends Object 
 editinlinenew;

 var pawn parent; // паун, к которому относится данный механизм
 var bool benabled; //whether this mechanism is currently enabled
 
 var bool bfirsttick; //whether this is the first tick and we should do some inits
 
 var() name mechname; //id of the current mech to find it out
 
 
function FirstTickInit()
{
    if (bfirsttick==true)
    {
        bfirsttick=false;
    }
}
 
event OwnerTick(float deltatime)
{
    if(benabled==false)
        return;
}



defaultproperties
{
    bfirsttick=true
}
