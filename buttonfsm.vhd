----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ahmet Çaymaz

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity buttonfsm is
  Port (
  btn : in std_logic;
  reset : in std_logic;
  clk : in std_logic;
  direction : out std_logic
   );
end buttonfsm;

architecture Behavioral of buttonfsm is

type State_Type is (Up, Down);
signal present_state, next_state : State_Type := Up;


begin


process(reset,clk)
begin
if (clk'event and clk = '1') then
    if (reset = '1') then
    present_state <= Up;
    else 
    present_state <= next_state;
    end if;
end if;
end process;

-- State Outputs
process(present_state)
    begin
        case present_state is
        when Up =>
        direction <= '0';
        when Down =>
        direction <= '1';
        end case;
end process;

    
    
-- transitions
process (present_state)
begin
        case present_state is
            when Up =>
                if (btn = '1') then
                    next_state <= Down;
                else
                    next_state <= Up;
                end if;
            when Down =>
                if (btn = '1') then
                    next_state <= Up;
                else
                    next_state <= Down;
                end if;
        end case;
end process;

end Behavioral;

