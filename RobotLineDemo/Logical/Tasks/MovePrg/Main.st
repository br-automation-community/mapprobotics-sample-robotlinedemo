
PROGRAM _INIT
	
	//Initial process parameters
	Cmd.Settings.FrameSpaceConveyor1 := 305.0;
	Cmd.Settings.FrameSpaceBetweenTrays := 220;
	Cmd.Settings.VelocityConveyor1 := 760.0;
	Cmd.Settings.VelocityConveyor2 := 450.0;

	// Robots
	MpRobotPar1.ProgramName := 'pnpPrgR1.st';
	MpRobotPar2.ProgramName := 'pnpPrgR2.st';
	MpRobotPar6.ProgramName := 'pnpPrgR6.st';
	MpRobot_0.MpLink := ADR(gAxesGroup_D4r1100R_1);
	MpRobot_0.Enable := TRUE;
	MpRobot_0.Parameters := ADR(MpRobotPar1);
	MpRobot_0.Override := 100;
	MpRobot_1.MpLink := ADR(gAxesGroup_D4r1100R_2);
	MpRobot_1.Enable := TRUE;
	MpRobot_1.Parameters := ADR(MpRobotPar2);
	MpRobot_1.Override := 100;
	MpRobot_2.MpLink := ADR(gAxesGroup_D4r1100R_3);
	MpRobot_2.Enable := TRUE;
	MpRobot_2.Parameters := ADR(MpRobotPar2);
	MpRobot_2.Override := 100;
	MpRobot_3.MpLink := ADR(gAxesGroup_D4r1100R_4);
	MpRobot_3.Enable := TRUE;
	MpRobot_3.Parameters := ADR(MpRobotPar2);
	MpRobot_3.Override := 100;
	MpRobot_4.MpLink := ADR(gAxesGroup_D4r1100R_5);
	MpRobot_4.Enable := TRUE;
	MpRobot_4.Parameters := ADR(MpRobotPar2);
	MpRobot_4.Override := 100;
	MpRobot_5.MpLink := ADR(gAxesGroup_D4r1100R_6);
	MpRobot_5.Enable := TRUE;
	MpRobot_5.Parameters := ADR(MpRobotPar6);
	MpRobot_5.Override := 100;
	
	// Conveyor belts
	MpAxisParConv1.Velocity := Cmd.Settings.VelocityConveyor1;
	MpAxisParConv1.Acceleration := 100;
	MpAxisParConv1.Deceleration := 300;

	MpAxisParConv2.Velocity := Cmd.Settings.VelocityConveyor2;
	MpAxisParConv2.Acceleration := 100;
	MpAxisParConv2.Deceleration := 200;
	
	MpAxisConv1.MpLink := ADR(gAxis_Conveyor_1);
	MpAxisConv1.Parameters := ADR(MpAxisParConv1);
	MpAxisConv1.Enable := TRUE;
	
	MpAxisConv2.MpLink := ADR(gAxis_Conveyor_2);
	MpAxisConv2.Parameters := ADR(MpAxisParConv2);
	MpAxisConv2.Enable := TRUE;
	
	StatusTrackingPath1.Enable := TRUE;
	StatusTrackingPath2.Enable := TRUE;
	StatusTrackingPath1.TrackingPath := ADR(gTrkPath_Conveyor_1);
	StatusTrackingPath2.TrackingPath := ADR(gTrkPath_Conveyor_2);

	GripperRobot1OpenClose := FALSE; // Open
	GripperRobot2OpenClose := FALSE; // Open
	GripperRobot3OpenClose := FALSE; // Open
	GripperRobot4OpenClose := FALSE; // Open
	GripperRobot5OpenClose := FALSE; // Open
	GripperRobot6OpenClose := FALSE; // Open
	
	MC_BR_TrackingPathReset_0.TrackingPath := ADR(gTrkPath_Conveyor_1);
	MC_BR_TrackingPathReset_1.TrackingPath := ADR(gTrkPath_Conveyor_2);
	
	MC_BR_TrackingFrameDelete_0.TrackingPath := ADR(gTrkPath_Conveyor_1);
	MC_BR_TrackingFrameDelete_0.Mode := mcTRKFRM_DELETE_MOD_ALL;
	MC_BR_TrackingFrameDelete_1.TrackingPath := ADR(gTrkPath_Conveyor_2);
	MC_BR_TrackingFrameDelete_1.Mode := mcTRKFRM_DELETE_MOD_ALL;
	
	MC_BR_TrkFrmsCreate_TrayContent.TrackingPath := ADR(gTrkPath_Conveyor_2);
	MC_BR_TrkFrmsCreate_TrayContent.Parameters.DataAddress := ADR(TrayContent);
	MC_BR_TrkFrmsCreate_TrayContent.Parameters.NumberOfFrames := 4;

	TrayContent[0].Translation.X := 0.0;
	TrayContent[0].Translation.Y := -70;
	TrayContent[0].Translation.Z := 0;
	TrayContent[0].Orientation.Angle3 := 180;
	TrayContent[0].Attribute := 1;
	
	TrayContent[1].Translation.X := 0.0;
	TrayContent[1].Translation.Y := 70;
	TrayContent[1].Translation.Z := 0;
	TrayContent[1].Orientation.Angle3 := 180;
	TrayContent[1].Attribute := 1;
	
	TrayContent[2].Translation.X := 0.0;
	TrayContent[2].Translation.Y := -70.0;
	TrayContent[2].Translation.Z := 50.0;
	TrayContent[2].Orientation.Angle3 := 180;
	TrayContent[2].Attribute := 2;
	
	TrayContent[3].Translation.X := 0.0;
	TrayContent[3].Translation.Y := 70.0;
	TrayContent[3].Translation.Z := 50.0;
	TrayContent[3].Orientation.Angle3 := 180;
	TrayContent[3].Attribute := 2;
	
	MC_BR_TrkFrmCreate_Tray.TrackingPath := ADR(gTrkPath_Conveyor_2);
	MC_BR_TrkFrmCreate_Tray.Parameters.Attribute := 1024;
	MC_BR_TrkFrmCreate_Tray.Parameters.Translation.X := 0;
	MC_BR_TrkFrmCreate_Tray.Parameters.Translation.Y := 0;
	MC_BR_TrkFrmCreate_Tray.Parameters.Orientation.Angle3 := 90;
	
	Cmd.Details.AutoCreationPath1 :=  TRUE;
	Cmd.Details.AutoCreationPath2 :=  TRUE;
	
	Cmd.Settings.HighlightSelectedProducts := TRUE;
	
