/**
 *  TPSetViewCam
 *
 *  This should be called before using SetCameraTarget kismet node 
 *  if using with ThirdPersonControlledPawn to let fill TP_ViewCamera field
 *
 *  Creation date: 13.07.2015 14:43
 *  Copyright 2015, Win7
 */
class TPSetViewCam extends SequenceAction;

var ThirdPersonControlledPawn TargetPawn;
var CameraActor NewCam;

event Activated()
{
   TargetPawn.SetActiveViewCamera(NewCam);
}

defaultproperties
{
    bCallHandler=false
    
    ObjName="Set Active Camera"
    ObjCategory="ThirdPersonGame"

    VariableLinks(0)=(ExpectedType=class'SeqVar_Object',LinkDesc="ThirdPersonControlledPawn",PropertyName=TargetPawn)
    VariableLinks(1)=(ExpectedType=class'SeqVar_Object',LinkDesc="CameraActor",PropertyName=NewCam)
}
