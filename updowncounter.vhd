----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ahmet Çaymaz

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity updowncounter is
 Port ( cnt, clk,dir : in STD_LOGIC;
 reset : in STD_LOGIC;
 miliout : out STD_LOGIC_VECTOR (3 downto 0);
 secondoutlsb : out STD_LOGIC_VECTOR (3 downto 0);
 secondoutmsb : out STD_LOGIC_VECTOR (3 downto 0);
 minuteout : out STD_LOGIC_VECTOR (3 downto 0));
end updowncounter;

architecture Behavioral of updowncounter is

signal mili,secondlsb,secondmsb,minute : std_logic_vector(3 downto 0):="0000";

begin

process(cnt, reset,clk)
begin

if (reset = '1' and (cnt='1' or cnt='0')) then --if rst=1 set all values back to zero...
    mili <= (others=> '0');
    secondlsb <= (others=> '0');
    secondmsb <= (others=> '0');
    minute <= (others=> '0');
elsif (cnt = '1' and rising_edge(CLK)) then--...otherwise, if cen is one start counting

if (dir = '0') then

    if mili="1001" then
        mili<="0000";--when count s_cnt gets to 9 reset, tc goes high
        if secondlsb="1001" then
            secondlsb <="0000";
            if secondmsb = "0101" then
                secondmsb <="0000";
                if minute ="1001" then
                    minute<="0000";
                else minute <= minute + 1;
                end if;
            else secondmsb <= secondmsb +1; 
            end if;
        else secondlsb <= secondlsb +1;
        end if;
    else mili <= mili+1;
    end if;
    
elsif (dir = '1') then
    if mili="0000" then
        mili<="1001";--when count s_cnt gets to 9 reset, tc goes high
        if secondlsb="0000" then
            secondlsb <="1001";
            if secondmsb = "0000" then
                secondmsb <="0101";
                if minute ="0000" then
                    minute<="1001";
                else minute <= minute - 1;
                end if;
            else secondmsb <= secondmsb - 1; 
            end if;
        else secondlsb <= secondlsb - 1;
        end if;
    else mili <= mili - 1;
    end if;
end if;
end if; 
end process;

miliout <= mili;
secondoutlsb <= secondlsb;
secondoutmsb <= secondmsb;
minuteout <= minute;

end Behavioral;