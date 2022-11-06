--Justin Jaeckel
library IEEE;
use IEEE.std_logic_1164.all;
entity fiveToThirtyTwoDecoder is 
    port (data_input : in std_logic_vector(4 downto 0);
        data_output : out std_logic_vector(31 downto 0);
        EN : in std_logic);

end fiveToThirtyTwoDecoder;

architecture mixed of fiveToThirtyTwoDecoder is


begin
process (data_input, EN)
begin
    data_output <= "00000000000000000000000000000000";

    if (EN = '1') then
        case data_input is -- All input possibilies         
            when "00000" => data_output(0) <= '1';
            when "00001" => data_output(1) <= '1';
            when "00010" => data_output(2) <= '1';
            when "00011" => data_output(3) <= '1';
            when "00100" => data_output(4) <= '1';
            when "00101" => data_output(5) <= '1';
            when "00110" => data_output(6) <= '1';
            when "00111" => data_output(7) <= '1';
            when "01000" => data_output(8) <= '1';
            when "01001" => data_output(9) <= '1';
            when "01010" => data_output(10) <= '1';
            when "01011" => data_output(11) <= '1';
            when "01100" => data_output(12) <= '1';
            when "01101" => data_output(13) <= '1';
            when "01110" => data_output(14) <= '1';
            when "01111" => data_output(15) <= '1';
            when "10000" => data_output(16) <= '1';
            when "10001" => data_output(17) <= '1';
            when "10010" => data_output(18) <= '1';
            when "10011" => data_output(19) <= '1';
            when "10100" => data_output(20) <= '1';
            when "10101" => data_output(21) <= '1';
            when "10110" => data_output(22) <= '1';
            when "10111" => data_output(23) <= '1';
            when "11000" => data_output(24) <= '1';
            when "11001" => data_output(25) <= '1';
            when "11010" => data_output(26) <= '1';
            when "11011" => data_output(27) <= '1';
            when "11100" => data_output(28) <= '1';
            when "11101" => data_output(29) <= '1';
            when "11110" => data_output(30) <= '1';
            when "11111" => data_output(31) <= '1';
            when others => data_output <= "00000000000000000000000000000000";
        end case;
    end if;

end process;
end mixed;