TYPE
	MachineState : (Start, SelectPickPosition, PickObject, SelectPlacePosition, PlaceObject, ParkWithNoObject, ParkWithGrippedObject);
END_TYPE
 
VAR CONSTANT
    ParkPos      : McPointType := (Pos:=(X:=0, Y:=-300, Z:=0));
	PickSynchPosUp   : McPointType := (Pos:=(X:=   0, Y:= 0,  Z:= 70));
	PlaceSynchPosUp   : McPointType := (Pos:=(X:=   0, Y:= 0,  Z:= 70));
    SynchPosDown : McPointType := (Pos:=(X:=   0, Y:= 0,  Z:= 0));
END_VAR
 
VAR
    TrkFrmID_PickPosition: McTrkFrmIdentType;
    TrkFrmID_PlacePosition: McTrkFrmIdentType;
	State : MachineState;  
END_VAR

VAR {AT 'MovePrg'} 
	Cmd : CommandType;
END_VAR
  
PROGRAM _MAIN
      
    State := MachineState#Start;
     
    REPEAT
        CASE State OF
         
        MachineState#Start:
            MoveLR(ParkPos);                                   
            WaitUntilSync(TrackingFrameIsAvailable('ProductSelector'));
            State := MachineState#SelectPickPosition;
         
        MachineState#SelectPickPosition:
			WaitALAP();		
			TrackingFrameSelectorSetAttributeMasks('ProductSelector', 2#0000_0000, 2#0000_0000, 2#0000_0000);		
			IF TrackingFrameSelect(TrkFrmID_PickPosition, 'ProductSelector') THEN
				State :=  MachineState#PickObject;
			ELSE	
				State := MachineState#ParkWithNoObject;
			END_IF
             
		MachineState#PickObject:
			IF Cmd.Settings.HighlightSelectedProducts THEN
				TrackingFrameSetAttribute(IP_EVAL(TrkFrmID_PickPosition), 1);
			END_IF	
            TrackObjectR(TrkFrmID_PickPosition, PickSynchPosUp, 50, 50);
			MoveLR(SynchPosDown);	
				CloseGripper := TRUE;	//close gripper
			WaitTime(0.050);			//wait until gripper is closed [s]
			SetProductLoad('ProductLoad_1');
            MoveLR(PickSynchPosUp);
            State := MachineState#SelectPlacePosition;
         
        MachineState#SelectPlacePosition:
			WaitALAP();
			TrackingFrameSelectorSetAttributeMasks('PlacePositionSelector', 2#0000_0001, 2#0000_0000, 2#1100_0000_0000); 
            IF TrackingFrameSelect(TrkFrmID_PlacePosition, 'PlacePositionSelector') THEN
                State :=  MachineState#PlaceObject;
			ELSE
				TrackingFrameSelectorSetAttributeMasks('PlacePositionSelector', 2#0000_0010, 2#0000_0000, 2#1100_0000_0000);
				IF TrackingFrameSelect(TrkFrmID_PlacePosition, 'PlacePositionSelector') THEN
					State := MachineState#PlaceObject;
				ELSE
					State := MachineState#ParkWithGrippedObject;	
				END_IF		
			END_IF
         
        MachineState#PlaceObject:
            TrackObjectR(TrkFrmID_PlacePosition, PlaceSynchPosUp, 50, 50);
            MoveLR(SynchPosDown);
			CloseGripper := FALSE;	//open gripper
			DO_PATH_SYNCH
				TrackingFrameSetAttribute(IP_EVAL(TrkFrmID_PlacePosition), 2048);
			END_PATH_SYNCH
			WaitTime(0.050);		//wait until gripper is opened [s]
			ResetProductLoad();
            MoveLR(PlaceSynchPosUp);
            State := MachineState#SelectPickPosition;   
 
        MachineState#ParkWithNoObject:
			TrackStopR(MachineFrame, ParkPos, 50, 50);
			TrackingFrameSelectorSetAttributeMasks('ProductSelector', 2#0000_0000, 2#0000_0000, 2#0000_0000);			
			WaitUntilSync(TrackingFrameSelect(TrkFrmID_PickPosition, 'ProductSelector'));
            State := MachineState#PickObject;        
         
        MachineState#ParkWithGrippedObject:
			TrackStopR(MachineFrame, ParkPos, 50, 50);

			TrackingFrameSelectorSetAttributeMasks('PlacePositionSelector', 2#0000_0000, 2#0000_0000, 2#1100_0000_0000); 
			WaitUntilSync(TrackingFrameIsAvailable('PlacePositionSelector'));
				
			TrackingFrameSelectorSetAttributeMasks('PlacePositionSelector', 2#0000_0001, 2#0000_0000, 2#1100_0000_0000); 
			IF TrackingFrameSelect(TrkFrmID_PlacePosition, 'PlacePositionSelector') THEN
				State :=  MachineState#PlaceObject;
			ELSE
				TrackingFrameSelectorSetAttributeMasks('PlacePositionSelector', 2#0000_0010, 2#0000_0000, 2#1100_0000_0000);
				IF TrackingFrameSelect(TrkFrmID_PlacePosition, 'PlacePositionSelector') THEN
					State := MachineState#PlaceObject;
				ELSE
					State := MachineState#ParkWithGrippedObject;	
				END_IF
			END_IF
				
		END_CASE     
		
	UNTIL FALSE END_REPEAT;
      
END_PROGRAM
