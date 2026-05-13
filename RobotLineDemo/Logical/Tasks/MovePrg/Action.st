
ACTION CreateTraysAndContent: 

	IF Cmd.Details.AutoCreationPath2 THEN
				
		(* 1. Calculate delta position *)
		DeltaPos := MpAxisConv2.Position - LastConveyorPos;

		(* 2. Detect overflow (wrap from 4000 -> 0) *)
		IF DeltaPos < 0.0 THEN
			DeltaPos := DeltaPos + 4000;
		END_IF;

		(* 3. Accumulate travelled distance *)
		TravelAccumulator := TravelAccumulator + DeltaPos;

		(* 4. Check if spacing reached *)
		IF TravelAccumulator >= Cmd.Settings.FrameSpaceBetweenTrays THEN
					
			MC_BR_TrkFrmCreate_Tray.Parameters.LatchedPath.Position := MpAxisConv2.Position;
			FOR i:= 0 TO NUMBER_OF_FRAMES_INDEX DO
				TrayContent[i].LatchedPath.Position := MpAxisConv2.Position;
			END_FOR	
		
			MC_BR_TrkFrmsCreate_TrayContent.Execute := TRUE;	
			MC_BR_TrkFrmCreate_Tray.Execute := TRUE;

			TravelAccumulator := TravelAccumulator - Cmd.Settings.FrameSpaceBetweenTrays;
		END_IF;
		
	END_IF
	
	(* 5. Store position for next cycle *)
	LastConveyorPos := MpAxisConv2.Position;
				
	// Wait for Done
	IF MC_BR_TrkFrmsCreate_TrayContent.Done = TRUE OR MC_BR_TrkFrmsCreate_TrayContent.Error = TRUE THEN
		MC_BR_TrkFrmsCreate_TrayContent.Execute := FALSE;
	END_IF
			
	// Wait for Done
	IF MC_BR_TrkFrmCreate_Tray.Done = TRUE OR MC_BR_TrkFrmCreate_Tray.Error = TRUE THEN
		MC_BR_TrkFrmCreate_Tray.Execute := FALSE;
	END_IF	
	
END_ACTION
