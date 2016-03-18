/**
 *  TPSMatineePlayPart
 *
 *  Creation date: 26.09.2015 20:31
 *  Copyright 2015, Win7
 */
class TPSMatineePlayPart extends SeqAct_Latent;

var() float MatineeStart, MatineeEnd;

event bool Update(float DeltaTime)
{
    /*if (bIsPlaying == true)
    {
        if (Position < MEnd)
        {
            SetPosition(Position + (PlayRate * Deltatime), false);
            return true; 
        }
        else
            return false;
        }*/
}

function Activated()
{
    
}

defaultproperties
{
    ObjName="Play Matinee A to B"
    ObjCategory="MatineeControl"
    
    PlayRate=1.0

    InputLinks.Empty 
    InputLinks(0)=(LinkDesc="Play")
    //InputLinks(1)=(LinkDesc="Reverse")
    //InputLinks(2)=(LinkDesc="Stop")
    //InputLinks(3)=(LinkDesc="Pause")
    
    OutputLinks.Empty
    OutputLinks(0)=(LinkDesc="Play Matinee")
    OutputLinks(0)=(LinkDesc="Stop Matinee")
    
    VariableLinks.Empty
    //VariableLinks(1)=(ExpectedType=class'SeqVar_Float',LinkDesc="StartPoint",PropertyName=MStart)
    //VariableLinks(2)=(ExpectedType=class'SeqVar_Float',LinkDesc="EndPoint",PropertyName=MEnd)

}
