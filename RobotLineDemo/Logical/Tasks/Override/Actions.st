ACTION OutfeedConveyorOverrideCtrl:

(*
 * Simple conveyor belt speed controller (proportional controller) that controls outfeed conveyor belt override 
 * based on product density at the last robot that can fill product trays
 *)
	IF MC_BR_TrackingPathGetFrames_0.Done THEN
		
		index := 0;
		frameCount := 0;
		StopZoneReached := FALSE;
		WHILE index < MC_BR_TrackingPathGetFrames_0.TrackingFrameCount DO
			
			IF NOT BIT_TST(McTrkFrmInfoTypeArray[index].Attribute, 10) AND NOT BIT_TST(McTrkFrmInfoTypeArray[index].Attribute, 11) THEN	// 1024 and 2048
			
				IF McTrkFrmInfoTypeArray[index].Distance > LowerX 
					AND McTrkFrmInfoTypeArray[index].Distance < UpperX  THEN 	
					frameCount := frameCount + 1;
				END_IF
				
				IF McTrkFrmInfoTypeArray[index].Distance > MaxX THEN
					StopZoneReached := TRUE;
				END_IF	
				
			END_IF
			index := index + 1;
		END_WHILE
		
		Density := frameCount;
		
		// Override = 1 at Setpoint; adjusts linearly with slope, clamped
		Override := 1 + Slope * (Setpoint - Density);
		IF StopZoneReached THEN
			Override := MinOverride;
		ELSIF Override > MaxOverride THEN
			Override := MaxOverride;
		ELSIF Override < MinOverride THEN
			Override := MinOverride;
		END_IF;
		
		gOverride := Override;
	
	ELSIF MC_BR_TrackingPathGetFrames_0.Execute THEN
		MC_BR_TrackingPathGetFrames_0.Execute := FALSE;	
	ELSE
		MC_BR_TrackingPathGetFrames_0.Execute := TRUE;
	END_IF
	
	MC_SetOverride_0.VelFactor := gOverride;
	
	MC_BR_TrackingPathGetFrames_0();
	MC_SetOverride_0();

END_ACTION
