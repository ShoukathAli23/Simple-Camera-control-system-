----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2019 00:34:50
-- Design Name: 
-- Module Name: DISP_CTRL - RTL
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

entity DISP_CTRL is
  port(CLK       : in  std_ulogic;
       RESET    : in  std_ulogic;
       SWITCH    : in  std_ulogic;
       KEY       : in  T_DIGITS;
       SHOW_TIME : out std_ulogic);
end DISP_CTRL;

architecture RTL of DISP_CTRL is
  signal SHOW_STATE: std_ulogic;
begin
  SHOW_TIME <= SHOW_STATE;

  process (CLK, RESET)
    variable LAST_SWITCH: std_ulogic;
  begin
    if (RESET = '1') then
      LAST_SWITCH := '0';
      SHOW_STATE  <= '0';
    elsif (CLK'event and CLK = '1') then
      if KEY /= (0,0,0) then
        SHOW_STATE <= '1';
      else
        if LAST_SWITCH = '0' and
           SWITCH = '1' then
          SHOW_STATE <= not(SHOW_STATE);
        end if;
      end if;
      LAST_SWITCH := SWITCH;
    end if;     -- end of clocked process
  end process;
end RTL;
