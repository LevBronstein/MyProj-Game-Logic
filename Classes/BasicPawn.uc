/**
 *  BasicPawn
 *
 *  Creation date: 04.07.2015 16:27
 *  Copyright 2015, Win7
 */
class BasicPawn extends Pawn
placeable
ClassGroup(MyProj);

var (LightEnvironment) DynamicLightEnvironmentComponent LightEnvironment;

defaultproperties
{
    bStatic = False
    
    Components.Remove(Sprite)
   
    Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
      bSynthesizeSHLight=TRUE
      bIsCharacterLightEnvironment=TRUE
      bUseBooleanEnvironmentShadowing=FALSE
   End Object
   Components.Add(MyLightEnvironment)
   LightEnvironment=MyLightEnvironment
    
    Begin Object Class=SkeletalMeshComponent Name=WPawnSkeletalMeshComponent
       //Your Mesh Properties
       LightEnvironment=MyLightEnvironment
   End Object
   Mesh=WPawnSkeletalMeshComponent
   Components.Add(WPawnSkeletalMeshComponent)
}
