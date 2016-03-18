/**
 *  TPDisplayString
 *
 *  Creation date: 20.09.2015 00:29
 *  Copyright 2015, Win7
 */
class TPDisplayString extends SequenceAction;

var string s;
var HUD h;
var PlayerReplicationInfo pri;
var() Vector2D ScreenPosition;
var() Vector DrawColor;
var() Font DrawFont;

event Activated()
{
   local actor a;
   h=a.GetALocalPlayerController().myhud;
   pri=a.GetALocalPlayerController().PlayerReplicationInfo;
   a.Worldinfo.Game.Broadcast(a.GetALocalPlayerController(),"sadasd");
   h.Message(pri,s,'say');      
}

   /*h.Canvas.Font = class'Engine'.static.GetMediumFont();      
   h.Canvas.SetDrawColor(DrawColor.X, DrawColor.Y, DrawColor.Z);
   h.Canvas.SetPos(ScreenPosition.X, ScreenPosition.Y);
   
   h.Canvas.DrawText(s);*/


defaultproperties
{
    bCallHandler=false
    
    ObjName="Draw String On Screen"
    ObjCategory="SupportFunctions"

    VariableLinks(0)=(ExpectedType=class 'SeqVar_String',LinkDesc="String",PropertyName=s)
}
