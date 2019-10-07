----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2019 00:42:40
-- Design Name: 
-- Module Name: EXP_CRTL - RTL
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

entity EXP_CTRL is
  port(CLK : in std_ulogic;
       RESET : in std_ulogic;
       TIMER_GO : in std_ulogic;
       EXP_TIME : in T_DIGITS;
       EXPOSE : buffer std_ulogic;
       NO_PICS : buffer T_DIGITS);
end EXP_CTRL;

architecture RTL of EXP_CTRL is
  signal LIMIT: integer range 0 to 511;




  procedure INC_DIGIT (
    DIGIT : inout integer;
    CARRY : inout std_ulogic) is



  begin
    if CARRY = '1' then


      if DIGIT /= 9 then
        DIGIT := DIGIT + 1;
        CARRY := '0';
      else
        DIGIT := 0;
      end if;        -- OVERFLOW
    end if;          -- CARRY = '1'
  end INC_DIGIT;

begin                -- architecture
  MAPPER: process (EXP_TIME, EXPOSE)
  begin

    LIMIT <= 0;

    if EXPOSE = '0' then
      if    EXP_TIME = (5,1,2) then
        LIMIT <=   0;
      elsif EXP_TIME = (2,5,6) then
        LIMIT <=   1;
      elsif EXP_TIME = (1,2,8) then
        LIMIT <=   3;
      elsif EXP_TIME = (0,6,4) then
        LIMIT <=   7;
      elsif EXP_TIME = (0,3,2) then
        LIMIT <=  15;
      elsif EXP_TIME = (0,1,6) then
        LIMIT <=  31;
      elsif EXP_TIME = (0,0,8) then
        LIMIT <=  63;
      elsif EXP_TIME = (0,0,4) then
        LIMIT <= 127;
      elsif EXP_TIME = (0,0,2) then
        LIMIT <= 255;
      elsif EXP_TIME = (0,0,1) then
        LIMIT <= 511;
      end if;
    end if;
  end process MAPPER;
  
   EXP_TIMER: process (CLK, RESET)
    variable COUNT_16: integer
                           range 0 to 15;
    variable TIMER:    integer
                           range 0 to 511;
  begin
    if RESET = '1' then
      COUNT_16 := 0;
      TIMER := 0;
      EXPOSE <= '0';

    elsif (CLK'event and CLK = '1') then
      if EXPOSE = '1' then

        if COUNT_16 /= 15 then
          COUNT_16 := COUNT_16 + 1;
        else
          COUNT_16 := 0;
          if TIMER = LIMIT then
            EXPOSE <= '0';
          else
            TIMER := TIMER + 1;
          end if;
        end if;
      elsif TIMER_GO = '1' then
        EXPOSE <= '1';
        COUNT_16 := 0;
        TIMER := 0;
      end if;
    end if;
  end process EXP_TIMER;
  PIC_COUNT: process(CLK, RESET)
    variable LAST_EXPOSE: std_ulogic;
    variable CARRY: std_ulogic;
    variable DIGIT: integer;

  begin
    if RESET = '1' then
      LAST_EXPOSE := '0';
      NO_PICS <= (0, 0, 0);

    elsif CLK'event and CLK = '1' then
      if EXPOSE      = '1' and
         LAST_EXPOSE = '0' then
        CARRY := '1';
        for I in T_DIGITS'low
              to T_DIGITS'high loop
          DIGIT := NO_PICS(I);
          INC_DIGIT(DIGIT, CARRY);
          NO_PICS(I) <= DIGIT;
        end loop;
      end if;

      LAST_EXPOSE := EXPOSE;
    end if;
  end process PIC_COUNT;
end RTL; 
