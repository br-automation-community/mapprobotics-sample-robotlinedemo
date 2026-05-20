# mapprobotics-sample-robotlinedemo

## Scope

This sample demonstrates a 6-delta-robot pick-and-place application using B&R's mapp Robotics and Conveyor Tracking technologies. The robots pick individual objects from a conveyor and place them into trays with 2 layers.

It contains a very simple conveyor speed controller that makes sure that the conveyor belt containing the trays is smoothly slowed down, to ensure all tray positions are filled.

https://github.com/user-attachments/assets/027d6f4d-309f-40dc-9b01-664d002a4455


## Prerequisites

- B&R Automation Studio 6.5.2 or later
- Automation Runtime 6.6.2
- mapp Motion 6.7.2
- mapp View 6.5.0  
- OPC UA C/S 6.6.1  
- Scene Viewer 6.3.2
- Basic understanding of Structured Text and robot Motion Structured Text (MotionST) programming
- Familiarity with mapp Robotics and Conveyor Tracking concepts
- Powerful PC/Notebook to run the project on Windows (simulation mode) or B&R Automation PC (see project configuration) to run the project on an actual target


## How to Run the Simulation

1. Open `RobotLineDemo.apj` (ensure required technology packages are installed)
2. Activate Simulation mode
3. Transfer to target (ArSim - Offline commissioning)
4. Open Watch window for 'MovePrg' task (Logical View → Tasks) and add 'Cmd' structure
5. Set `Start` to `TRUE`
6. Open 3D visualization (Logical View → Scene → Custom -> ObjectHierarchyCustom.scn)
7. In Scene Viewer: Online → OPC UA → Connect
    - Target: `127.0.0.3` (for Windows simulation; use IP address of your APC to connect to the physical target)
    - Username: `User`
    - Password: `1234`
8. Click 'OK' to connect the 3D visualization to the simulated PLC


## Main components used in this Automation Studio project

- Component **AxesGroup**
  - AxesGroup feature **Tracking**
  - AxesGroup feature **TrackingFrame selection**
    - With defined Selection Areas
  - AxesGroup feature **Programs**
- Component **TrackingPath**


## Notes

- **Troubleshooting**: Check Logger for error entries if issues occur
- **Troubleshooting**: If you see "undesired stops on path" in the logger during simulation, very likely the PC is not powerful enough or the anti virus software slows down the path planner execution
- **Error Recovery**: Restart the simulated PLC to recover from errors

