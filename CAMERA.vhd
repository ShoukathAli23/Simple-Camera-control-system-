----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2019 00:59:34
-- Design Name: 
-- Module Name: CAMERA - RTL
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.DISPLAY_PACKAGE.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CAMERA is
  port( CLK     : in  std_ulogic;
        RESET   : in  std_ulogic;
        TRIGGER : in  std_ulogic;
        SWITCH  : in  std_ulogic;
        KEYPAD  : in  std_ulogic_vector(9 downto 0);
        MOTOR_READY : in     std_ulogic;
        EXPOSE  : buffer std_ulogic;
        DISPLAY : out T_DISPLAY);
end CAMERA;

architecture STRUCT of CAMERA is

  component DISP_DRV
  port (ERROR      : in  std_ulogic;
       SHOW_TIME  : in  std_ulogic;
       NO_PICS    : in  T_DIGITS;
       EXP_TIME   : in  T_DIGITS;
       DISPLAY    : out T_DISPLAY);
  end component;
  
  component DECODER
  port (KEYPAD : in  std_ulogic_vector(9 downto 0);
        KEY : out T_DIGITS);
  end component;
  component EXP_FF
port(CLK : in  std_ulogic;
     RESET : in  std_ulogic;
     KEY : in  T_DIGITS;
     EXP_TIME : out T_DIGITS);
  end component;
  component DISP_CTRL
  port(CLK       : in  std_ulogic;
       RESET    : in  std_ulogic;
       SWITCH    : in  std_ulogic;
       KEY       : in  T_DIGITS;
       SHOW_TIME : out std_ulogic);
  end component;
  component MOTOR_TIMER
  port(CLK      : in  std_ulogic;
       RESET      : in  std_ulogic;
       MOTOR_GO    : in  std_ulogic;
       MOTOR_READY : in  std_ulogic;
       MOTOR_ERROR : out std_ulogic);
  end component;
  component EXP_CTRL
  port(CLK : in std_ulogic;
       RESET : in std_ulogic;
       TIMER_GO : in std_ulogic;
       EXP_TIME : in T_DIGITS;
       EXPOSE : buffer std_ulogic;
       NO_PICS : buffer T_DIGITS);
  end component;
  component MAIN_CTRL
  port(CLK      : in  std_ulogic;
       RESET      : in  std_ulogic;
       TRIGGER     : in  std_ulogic;
       EXPOSE      : in  std_ulogic;
       MOTOR_READY : in  std_ulogic;
       MOTOR_ERROR : in  std_ulogic;
       ERROR       : out std_ulogic;
       TIMER_GO    : out std_ulogic;
       MOTOR_GO    : out std_ulogic);
  end component;

  signal W_KEY         : T_DIGITS;
  signal W_NO_PICS     : T_DIGITS;
  signal W_EXP_TIME    : T_DIGITS;
  signal W_SHOW_TIME   : std_ulogic;
  signal W_TIMER_GO    : std_ulogic;
  signal W_MOTOR_GO    : std_ulogic;
  signal W_MOTOR_ERROR : std_ulogic;
  signal W_ERROR       : std_ulogic;
  
begin
  U_DISP_DRV  : DISP_DRV  
  port map( ERROR      => W_ERROR,
            SHOW_TIME  => W_SHOW_TIME,
            NO_PICS    => W_NO_PICS,
            EXP_TIME   => W_EXP_TIME,
            DISPLAY    => DISPLAY );
            
  U_DECODER   : DECODER   
  port map( KEYPAD      => KEYPAD,
            KEY         => W_KEY );
            
  U_EXP_FF    : EXP_FF    
  port map( CLK         => CLK,
            RESET       => RESET, 
            KEY         => W_KEY,
            EXP_TIME    => W_EXP_TIME );
  
  U_DISP_CTRL : DISP_CTRL 
  port map( CLK         => CLK,
            RESET       => RESET,
            SWITCH      => SWITCH,
            KEY         => W_KEY,
            SHOW_TIME   => W_SHOW_TIME );
  
  U_MOTOR_TIMER : MOTOR_TIMER 
  port map( CLK         => CLK,
            RESET       => RESET,
            MOTOR_GO    => W_MOTOR_GO,
            MOTOR_READY => MOTOR_READY,
            MOTOR_ERROR => W_MOTOR_ERROR );
  
  U_EXP_CTRL  : EXP_CTRL  
  port map( CLK         => CLK,
            RESET       => RESET,
            TIMER_GO    => W_TIMER_GO,
            EXP_TIME    => W_EXP_TIME,
            EXPOSE      => EXPOSE,
            NO_PICS     => W_NO_PICS );
  
  U_MAIN_CTRL : MAIN_CTRL 
  port map( CLK      => CLK,
            RESET    => RESET,
            TRIGGER    => TRIGGER,
            EXPOSE     => EXPOSE,
            MOTOR_READY => MOTOR_READY,
            MOTOR_ERROR => W_MOTOR_ERROR,
            ERROR       => W_ERROR,
            TIMER_GO    => W_TIMER_GO,
            MOTOR_GO    => W_MOTOR_GO );
  
end STRUCT;
