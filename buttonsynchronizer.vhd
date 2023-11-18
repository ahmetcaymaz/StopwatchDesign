library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity buttonsynchronizer is
 Port ( 
 clk : in std_logic;
 rst : in std_logic;
 bi : in std_logic;
 bo : out std_logic
 );
end buttonsynchronizer;

architecture Behavioral of buttonsynchronizer is

signal D_A : std_logic;
signal D_B : std_logic;
signal D_A_out : std_logic := '0';
signal D_B_out : std_logic := '0';

begin
D_A <= bi and ( D_A_out xor D_B_out );
D_B <= (not D_A_out ) and (not D_b_out ) and (bi);
bo <= (not D_A_out ) and (D_B_out);

    process(rst,clk)
    begin
        if (rst = '1') then
        D_A_out <= '0';    
        D_B_out <= '0';
        
        elsif(clk'EVENT AND clk = '1') then
        D_A_out <= D_A;    
        D_B_out <= D_B;
        end if;
    end process;
end Behavioral;

