/**
 *  TPSwitchInt10
 *
 *  Creation date: 17.12.2015 00:53
 *  Copyright 2015, Win7
 */
class TPSwitchInt10 extends SequenceCondition;

var(Switch) int variants[10];
var int switchvalue;

event Activated()
{
    local int i;
    super.Activated();
    
    for (i=0;i<10;i++)
    {
        if (switchvalue==variants[i])
        {
            ActivateOutputLink(i);
            return;
        }
    }
    ActivateOutputLink(10);
}

defaultproperties
{
    
    OutputLinks(0)=(LinkDesc="case one")
    OutputLinks(1)=(LinkDesc="case two")
    OutputLinks(2)=(LinkDesc="case three")
    OutputLinks(3)=(LinkDesc="case four")
    OutputLinks(4)=(LinkDesc="case five") 
    OutputLinks(5)=(LinkDesc="case six")
    OutputLinks(6)=(LinkDesc="case seven")
    OutputLinks(7)=(LinkDesc="case eight")
    OutputLinks(8)=(LinkDesc="case nine")
    OutputLinks(9)=(LinkDesc="case ten") 
    OutputLinks(10)=(LinkDesc="default case")
    
    VariableLinks(0)=(ExpectedType=class'SeqVar_Int',LinkDesc="Value",PropertyName=switchvalue)
    
    bCallHandler=false
    
    ObjName="Switch Int Variable 10"
    ObjCategory="ThirdPersonGameUtils"
    
    bAutoActivateOutputLinks = false
}
