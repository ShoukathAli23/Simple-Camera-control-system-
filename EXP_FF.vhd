----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2019 00:29:40
-- Design Name: 
-- Module Name: EXP_FF - RTL
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


entity EXP_FF is
port(CLK : in  std_ulogic;
     RESET : in  std_ulogic;
     KEY : in  T_DIGITS;
     EXP_TIME : out T_DIGITS);
end EXP_FF;

architecture RTL of EXP_FF is
begin
  process(CLK, RESET)
  begin
    if (RESET = '1') then
      EXP_TIME <= (0,0,1);

    elsif (CLK'event and CLK = '1') then
      if (KEY /= (0,0,0)) then
        EXP_TIME <= KEY;
      end if;
    end if;
  end process;
end RTL;
