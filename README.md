# Simple-Camera-control-system-
This is a simple camera control system. It can be used as a base design to build complex designs of camera control systems.

## Language 
VHDL

## Modules Description
1. CAMERA      : It is the top module of the camera control system.
2. DISP_DRV    : It converts the output signals into a form suitable for display device.
3. DISP_CTRL   : It selects the relevant data for the 7-segment display.
4. DECODER     : It preprocesses the signals from the input device for the controller.
5. MOTOR_TIMER : It is used to detect malfunctions in the motors. 
              For example if the servo motor fails to transport image within 2 sec, an error signal is generated
6. EXP_CTRL    : It opens the lens shutter for the selected exposure time and counts the number of photos taken.
7. EXP_FF      : It is a latch which stores the selected exposure time.
8. MAIN_CTRL   : It is the central control unit which coordinates the actions of all the different modules in the design.
