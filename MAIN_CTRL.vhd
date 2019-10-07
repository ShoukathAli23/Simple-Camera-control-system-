----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2019 00:45:36
-- Design Name: 
-- Module Name: MAIN_CTRL - RTL
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MAIN_CTRL is
  port(CLK      : in  std_ulogic;
       RESET      : in  std_ulogic;
       TRIGGER     : in  std_ulogic;
       EXPOSE      : in  std_ulogic;
       MOTOR_READY : in  std_ulogic;
       MOTOR_ERROR : in  std_ulogic;
       ERROR       : out std_ulogic;
       TIMER_GO    : out std_ulogic;
       MOTOR_GO    : out std_ulogic);
end MAIN_CTRL;

architecture RTL of MAIN_CTRL is
  type T_STATE is (IDLE, TAKE_PIC, DELAY,
    WAIT_EXP_TIME, FILM_TRANSPORT,
    WAIT_TRANSPORT, BROKEN);
  signal STATE:      T_STATE;
  signal NEXT_STATE: T_STATE;
begin
  process (STATE, TRIGGER, EXPOSE,
           MOTOR_ERROR, MOTOR_READY)
  begin
    NEXT_STATE <= STATE;
    case STATE is
      when IDLE =>
        if TRIGGER = '1' then
          NEXT_STATE <= TAKE_PIC;
        end if;
      when TAKE_PIC =>
        NEXT_STATE <= DELAY;
      when DELAY =>
        NEXT_STATE <= WAIT_EXP_TIME;
      when WAIT_EXP_TIME =>
        if EXPOSE = '0' then
          NEXT_STATE <= FILM_TRANSPORT;
        end if;
      when FILM_TRANSPORT =>
        NEXT_STATE <= WAIT_TRANSPORT;
      when WAIT_TRANSPORT =>
        if MOTOR_ERROR = '1' then
          NEXT_STATE <= BROKEN;
        elsif MOTOR_READY = '1' then
          NEXT_STATE <= IDLE;
        end if;
      when others =>
        NULL;
    end case;
  end process;

  process (CLK, RESET)
  begin
    if (RESET = '1') then
      STATE <= IDLE;
    elsif (CLK'event and CLK = '1') then
      STATE <= NEXT_STATE;
    end if;     -- end of clocked process
  end process;
  with STATE select
    TIMER_GO <= '1' when TAKE_PIC,
                '0' when others;

  with STATE select
    MOTOR_GO <= '1' when FILM_TRANSPORT,
                '0' when others;

  with STATE select
    ERROR    <= '1' when BROKEN,
                '0' when others;
end RTL;
