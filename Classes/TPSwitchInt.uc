/**
 *  TPSwitchInt
 *
 *  Creation date: 16.12.2015 23:59
 *  Copyright 2015, Win7
 */
class TPSwitchInt extends SequenceCondition;

var(Switch) int variants[5];
var int switchvalue;

event Activated()
{
    local int i;
    super.Activated();
    
    for (i=0;i<5;i++)
    {
        if (switchvalue==variants[i])
        {
            ActivateOutputLink(i);
            return;
        }
    }
    ActivateOutputLink(5);
}

defaultproperties
{
    
    OutputLinks(0)=(LinkDesc="case one")
    OutputLinks(1)=(LinkDesc="case two")
    OutputLinks(2)=(LinkDesc="case three")
    OutputLinks(3)=(LinkDesc="case four")
    OutputLinks(4)=(LinkDesc="case five") 
    OutputLinks(5)=(LinkDesc="default case")
    
    VariableLinks(0)=(ExpectedType=class'SeqVar_Int',LinkDesc="Value",PropertyName=switchvalue)
    
    bCallHandler=false
    
    ObjName="Switch Int Variable 5"
    ObjCategory="ThirdPersonGameUtils"
    
    bAutoActivateOutputLinks = false
}
