----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2019 22:09:17
-- Design Name: 
-- Module Name: DISP_DRV - Behavioral
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

entity DISP_DRV is
  port(ERROR      : in  std_ulogic;
       SHOW_TIME  : in  std_ulogic;
       NO_PICS    : in  T_DIGITS;
       EXP_TIME   : in  T_DIGITS;
       DISPLAY    : out T_DISPLAY);
end DISP_DRV;

architecture RTL of DISP_DRV is
  component DISP_MUX is
    port(EXP_TIME : in  T_DIGITS;
       NO_PICS    : in  T_DIGITS;
       SHOW_TIME  : in  std_ulogic;
       ERROR      : in  std_ulogic;
       DISP_PHOTO : out T_DIGITS);
  end component;
  
  signal W_DISP_PHOTO : T_DIGITS;

begin

  DSP_MUX:DISP_MUX
  port map(
      EXP_TIME   => EXP_TIME,
      NO_PICS    => NO_PICS,
      SHOW_TIME  => SHOW_TIME,
      ERROR      => ERROR, 
      DISP_PHOTO => W_DISP_PHOTO);  
  

  DECODE: process (W_DISP_PHOTO)
  begin
  for I in 0 to 2 loop
    case W_DISP_PHOTO(I) is
      when 0     => DISPLAY(I) <= SEG_0;
      when 1     => DISPLAY(I) <= SEG_1;
      when 2     => DISPLAY(I) <= SEG_2;
      when 3     => DISPLAY(I) <= SEG_3;
      when 4     => DISPLAY(I) <= SEG_4;
      when 5     => DISPLAY(I) <= SEG_5;
      when 6     => DISPLAY(I) <= SEG_6;
      when 7     => DISPLAY(I) <= SEG_7;
      when 8     => DISPLAY(I) <= SEG_8;
      when 9     => DISPLAY(I) <= SEG_9;
      when others => DISPLAY(I) <= SEG_E;
    end case;
  end loop;
  end process DECODE;
end RTL;
