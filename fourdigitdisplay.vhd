----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Ahmet Çaymaz

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fourdigitdisplay is
    Port ( 
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           numbermili: in STD_LOGIC_VECTOR (3 downto 0);
           numbersecondlsb: in STD_LOGIC_VECTOR (3 downto 0);
           numbersecondmsb: in STD_LOGIC_VECTOR (3 downto 0);
           numberminute: in STD_LOGIC_VECTOR (3 downto 0);
           AnodeSelection: out STD_LOGIC_VECTOR (3 downto 0);
           segout : out STD_LOGIC_VECTOR (6 downto 0);
           dp : out std_logic
           );
end fourdigitdisplay;

architecture Behavioral of fourdigitdisplay is

component caymazSevenSegment is
port(
  numin : in std_logic_vector(3 downto 0);
  segout : out std_logic_vector (6 downto 0)
);
end component;


signal refresh_rate: STD_LOGIC_VECTOR (1 downto 0);
signal binary_coded_decimal: STD_LOGIC_VECTOR (3 downto 0);
signal binary_coded_decimal2: STD_LOGIC_VECTOR (3 downto 0);
signal binary_coded_decimal3: STD_LOGIC_VECTOR (3 downto 0);
signal binary_coded_decimal4: STD_LOGIC_VECTOR (3 downto 0);
signal clk_divider: STD_LOGIC_VECTOR(22 downto 0):= (others=>'0');

signal decimalval1 : integer range 0 to 99;
signal decimalval2 : integer range 0 to 99;
signal decimalval3 : integer range 0 to 99;
signal decimalval4 : integer range 0 to 99;

signal decimal_msb : integer range 0 to 9;
signal decimal_msb2 : integer range 0 to 9;
signal decimal_msb3 : integer range 0 to 9;
signal decimal_msb4 : integer range 0 to 9;
signal decimal_lsb : integer range 0 to 9;
signal decimal_lsb2 : integer range 0 to 9;
signal decimal_lsb3 : integer range 0 to 9;
signal decimal_lsb4 : integer range 0 to 9;

signal segment_msb : std_logic_vector (3 downto 0):= "0000";
signal segment_msb2 : std_logic_vector (3 downto 0):= "0000";
signal segment_msb3 : std_logic_vector (3 downto 0):= "0000";
signal segment_msb4 : std_logic_vector (3 downto 0):= "0000";

signal segment_lsb : std_logic_vector (3 downto 0):= "0000";
signal segment_lsb2 : std_logic_vector (3 downto 0):= "0000";
signal segment_lsb3 : std_logic_vector (3 downto 0):= "0000";
signal segment_lsb4 : std_logic_vector (3 downto 0):= "0000";

signal msb_decoder_out : std_logic_vector(6 downto 0) := "0000000";
signal lsb_decoder_out : std_logic_vector(6 downto 0) := "0000000";

signal segout1 : std_logic_vector (6 downto 0) := "0000000";
signal segout2 : std_logic_vector (6 downto 0) := "0000000";
signal segout3 : std_logic_vector (6 downto 0) := "0000000";
signal segout4 : std_logic_vector (6 downto 0) := "0000000";


begin
process(numbermili)
begin
    decimalval1 <= to_integer(unsigned(numbermili));
end process;

process(numbersecondlsb)
begin
    decimalval2 <= to_integer(unsigned(numbersecondlsb));
end process;

process(numbersecondmsb)
begin
    decimalval3 <= to_integer(unsigned(numbersecondmsb));
end process;

process(numberminute)
begin
    decimalval4 <= to_integer(unsigned(numberminute));
end process;

decimal_msb <= decimalval1 / 10;
decimal_lsb <= decimalval1 rem 10;

segment_msb <= std_logic_vector(to_unsigned(decimal_msb, 4));
segment_lsb <= std_logic_vector(to_unsigned(decimal_lsb, 4));
---
decimal_msb2 <= decimalval2 / 10;
decimal_lsb2 <= decimalval2 rem 10;

segment_msb2 <= std_logic_vector(to_unsigned(decimal_msb2, 4));
segment_lsb2 <= std_logic_vector(to_unsigned(decimal_lsb2, 4));
------
decimal_msb3 <= decimalval3 / 10;
decimal_lsb3 <= decimalval3 rem 10;

segment_msb3 <= std_logic_vector(to_unsigned(decimal_msb3, 4));
segment_lsb3 <= std_logic_vector(to_unsigned(decimal_lsb3, 4));
---------
decimal_msb4 <= decimalval4 / 10;
decimal_lsb4 <= decimalval4 rem 10;

segment_msb4 <= std_logic_vector(to_unsigned(decimal_msb4, 4));
segment_lsb4 <= std_logic_vector(to_unsigned(decimal_lsb4, 4));



Clock_Divider:process(rst,clk)
begin
    if(rst='1') then
        clk_divider   <= (others=>'0');
    elsif(CLK'event and CLK='1') then
        clk_divider   <= clk_divider + 1;
  end if;    
end process;
refresh_rate<= clk_divider(11 downto 10);

Anode_Selection:process(refresh_rate)
begin
    case refresh_rate is

        when "00" => AnodeSelection <= "1110";
                     binary_coded_decimal <= segment_lsb(3 downto 0);
                     segout <= segout1;
                     dp <= '1';                               
        when "01" => AnodeSelection <= "1101";
                     binary_coded_decimal2 <= segment_lsb2(3 downto 0);
                     segout <= segout2;
                     dp <= '0';
        when "10" => AnodeSelection <= "1011";
                     binary_coded_decimal3 <= segment_lsb3(3 downto 0);
                     segout <= segout3;
                     dp <= '1';
        when "11" => AnodeSelection <= "0111";
                     binary_coded_decimal4 <= segment_lsb4(3 downto 0);   
                     segout <= segout4; 
                     dp <= '0';               
        when others => AnodeSelection <= "1111";
    end case;
end process;

SevenSegmentDecoder : caymazSevenSegment port map(numin => binary_coded_decimal, segout => segout1);
SevenSegmentDecoder2 : caymazSevenSegment port map(numin => binary_coded_decimal2, segout => segout2);
SevenSegmentDecoder3 : caymazSevenSegment port map(numin => binary_coded_decimal3, segout => segout3);
SevenSegmentDecoder4 : caymazSevenSegment port map(numin => binary_coded_decimal4, segout => segout4);

end Behavioral;

--Segment_Display_Decoder:process(binary_coded_decimal)
--begin
--    case binary_coded_decimal is
--        when "0000" => displaySevenSegment <= "0000001";      
--        when "0001" => displaySevenSegment <= "1001111";  
--        when "0010" => displaySevenSegment <= "0010010";  
--        when "0011" => displaySevenSegment <= "0000110";  
--        when "0100" => displaySevenSegment <= "1001100";  
--        when "0101" => displaySevenSegment <= "0100100";  
--        when "0110" => displaySevenSegment <= "0100000";  
--        when "0111" => displaySevenSegment <= "0001111";  
--        when "1000" => displaySevenSegment <= "0000000";      
--        when "1001" => displaySevenSegment <= "0000100";
--        when others => displaySevenSegment <= "1111111";
--    end case;       