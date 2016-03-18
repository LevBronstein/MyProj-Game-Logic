/**
 *  ThirdPersonHUD
 *
 *  Creation date: 27.07.2015 14:48
 *  Copyright 2015, Win7
 */
class ThirdPersonHUD extends HUD;


function DrawHUD()
{
   local ThirdPersonControlledPawn p;
   local ThirdPersonControlledPawn a;
   super.DrawHUD();    

   foreach AllActors(class 'ThirdPersonControlledPawn', a)
   {
       if (A.TP_LogStats == true)
        p=a;
   }
   
   Canvas.Font = class'Engine'.static.GetSmallFont();      
   Canvas.SetDrawColor(128, 128, 128); // White
   Canvas.SetPos(70, 15);
   
   Canvas.DrawText("State:" @ p.GetStateName() @ "\n" @ "Acceleration:" @ p.Acceleration @"\n" @ 
   "Velocity:" @ p.Velocity @ "\n" @ "Rotation:" @ p.Rotation * UnrRotToDeg);
   
   Canvas.SetPos(70, 250);
   Canvas.DrawText("Collision" @ p.CylinderComponent @ "\n" @ "Collision Radius:" @ p.CylinderComponent.CollisionRadius @ 
   "Collision Height:" @ p.CylinderComponent.CollisionHeight);
   
   
   
}


defaultproperties
{
}