END_PROGRAM


PROGRAM _CYCLIC

	IF Cmd.Settings.HighlightSelectedProducts THEN
		GrippersVisu.GreyObjectInGripperRob1 := FALSE;
		GrippersVisu.GreyObjectInGripperRob2 := FALSE;
		GrippersVisu.GreyObjectInGripperRob3 := FALSE;
		GrippersVisu.GreyObjectInGripperRob4 := FALSE;
		GrippersVisu.GreyObjectInGripperRob5 := FALSE;
		GrippersVisu.GreyObjectInGripperRob6 := FALSE;
		
		GrippersVisu.OrangeObjectInGripperRob1 := GripperRobot1OpenClose;
		GrippersVisu.OrangeObjectInGripperRob2 := GripperRobot2OpenClose;
		GrippersVisu.OrangeObjectInGripperRob3 := GripperRobot3OpenClose;
		GrippersVisu.OrangeObjectInGripperRob4 := GripperRobot4OpenClose;
		GrippersVisu.OrangeObjectInGripperRob5 := GripperRobot5OpenClose;
		GrippersVisu.OrangeObjectInGripperRob6 := GripperRobot6OpenClose;
	ELSE
		GrippersVisu.OrangeObjectInGripperRob1 := FALSE;
		GrippersVisu.OrangeObjectInGripperRob2 := FALSE;
		GrippersVisu.OrangeObjectInGripperRob3 := FALSE;
		GrippersVisu.OrangeObjectInGripperRob4 := FALSE;
		GrippersVisu.OrangeObjectInGripperRob5 := FALSE;
		GrippersVisu.OrangeObjectInGripperRob6 := FALSE;
		
		GrippersVisu.GreyObjectInGripperRob1 := GripperRobot1OpenClose;
		GrippersVisu.GreyObjectInGripperRob2 := GripperRobot2OpenClose;
		GrippersVisu.GreyObjectInGripperRob3 := GripperRobot3OpenClose;
		GrippersVisu.GreyObjectInGripperRob4 := GripperRobot4OpenClose;
		GrippersVisu.GreyObjectInGripperRob5 := GripperRobot5OpenClose;
		GrippersVisu.GreyObjectInGripperRob6 := GripperRobot6OpenClose;
	END_IF
	
	// User Interface update
	MpRobot_0.MoveProgram := Cmd.Details.MoveRobotPrograms;
	MpRobot_1.MoveProgram := Cmd.Details.MoveRobotPrograms;
	MpRobot_2.MoveProgram := Cmd.Details.MoveRobotPrograms;
	MpRobot_3.MoveProgram := Cmd.Details.MoveRobotPrograms;
	MpRobot_4.MoveProgram := Cmd.Details.MoveRobotPrograms;
	MpRobot_5.MoveProgram := Cmd.Details.MoveRobotPrograms;
	MpAxisConv1.MoveVelocity := Cmd.Details.MoveConveyor1;
	MpAxisConv2.MoveVelocity := Cmd.Details.MoveConveyor2;	
	
	IF Cmd.ErrorReset THEN
		Cmd.Details.State := ERROR_RESET;
	END_IF
	
	IF Cmd.Stop THEN
		Cmd.Details.State := STOP;
	END_IF
	
	
	// Main state machine
	CASE Cmd.Details.State OF

		STARTUP:
			
			Cmd.Details.MoveRobotPrograms := FALSE;
			Cmd.Details.MoveConveyor1 := FALSE;
			Cmd.Details.MoveConveyor2 := FALSE;
			Cmd.Start := FALSE;
			GrippersVisu.GreyObjectInGripperRob1 := FALSE;
			GrippersVisu.GreyObjectInGripperRob2 := FALSE;
			GrippersVisu.GreyObjectInGripperRob3 := FALSE;
			GrippersVisu.GreyObjectInGripperRob4 := FALSE;
			GrippersVisu.GreyObjectInGripperRob5 := FALSE;
			GrippersVisu.GreyObjectInGripperRob6 := FALSE;
			GrippersVisu.OrangeObjectInGripperRob1 := FALSE;
			GrippersVisu.OrangeObjectInGripperRob2 := FALSE;
			GrippersVisu.OrangeObjectInGripperRob3 := FALSE;
			GrippersVisu.OrangeObjectInGripperRob4 := FALSE;
			GrippersVisu.OrangeObjectInGripperRob5 := FALSE;
			GrippersVisu.OrangeObjectInGripperRob6 := FALSE;
			
			GripperRobot1OpenClose := FALSE;
			GripperRobot2OpenClose := FALSE;
			GripperRobot3OpenClose := FALSE;
			GripperRobot4OpenClose := FALSE;
			GripperRobot5OpenClose := FALSE;
			GripperRobot6OpenClose := FALSE;
			
			IF MpRobot_0.Info.ReadyToPowerOn AND MpRobot_1.Info.ReadyToPowerOn AND MpRobot_2.Info.ReadyToPowerOn AND MpRobot_3.Info.ReadyToPowerOn AND MpRobot_4.Info.ReadyToPowerOn AND MpRobot_5.Info.ReadyToPowerOn AND MpAxisConv1.Info.ReadyToPowerOn AND MpAxisConv2.Info.ReadyToPowerOn THEN
				Cmd.Details.State := WAIT_FOR_POWER_AND_HOME;
			END_IF		


		WAIT_FOR_POWER_AND_HOME:
			
			// AxesGroups are still disabled in this state and optionally ProcessParam_TrkFrmSelectionFeat FB can be used to manually manipulate the configured parameters
			IF Cmd.Start THEN
				Cmd.Details.State := POWER;
			END_IF


		POWER:
		
			MpRobot_0.Power := TRUE;
			MpRobot_1.Power := TRUE;
			MpRobot_2.Power := TRUE;
			MpRobot_3.Power := TRUE;
			MpRobot_4.Power := TRUE;
			MpRobot_5.Power := TRUE;
			MpAxisConv1.Power := TRUE;
			MpAxisConv2.Power := TRUE;
			IF MpRobot_0.PowerOn AND MpRobot_1.PowerOn AND MpRobot_2.PowerOn AND MpRobot_3.PowerOn AND MpRobot_4.PowerOn AND MpRobot_5.PowerOn AND MpAxisConv1.PowerOn AND MpAxisConv2.PowerOn THEN
				Cmd.Details.State := HOME;
			END_IF


		HOME:
		
			MpRobot_0.Home := TRUE;
			MpRobot_1.Home := TRUE;
			MpRobot_2.Home := TRUE;
			MpRobot_3.Home := TRUE;
			MpRobot_4.Home := TRUE;
			MpRobot_5.Home := TRUE;
			MpAxisConv1.Home := TRUE;
			MpAxisConv2.Home := TRUE;
			IF MpRobot_0.IsHomed AND MpRobot_1.IsHomed AND MpRobot_2.IsHomed AND MpRobot_3.IsHomed AND MpRobot_4.IsHomed AND MpRobot_5.IsHomed AND MpAxisConv1.IsHomed AND MpAxisConv2.IsHomed THEN
				Cmd.Details.State := READ_CURRENT_PARAMETERS;	
			END_IF


		READ_CURRENT_PARAMETERS:
			
			// Read current automatic creation condition parameters configured for TrackingPath components

			IF StatusTrackingPath1.TrackingPathReady AND StatusTrackingPath2.TrackingPathReady THEN
			
				ProcPar_AutCrtCond1TrkPath1_1.Execute := TRUE;
				ProcPar_AutCrtCond1TrkPath1_1.Component := ADR(gTrkPath_Conveyor_1);
				ProcPar_AutCrtCond1TrkPath1_1.AdvancedParameters.Name := 'Condition 1';
				ProcPar_AutCrtCond1TrkPath1_1.DataAddress := ADR(AutoCreateConditionParTrkPath1_1);
				ProcPar_AutCrtCond1TrkPath1_1.DataType := mcCFG_TRK_PATH_AUT_CRT_COND;
				ProcPar_AutCrtCond1TrkPath1_1.Mode := mcPPM_READ;
				
				ProcPar_AutCrtCond1TrkPath1_2.Execute := TRUE;
				ProcPar_AutCrtCond1TrkPath1_2.Component := ADR(gTrkPath_Conveyor_1);
				ProcPar_AutCrtCond1TrkPath1_2.AdvancedParameters.Name := 'Condition 2';
				ProcPar_AutCrtCond1TrkPath1_2.DataAddress := ADR(AutoCreateConditionParTrkPath1_2);
				ProcPar_AutCrtCond1TrkPath1_2.DataType := mcCFG_TRK_PATH_AUT_CRT_COND;
				ProcPar_AutCrtCond1TrkPath1_2.Mode := mcPPM_READ;
				
				ProcPar_AutCrtCond1TrkPath1_3.Execute := TRUE;
				ProcPar_AutCrtCond1TrkPath1_3.Component := ADR(gTrkPath_Conveyor_1);
				ProcPar_AutCrtCond1TrkPath1_3.AdvancedParameters.Name := 'Condition 3';
				ProcPar_AutCrtCond1TrkPath1_3.DataAddress := ADR(AutoCreateConditionParTrkPath1_3);
				ProcPar_AutCrtCond1TrkPath1_3.DataType := mcCFG_TRK_PATH_AUT_CRT_COND;
				ProcPar_AutCrtCond1TrkPath1_3.Mode := mcPPM_READ;
			END_IF
		
			IF ProcPar_AutCrtCond1TrkPath1_1.Done AND ProcPar_AutCrtCond1TrkPath1_2.Done AND ProcPar_AutCrtCond1TrkPath1_3.Done THEN
				
				AutoCreateConditionParTrkPath1_1.Condition.DistanceBased.Distance := 1.0;
				AutoCreateConditionParTrkPath1_2.Condition.DistanceBased.Distance := 1.0;
				AutoCreateConditionParTrkPath1_3.Condition.DistanceBased.Distance := 1.0;
				
				ProcPar_AutCrtCond1TrkPath1_1.Execute := FALSE;
				ProcPar_AutCrtCond1TrkPath1_2.Execute := FALSE;
				ProcPar_AutCrtCond1TrkPath1_3.Execute := FALSE;		
				
				Cmd.Details.MoveConveyor2 := TRUE;
				Cmd.Details.MoveRobotPrograms := TRUE;
				Cmd.Details.State := START_CONVEYOR_BELTS;

			END_IF
			
			MC_BR_TrkFrmsCreate_TrayContent.Execute := FALSE;

		START_CONVEYOR_BELTS:
			
			CreateTraysAndContent;
			IF gOverride < 1.0 THEN
				Cmd.Details.MoveConveyor1 := TRUE;
				Cmd.Details.State := RUN;
			END_IF
			
			
		RUN:

			// Update with commanded automatic TrackingFrame creation parameters
			IF AutoCreateConditionParTrkPath1_1.Condition.DistanceBased.Distance <> Cmd.Settings.FrameSpaceConveyor1 THEN
			
				AutoCreateConditionParTrkPath1_1.Condition.DistanceBased.Distance := Cmd.Settings.FrameSpaceConveyor1;
				AutoCreateConditionParTrkPath1_2.Condition.DistanceBased.Distance := Cmd.Settings.FrameSpaceConveyor1;
				AutoCreateConditionParTrkPath1_3.Condition.DistanceBased.Distance := Cmd.Settings.FrameSpaceConveyor1;
				
				AutoCreateConditionParTrkPath1_1.Condition.DistanceBased.Position.Translation.Y := -160;
				ProcPar_AutCrtCond1TrkPath1_1.Execute := TRUE;
				ProcPar_AutCrtCond1TrkPath1_1.Component := ADR(gTrkPath_Conveyor_1);
				ProcPar_AutCrtCond1TrkPath1_1.AdvancedParameters.Name := 'Condition 1';
				ProcPar_AutCrtCond1TrkPath1_1.DataAddress := ADR(AutoCreateConditionParTrkPath1_1);
				ProcPar_AutCrtCond1TrkPath1_1.DataType := mcCFG_TRK_PATH_AUT_CRT_COND;
				ProcPar_AutCrtCond1TrkPath1_1.Mode := mcPPM_WRITE;
				ProcPar_AutCrtCond1TrkPath1_1();
				ProcPar_AutCrtCond1TrkPath1_1.Execute := FALSE;	
			
				AutoCreateConditionParTrkPath1_2.Condition.DistanceBased.Position.Translation.Y := 0;
				ProcPar_AutCrtCond1TrkPath1_2.Execute := TRUE;
				ProcPar_AutCrtCond1TrkPath1_2.Component := ADR(gTrkPath_Conveyor_1);
				ProcPar_AutCrtCond1TrkPath1_2.AdvancedParameters.Name := 'Condition 2';
				ProcPar_AutCrtCond1TrkPath1_2.DataAddress := ADR(AutoCreateConditionParTrkPath1_2);
				ProcPar_AutCrtCond1TrkPath1_2.DataType := mcCFG_TRK_PATH_AUT_CRT_COND;
				ProcPar_AutCrtCond1TrkPath1_2.Mode := mcPPM_WRITE;
				ProcPar_AutCrtCond1TrkPath1_2();
				ProcPar_AutCrtCond1TrkPath1_2.Execute := FALSE;	
				
				AutoCreateConditionParTrkPath1_3.Condition.DistanceBased.Position.Translation.Y := 160;
				ProcPar_AutCrtCond1TrkPath1_3.Execute := TRUE;
				ProcPar_AutCrtCond1TrkPath1_3.Component := ADR(gTrkPath_Conveyor_1);
				ProcPar_AutCrtCond1TrkPath1_3.AdvancedParameters.Name := 'Condition 3';
				ProcPar_AutCrtCond1TrkPath1_3.DataAddress := ADR(AutoCreateConditionParTrkPath1_3);
				ProcPar_AutCrtCond1TrkPath1_3.DataType := mcCFG_TRK_PATH_AUT_CRT_COND;
				ProcPar_AutCrtCond1TrkPath1_3.Mode := mcPPM_WRITE;
				ProcPar_AutCrtCond1TrkPath1_3();
				ProcPar_AutCrtCond1TrkPath1_3.Execute := FALSE;	

			END_IF
			
			
			// Update commanded conveyor belt velocities
			IF MpAxisParConv1.Velocity <> Cmd.Settings.VelocityConveyor1 THEN
				MpAxisParConv1.Velocity := Cmd.Settings.VelocityConveyor1;
				MpAxisConv1.Update := TRUE;
				MpAxisConv1();
				MpAxisConv1.Update := FALSE;
			END_IF
			IF MpAxisParConv2.Velocity <> Cmd.Settings.VelocityConveyor2 THEN
				MpAxisParConv2.Velocity := Cmd.Settings.VelocityConveyor2;
				MpAxisConv2.Update := TRUE;
				MpAxisConv2();
				MpAxisConv2.Update := FALSE;
			END_IF
			
			CreateTraysAndContent;
		
			
		STOP:
			
			Cmd.Details.MoveRobotPrograms := FALSE;
			Cmd.Details.MoveConveyor1 := FALSE;
			Cmd.Details.MoveConveyor2 := FALSE;
			Cmd.Start := FALSE;
			IF NOT Cmd.Stop THEN
				Cmd.Details.State := STARTUP;
			END_IF
			
			
		ERROR_RESET:
			
			MpRobot_0.ErrorReset := TRUE;
			MpRobot_1.ErrorReset := TRUE;
			MpRobot_2.ErrorReset := TRUE;
			MpRobot_3.ErrorReset := TRUE;
			MpRobot_4.ErrorReset := TRUE;
			MpRobot_5.ErrorReset := TRUE;
			MC_BR_TrackingPathReset_0.Execute := TRUE;
			MC_BR_TrackingPathReset_1.Execute := TRUE;
			MpAxisConv1.ErrorReset := TRUE;
			MpAxisConv2.ErrorReset := TRUE;
			MC_BR_TrackingFrameDelete_0.Execute := TRUE;
			MC_BR_TrackingFrameDelete_1.Execute := TRUE;
			
			IF NOT Cmd.ErrorReset THEN
				MpRobot_0.ErrorReset := FALSE;
				MpRobot_1.ErrorReset := FALSE;
				MpRobot_2.ErrorReset := FALSE;
				MpRobot_3.ErrorReset := FALSE;
				MpRobot_4.ErrorReset := FALSE;
				MpRobot_5.ErrorReset := FALSE;
				MC_BR_TrackingPathReset_0.Execute := FALSE;
				MC_BR_TrackingPathReset_1.Execute := FALSE;
				MpAxisConv1.ErrorReset := FALSE;
				MpAxisConv2.ErrorReset := FALSE;
				MC_BR_TrackingFrameDelete_0.Execute := FALSE;
				MC_BR_TrackingFrameDelete_1.Execute := FALSE;
				Cmd.Details.State := STARTUP;
			END_IF
			
		
	END_CASE
	
	
	// Call function blocks
	MC_BR_TrackingFramesCreate_0();
	MC_BR_TrkFrmsCreate_TrayContent();
	MC_BR_TrkFrmCreate_Tray();
	MpRobot_0();
	MpRobot_1();
	MpRobot_2();
	MpRobot_3();
	MpRobot_4();
	MpRobot_5();
	MpAxisConv1();
	MpAxisConv2();
	ProcPar_AutCrtCond1TrkPath1_1();
	ProcPar_AutCrtCond1TrkPath1_2();
	ProcPar_AutCrtCond1TrkPath1_3();
	StatusTrackingPath1();
	StatusTrackingPath2();
	MC_BR_TrackingPathReset_0();
	MC_BR_TrackingPathReset_1();
	MC_BR_TrackingFrameDelete_0();
	MC_BR_TrackingFrameDelete_1();
	
END_PROGRAM


