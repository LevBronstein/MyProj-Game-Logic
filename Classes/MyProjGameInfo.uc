/**
 * Copyright 1998-2014 Epic Games, Inc. All Rights Reserved.
 */
class MyProjGameInfo extends GameInfo;

auto State PendingMatch
{
Begin:
	StartMatch();
}

defaultproperties
{
	HUDType=class'GameFramework.MobileHUD'
	PlayerControllerClass=class'MyProjGame.MyProjPlayerController'
	DefaultPawnClass=class'MyProjGame.MyProjPawn'
	bDelayedStart=false
}


