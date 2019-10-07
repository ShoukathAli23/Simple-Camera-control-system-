----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2019 00:40:26
-- Design Name: 
-- Module Name: MOTOR_TIMER - RTL
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

entity MOTOR_TIMER is
  port(CLK      : in  std_ulogic;
       RESET      : in  std_ulogic;
       MOTOR_GO    : in  std_ulogic;
       MOTOR_READY : in  std_ulogic;
       MOTOR_ERROR : out std_ulogic);
end MOTOR_TIMER;

architecture RTL of MOTOR_TIMER is
begin
  process (CLK, RESET)
    variable COUNTER : integer
                        range 0 to 16383;
    variable COUNT : std_ulogic;
  begin
    if (RESET = '1') then
      COUNTER     := 0;
      COUNT     := '0';
      MOTOR_ERROR <= '0';

    elsif (CLK'event and CLK = '1') then
      MOTOR_ERROR <= '0';


      if MOTOR_GO = '1' then
        COUNT := '1';
        COUNTER := 0;
      end if;

      if MOTOR_READY = '1' then
        COUNT := '0';
      end if;

      if COUNT = '1' then
        if COUNTER /= 16383 then
          COUNTER := COUNTER + 1;
        else
          MOTOR_ERROR <= '1';
          COUNT := '0';
        end if;
      end if;   -- if COUNTING
    end if;     -- end of clocked process
  end process;
end RTL;
