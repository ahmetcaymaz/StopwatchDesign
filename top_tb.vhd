----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ahmet Çaymaz

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_tb is  
end top_tb;

architecture Behavioral of top_tb is

component top is
Port ( 
    reset : in  std_logic;
    dir   : in  std_logic; -- '0' for up, '1' for down
    cnt   : in  std_logic; -- Count enable
    clk   : in  std_logic;
    AnodeSelection: out std_logic_vector (3 downto 0);
    dp : out std_logic;
    segout : out std_logic_vector (6 downto 0)
  );
end component;


signal reset_t : std_logic := '0';
signal cnt_t : std_logic := '0';
signal clk_t : std_logic := '0';
signal dir_t : std_logic := '0';
signal dp_t : std_logic := '0';
signal AnodeSelection_t : std_logic_vector(3 downto 0) := "0000";
signal segout_t : std_logic_vector(6 downto 0) := "0000000";

constant clk_period : time := 10ns;

begin

UUT: top Port map ( 
clk => clk_t,
reset => reset_t,
dir => dir_t,
cnt => cnt_t,
segout => segout_t,
AnodeSelection => AnodeSelection_t,
dp => dp_t
);


ClockProcess : process
begin
    clk_t <= '0';
    wait for clk_period/2;
    clk_t <= '1';
    wait for clk_period/2;
end process;


load_process: process
    begin
    cnt_t <= '1';
    wait for 1ms;
    cnt_t <= '0';
    wait for 0.5ms;
    cnt_t <= '1';
    wait for 2ms;
end process;
   

resetprocess: process
begin
    reset_t <= '1';
    wait for 50ns;
    reset_t <= '0';
    wait for 10sec;
end process;


dirprocess : process
begin
    dir_t <= '0';
    wait for 1ms;
    dir_t <= '1';
    wait for 1ms;
end process;

end Behavioral;

