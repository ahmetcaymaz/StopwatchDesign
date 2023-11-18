----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ahmet Çaymaz

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clockdivider is
port(
    clk : in std_logic;
    rst : in std_logic;
    clk_out_10hz: out std_logic
    );
end clockdivider;

architecture Behavioral of clockdivider is

signal count: integer:=1;


signal logicvalue : std_logic := '0';

begin
--Clock Divider for 10hz (MSB of miliseconds)
process(rst,clk)
begin
    if (rst = '1') then
    count<=1;
    logicvalue<='0';
    elsif(clk'event and clk='1') then
    count <=count+1;
    
    if (count = 5000000) then
    logicvalue <= NOT logicvalue;
    count <= 1;
    end if;
    end if;
clk_out_10hz <= logicvalue;
end process;
--------------------
end Behavioral;
