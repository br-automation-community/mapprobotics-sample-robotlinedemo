
TYPE
	CommandType : 	STRUCT 
		Start : BOOL;
		Stop : BOOL;
		ErrorReset : BOOL;
		Settings : CmdSettingsType;
		Details : CmdDetailType;
	END_STRUCT;
	CmdSettingsType : 	STRUCT 
		FrameSpaceConveyor1 : LREAL;
		FrameSpaceBetweenTrays : LREAL;
		VelocityConveyor1 : REAL;
		VelocityConveyor2 : REAL;
		HighlightSelectedProducts : BOOL;
	END_STRUCT;
	StateType : 
		(
		STARTUP,
		WAIT_FOR_POWER_AND_HOME,
		POWER,
		HOME,
		READ_CURRENT_PARAMETERS,
		START_CONVEYOR_BELTS,
		RUN,
		STOP,
		ERROR_RESET
		);
	GrippedObjectType : 	STRUCT 
		OrangeObjectInGripperRob1 : BOOL;
		OrangeObjectInGripperRob2 : BOOL;
		OrangeObjectInGripperRob3 : BOOL;
		OrangeObjectInGripperRob4 : BOOL;
		OrangeObjectInGripperRob5 : BOOL;
		OrangeObjectInGripperRob6 : BOOL;
		GreyObjectInGripperRob1 : BOOL;
		GreyObjectInGripperRob2 : BOOL;
		GreyObjectInGripperRob3 : BOOL;
		GreyObjectInGripperRob4 : BOOL;
		GreyObjectInGripperRob5 : BOOL;
		GreyObjectInGripperRob6 : BOOL;
	END_STRUCT;
	CmdDetailType : 	STRUCT 
		MoveConveyor1 : BOOL;
		MoveConveyor2 : BOOL;
		MoveRobotPrograms : BOOL;
		AutoCreationPath1 : BOOL;
		AutoCreationPath2 : BOOL;
		State : StateType;
	END_STRUCT;
END_TYPE
