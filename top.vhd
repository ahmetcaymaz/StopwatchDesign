----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ahmet Çaymaz

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
  Port ( 
    reset : in  std_logic;
    dir   : in  std_logic; -- '0' for up, '1' for down
    cnt   : in  std_logic; -- Count enable
    clk   : in  std_logic;
    AnodeSelection: out std_logic_vector (3 downto 0);
    dp : out std_logic;
    segout : out std_logic_vector (6 downto 0)
  );
end top;

architecture Behavioral of top is

component clockdivider is
port(
    clk : in std_logic;
    rst : in std_logic;
    clk_out_10hz: out std_logic
    );
end component;

component updowncounter is
 port ( 
 cnt, clk,dir : in STD_LOGIC;
 reset : in STD_LOGIC;
 miliout : out STD_LOGIC_VECTOR (3 downto 0);
 secondoutlsb : out STD_LOGIC_VECTOR (3 downto 0);
 secondoutmsb : out STD_LOGIC_VECTOR (3 downto 0);
 minuteout : out STD_LOGIC_VECTOR (3 downto 0));
end component;


component buttonfsm is
  Port (
  btn : in std_logic;
  reset : in std_logic;
  clk : in std_logic;
  direction : out std_logic
   );
end component;

component buttonsynchronizer is
 Port ( 
 clk : in std_logic;
 rst : in std_logic;
 bi : in std_logic;
 bo : out std_logic
 );
end component;


component fourdigitdisplay is
port(
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           numbermili: in STD_LOGIC_VECTOR (3 downto 0);
           numbersecondlsb: in STD_LOGIC_VECTOR (3 downto 0);
           numbersecondmsb: in STD_LOGIC_VECTOR (3 downto 0);
           numberminute: in STD_LOGIC_VECTOR (3 downto 0);
           AnodeSelection: out STD_LOGIC_VECTOR (3 downto 0);
           segout : out STD_LOGIC_VECTOR (6 downto 0);
           dp : out std_logic);
end component;


signal displaynum : std_logic_vector (3 downto 0) := "0000"; --will go four digit display
signal displaynum2 : std_logic_vector (3 downto 0) := "0000"; --will go four digit display
signal displaynum3 : std_logic_vector (3 downto 0) := "0000"; --will go four digit display
signal displaynum4 : std_logic_vector (3 downto 0) := "0000"; --will go four digit display

signal AnodeOut : std_logic_vector (3 downto 0) := "0000";
signal CathodeOut : std_logic_vector (6 downto 0) := "0000000";
signal dp_display : std_logic := '0';

signal clk_10hz : std_logic := '0';


signal up_down_direction : std_logic := '0';
signal btn_sych_out : std_logic := '0';

begin

ClockDivider10hz : clockdivider port map (clk => clk, rst => reset, clk_out_10hz => clk_10hz);

btnsychronizer: buttonsynchronizer port map (clk => clk, rst => reset, bi => dir, bo => btn_sych_out );

FSMbutton :  buttonfsm port map (btn => btn_sych_out, reset => reset, clk => clk, direction => up_down_direction);

CounterPort : updowncounter port map (
 cnt => cnt, 
 clk => clk_10hz,
 dir => up_down_direction,
 reset => reset,
 miliout =>displaynum ,
 secondoutlsb => displaynum2,
 secondoutmsb => displaynum3,
 minuteout => displaynum4
);

DigitProcess : fourdigitdisplay port map (
clk => clk,
rst => reset, 
numbermili => displaynum,
numbersecondlsb => displaynum2,
numbersecondmsb => displaynum3,
numberminute => displaynum4,
AnodeSelection => AnodeOut, 
segout => CathodeOut,
dp => dp_display
);

AnodeSelection <= AnodeOut;
segout <= CathodeOut;
dp <= dp_display;
end Behavioral;
