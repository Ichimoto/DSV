class DSVPawn extends UTPawn;

var float CamOffsetDistance; //distance to offset the camera from the player
var int IsoCamAngle; //pitch angle of the camera

//override to make player mesh visible by default
simulated event BecomeViewTarget( PlayerController PC )
{
   local UTPlayerController UTPC;

   Super.BecomeViewTarget(PC);

   if (LocalPlayer(PC.Player) != None)
   {
      UTPC = UTPlayerController(PC);
      if (UTPC != None)
      {
         //set player controller to behind view and make mesh visible
         UTPC.SetBehindView(true);
         SetMeshVisibility(UTPC.bBehindView); 
         UTPC.bNoCrosshair = true;
      }
   }
}

simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
   out_CamLoc = Location;
   out_CamLoc.X -= Cos(IsoCamAngle * UnrRotToRad) * CamOffsetDistance;
   out_CamLoc.Z += Sin(IsoCamAngle * UnrRotToRad) * CamOffsetDistance;

   out_CamRot.Pitch = -1 * IsoCamAngle;   
   out_CamRot.Yaw = 0;
   out_CamRot.Roll = 0;

   return true;
}

simulated singular event Rotator GetBaseAimRotation()
{
   local rotator   POVRot, tempRot;

   tempRot = Rotation;
   tempRot.Pitch = 0;
   SetRotation(tempRot);
   POVRot = Rotation;
   POVRot.Pitch = 0;

   return POVRot;
}   

defaultproperties
{
   IsoCamAngle=4500
   CamOffsetDistance=300.0
}
