----------------------------------------------------------------------------------
------------------------------------------------------------
--
-- Testbench for 7-segment display decoder.
-- Nexys A7-50T, Vivado v2020.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_hex_7seg is
    -- Entity of testbench is always empty
end entity tb_hex_7seg;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_hex_7seg is

    -- Local signals
    signal s_hex  : std_logic_vector(6 - 1 downto 0);
    signal s_seg  : std_logic_vector(7 - 1 downto 0);

begin
    -- Connecting testbench signals with decoder entity
    -- (Unit Under Test)
    uut_hex_7seg : entity work.hex_7seg
        port map(
            hex_i => s_hex,
            seg_o => s_seg
        );

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;

        -- First test case
        s_hex <= "000000"; wait for 50 ns;
        assert (s_seg = "0000001")
        report "Input combination 000000 FAILED" severity error;
        
        s_hex <= "000001"; wait for 50 ns;
        assert (s_seg = "1001111")
        report "Input combination 000001 FAILED" severity error;
        
        s_hex <= "000010"; wait for 50 ns;
        assert (s_seg = "0010010")
        report "Input combination 000010 FAILED" severity error;
        
        s_hex <= "000011"; wait for 50 ns;
        assert (s_seg = "0000110")
        report "Input combination 000011 FAILED" severity error;
        
        s_hex <= "000100"; wait for 50 ns;
        assert (s_seg = "1001100")
        report "Input combination 000100 FAILED" severity error;
        
        s_hex <= "000101"; wait for 50 ns;
        assert (s_seg = "0100100")
        report "Input combination 000101 FAILED" severity error;
        
        s_hex <= "000110"; wait for 50 ns;
        assert (s_seg = "0100000")
        report "Input combination 000110 FAILED" severity error;
        
        s_hex <= "000111"; wait for 50 ns;
        assert (s_seg = "0001111")
        report "Input combination 000111 FAILED" severity error;
        
        s_hex <= "001000"; wait for 50 ns;
        assert (s_seg = "0000000")
        report "Input combination 001000 FAILED" severity error;
        
        s_hex <= "001001"; wait for 50 ns;
        assert (s_seg = "0000100")
        report "Input combination 001001 FAILED" severity error;
        
        s_hex <= "001010"; wait for 50 ns;
        assert (s_seg = "0001000")
        report "Input combination 001010 FAILED" severity error;
        
        s_hex <= "001011"; wait for 50 ns;
        assert (s_seg = "1100000")
        report "Input combination 001011 FAILED" severity error;
        
        s_hex <= "001100"; wait for 50 ns;
        assert (s_seg = "0110001")
        report "Input combination 001100 FAILED" severity error;
        
        s_hex <= "001101"; wait for 50 ns;
        assert (s_seg = "1000010")
        report "Input combination 001101 FAILED" severity error;
        
        s_hex <= "001110"; wait for 50 ns;
        assert (s_seg = "0110000")
        report "Input combination 001110 FAILED" severity error;
        
        s_hex <= "001111"; wait for 50 ns;
        assert (s_seg = "0111000")
        report "Input combination 001111 FAILED" severity error;





        s_hex <= "010000"; wait for 50 ns;
        assert (s_seg = "0000100")
        report "Input combination 010000 FAILED" severity error;
        
        s_hex <= "010001"; wait for 50 ns;
        assert (s_seg = "1001000")
        report "Input combination 010001 FAILED" severity error;
        
        s_hex <= "010010"; wait for 50 ns;
        assert (s_seg = "1111011")
        report "Input combination 010010 FAILED" severity error;
        
        s_hex <= "010011"; wait for 50 ns;
        assert (s_seg = "1000111")
        report "Input combination 010011 FAILED" severity error;
        
        
        
        
        
        
        s_hex <= "010100"; wait for 50 ns;
        assert (s_seg = "1111000")
        report "Input combination 010100 FAILED" severity error;
        
        s_hex <= "010101"; wait for 50 ns;
        assert (s_seg = "1110001")
        report "Input combination 010101 FAILED" severity error;
        
        s_hex <= "010110"; wait for 50 ns;
        assert (s_seg = "0011101")
        report "Input combination 010110 FAILED" severity error;
        
        s_hex <= "010111"; wait for 50 ns;
        assert (s_seg = "1101010")
        report "Input combination 010111 FAILED" severity error;
        
        
        
        
        
        
        s_hex <= "011000"; wait for 50 ns;
        assert (s_seg = "1100010")
        report "Input combination 011000 FAILED" severity error;
        
        s_hex <= "011001"; wait for 50 ns;
        assert (s_seg = "0011000")
        report "Input combination 011001 FAILED" severity error;
        
        s_hex <= "011010"; wait for 50 ns;
        assert (s_seg = "0001100")
        report "Input combination 011010 FAILED" severity error;
        
        s_hex <= "011011"; wait for 50 ns;
        assert (s_seg = "1111010")
        report "Input combination 011011 FAILED" severity error;
        
        
        
        
        
        
        
        s_hex <= "011100"; wait for 50 ns;
        assert (s_seg = "0100100")
        report "Input combination 011100 FAILED" severity error;
        
        s_hex <= "011101"; wait for 50 ns;
        assert (s_seg = "0111001")
        report "Input combination 011101 FAILED" severity error;
        
        s_hex <= "011110"; wait for 50 ns;
        assert (s_seg = "1000001")
        report "Input combination 011110 FAILED" severity error;
        
        s_hex <= "011111"; wait for 50 ns;
        assert (s_seg = "1100011")
        report "Input combination 011111 FAILED" severity error;    
        
        
        
        
        
           
        s_hex <= "100000"; wait for 50 ns;
        assert (s_seg = "1001001")
        report "Input combination 100000 FAILED" severity error;
        
        s_hex <= "100001"; wait for 50 ns;
        assert (s_seg = "1101100")
        report "Input combination 100001 FAILED" severity error;
        
        s_hex <= "100010"; wait for 50 ns;
        assert (s_seg = "1000100")
        report "Input combination 100010 FAILED" severity error;
        
        s_hex <= "100011"; wait for 50 ns;
        assert (s_seg = "1011010")
        report "Input combination 100011 FAILED" severity error; 
        
        
        
        
        s_hex <= "100100"; wait for 50 ns;
        assert (s_seg = "0110110")
        report "Input combination 100100 FAILED" severity error;
        
        s_hex <= "100101"; wait for 50 ns;
        assert (s_seg = "1111111")
        report "Input combination 100101 FAILED" severity error;
         
        s_hex <= "111101"; wait for 50 ns;
        assert (s_seg = "1111111")
        report "Input combination 111101 FAILED" severity error;         
        
        s_hex <= "111111"; wait for 50 ns;
        assert (s_seg = "1111111")
        report "Input combination 111111 FAILED" severity error; 
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;


end architecture testbench;