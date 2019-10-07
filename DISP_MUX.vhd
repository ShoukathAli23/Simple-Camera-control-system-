----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2019 21:31:18
-- Design Name: 
-- Module Name: DISP_MUX - RTL
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

entity DISP_MUX is
  port(EXP_TIME     : in  T_DIGITS;
       NO_PICS      : in  T_DIGITS;
       SHOW_TIME    : in  std_ulogic;
       ERROR        : in  std_ulogic;
       DISP_PHOTO   : out T_DIGITS);
end DISP_MUX;

architecture RTL of DISP_MUX is

begin
  process (SHOW_TIME, NO_PICS, EXP_TIME,
           ERROR)
  begin
    if ERROR = '1' then
      DISP_PHOTO <= (10, 10, 10);
    elsif SHOW_TIME = '0' then
      DISP_PHOTO <= NO_PICS;
    else
      DISP_PHOTO <= EXP_TIME;
    end if;
  end process;
end RTL;
