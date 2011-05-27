class DSVPlayerController extends UTPlayerController;

state PlayerWalking
{
ignores SeePlayer, HearNoise, Bump;

   function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot)
   {
      local Rotator tempRot;

      if( Pawn == None )
      {
         return;
      }

      if (Role == ROLE_Authority)
      {
         // Update ViewPitch for remote clients
         Pawn.SetRemoteViewPitch( Rotation.Pitch );
      }

      Pawn.Acceleration.X = 0;
      Pawn.Acceleration.Y = +1 * PlayerInput.aStrafe * DeltaTime * 100 * PlayerInput.MoveForwardSpeed;
      Pawn.Acceleration.Z = 0;
      
      tempRot.Pitch = Pawn.Rotation.Pitch;
      tempRot.Roll = 0;
      if(Normal(Pawn.Acceleration) Dot Vect(0,1,0) > 0)
      {
         tempRot.Yaw = 16384;
         Pawn.SetRotation(tempRot);
      }
      else if(Normal(Pawn.Acceleration) Dot Vect(0,1,0) < 0)
      {
         tempRot.Yaw = 49152;
         Pawn.SetRotation(tempRot);
      }

      CheckJumpOrDuck();
   }
}

function UpdateRotation( float DeltaTime )
{
   local Rotator   DeltaRot, ViewRotation;

   ViewRotation = Rotation;

   // Calculate Delta to be applied on ViewRotation
   DeltaRot.Yaw = Pawn.Rotation.Yaw;
   //DeltaRot.Pitch   = PlayerInput.aLookUp;

   ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot );
   SetRotation(ViewRotation);
}   

defaultproperties
{
}
