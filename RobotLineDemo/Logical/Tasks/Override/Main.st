PROGRAM _INIT
	
	MinOverride := 0;
	MaxOverride := 1;
	
	MC_BR_TrackingPathGetFrames_0.TrackingPath := ADR(gTrkPath_Conveyor_2);
	MC_BR_TrackingPathGetFrames_0.Parameters.GetMode := mcTRKPATH_GET_MOD_ALL_FRAMES;
	MC_BR_TrackingPathGetFrames_0.Parameters.InfoMode := mcTRKPATH_INFO_MOD_DIST;
	MC_BR_TrackingPathGetFrames_0.Parameters.DataAddress := ADR(McTrkFrmInfoTypeArray);
	MC_BR_TrackingPathGetFrames_0.Parameters.NumberOfFrames := 500;
	
	Setpoint := 1.0;
	Slope := 0.2;
	LowerX := 5400.0;
	UpperX := 7000.0;
	MaxX := 6000.0;
	Override := 1;
	gOverride := 1;
	
	MC_SetOverride_0.Axis := ADR(gAxis_Conveyor_2);
	MC_SetOverride_0.VelFactor := 1.0;
	MC_SetOverride_0.AccFactor := 1.0;
	MC_SetOverride_0.Enable := TRUE;
	
END_PROGRAM


PROGRAM _CYCLIC	
	OutfeedConveyorOverrideCtrl;		
END_PROGRAM

		
PROGRAM _EXIT

END_PROGRAM

