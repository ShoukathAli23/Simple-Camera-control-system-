----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2019 22:17:52
-- Design Name: 
-- Module Name: DISPLAY_PACKAGE - DISP
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

--         _______  
--        |___a___|
--        |f|   |b|          
--        |_|___|_|
--        |___g___|               SEG_? = "abcdefg"
--        |e|   |c|
--        |_|___|_|
--        |___d___|


package DISPLAY_PACKAGE is
    constant SEG_0 : std_logic_vector := "1111110"; -- "0" -- x7E    
    constant SEG_1 : std_logic_vector := "0110000"; -- "1" -- x30
    constant SEG_2 : std_logic_vector := "1101101"; -- "2" -- x6D 
    constant SEG_3 : std_logic_vector := "1111001"; -- "3" -- x79
    constant SEG_4 : std_logic_vector := "0110011"; -- "4" -- x33 
    constant SEG_5 : std_logic_vector := "1011011"; -- "5" -- x5B 
    constant SEG_6 : std_logic_vector := "1011111"; -- "6" -- x5F 
    constant SEG_7 : std_logic_vector := "1110000"; -- "7" -- x70 
    constant SEG_8 : std_logic_vector := "1111111"; -- "8" -- xFF     
    constant SEG_9 : std_logic_vector := "1111011"; -- "9" -- x7B
     
    constant SEG_A : std_logic_vector := "1111101"; -- "A" -- x7D
    constant SEG_B : std_logic_vector := "0011111"; -- "B" -- x1F
    constant SEG_C : std_logic_vector := "1001110"; -- "C" -- x4F
    constant SEG_D : std_logic_vector := "0111101"; -- "D" -- x3D
    constant SEG_E : std_logic_vector := "1001111"; -- "E" -- x4F
    constant SEG_F : std_logic_vector := "1000111"; -- "F" -- x47
    
    type T_DIGITS is array (0 to 2) of integer range 0 to 10;
    
    type T_DISPLAY is array (0 to 2) of std_logic_vector (6 downto 0);
    
    
end DISPLAY_PACKAGE;

