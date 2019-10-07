----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2019 00:23:01
-- Design Name: 
-- Module Name: DECODER - Behavioral
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

entity DECODER is
  port (KEYPAD : in  std_ulogic_vector(9 downto 0);
        KEY : out T_DIGITS);
end DECODER;

architecture RTL_CASE of DECODER is -- without priority to buttons
begin
  process(KEYPAD)
  begin
    case KEYPAD is
      when "1000000000" => KEY <= (5,1,2);
      when "0100000000" => KEY <= (2,5,6);
      when "0010000000" => KEY <= (1,2,8);
      when "0001000000" => KEY <= (0,6,4);
      when "0000100000" => KEY <= (0,3,2);
      when "0000010000" => KEY <= (0,1,6);
      when "0000001000" => KEY <= (0,0,8);
      when "0000000100" => KEY <= (0,0,4);
      when "0000000010" => KEY <= (0,0,2);
      when "0000000001" => KEY <= (0,0,1);
      when others       => KEY <= (0,0,0);
    end case;
  end process;
end RTL_CASE;

architecture RTL_IF of DECODER is -- with priority to buttons
begin
  process(KEYPAD)
  begin
    if KEYPAD(0) = '1' then
      KEY <= (0,0,1);
    elsif KEYPAD(1) = '1' then
      KEY <= (0,0,2);
    elsif KEYPAD(2) = '1' then
      KEY <= (0,0,4);
    elsif KEYPAD(3) = '1' then
      KEY <= (0,0,8);
    elsif KEYPAD(4) = '1' then
      KEY <= (0,1,6);
    elsif KEYPAD(5) = '1' then
      KEY <= (0,3,2);
    elsif KEYPAD(6) = '1' then
      KEY <= (0,6,4);
    elsif KEYPAD(7) = '1' then
      KEY <= (1,2,8);
    elsif KEYPAD(8) = '1' then
      KEY <= (2,5,6);
    elsif KEYPAD(9) = '1' then
      KEY <= (5,1,2);
    else
      KEY <= (0,0,0);
    end if;
  end process;
end RTL_IF;

