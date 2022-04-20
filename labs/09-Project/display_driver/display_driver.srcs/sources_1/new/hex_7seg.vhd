library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity hex_7seg is
    Port ( hex_i : in STD_LOGIC_VECTOR (5 downto 0);
           seg_o : out STD_LOGIC_VECTOR (6 downto 0));
end hex_7seg;

architecture Behavioral of hex_7seg is
begin
    p_7seg_decoder : process(hex_i)
    begin
        case hex_i is
            when "000000" =>
                seg_o <= "0000001"; -- 0
            when "000001" =>
                seg_o <= "1001111"; -- 1
            when "000010" =>
                seg_o <= "0010010";-- 2
            when "000011" =>
                seg_o <= "0000110";-- 3
            when "000100" =>
                seg_o <= "1001100";-- 4
            when "000101" =>
                seg_o <= "0100100";-- 5
            when "000110" =>
                seg_o <= "0100000";-- 6
            when "000111" =>
                seg_o <= "0001111";-- 7
            when "001000" =>
                seg_o <= "0000000"; -- 8
            when "001001" =>
                seg_o <= "0000100";-- 9
            when "001010" =>
                seg_o <= "0001000";-- A
            when "001011" =>
                seg_o <= "1100000";-- b
            when "001100" =>
                seg_o <= "0110001";-- C
            when "001101" =>
                seg_o <= "1000010";-- d
            when "001110" =>
                seg_o <= "0110000"; -- E
            when "001111" =>
                seg_o <= "0111000"; -- F
-------------------------------------------------                
            when "010000" =>
                seg_o <= "0000100"; -- g
            when "010001" =>
                seg_o <= "1001000"; -- H
            when "010010" =>
                seg_o <= "1111011";-- i
            when "010011" =>
                seg_o <= "1000111";-- J
                
                
                
                
            when "010100" =>
                seg_o <= "1111000";-- K
            when "010101" =>
                seg_o <= "1110001";-- L
            when "010110" =>
                seg_o <= "0011101";-- M
            when "010111" =>
                seg_o <= "1101010";-- n
                
                
                
                
                
            when "011000" =>
                seg_o <= "1100010"; -- o
            when "011001" =>
                seg_o <= "0011000";-- P
            when "011010" =>
                seg_o <= "0001100";-- Q
            when "011011" =>
                seg_o <= "1111010";-- r
                
                
                
                
            when "011100" =>
                seg_o <= "0100100";-- S
            when "011101" =>
                seg_o <= "0111001";-- T
            when "011110" =>
                seg_o <= "1000001"; -- U
            when "011111" =>
                seg_o <= "1100011"; -- v
                
                
                
                
                
-------------------------------------------------                                   
            when "100000" =>
                seg_o <= "1001001"; -- W
            when "100001" =>
                seg_o <= "1101100"; -- X
            when "100010" =>
                seg_o <= "1000100";-- Y
            when "100011" =>
                seg_o <= "1011010";-- Z
            when "100100" =>
                seg_o <= "0110110";-- dash
-------------------------------------------------                   
            when others =>
                seg_o <= "1111111"; -- mezera
        end case;
    end process p_7seg_decoder;

end architecture Behavioral;
