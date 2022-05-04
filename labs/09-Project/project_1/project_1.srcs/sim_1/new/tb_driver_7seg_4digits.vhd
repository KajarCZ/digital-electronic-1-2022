------------------------------------------------------------
--
-- Template for 8-digit 7-segment display driver testbench.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
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
entity tb_driver_7seg_4digits is
    -- Entity of testbench is always empty
end entity tb_driver_7seg_4digits;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_driver_7seg_4digits is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    -- Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset : std_logic;
    
    signal s_data_i : std_logic_vector (5 downto 0);
    
    signal s_seg : std_logic_vector (6 downto 0);
    signal s_dig : std_logic_vector (8 - 1 downto 0);

begin
    -- Connecting testbench signals with driver_7seg_4digits
    -- entity (Unit Under Test)

    uut_driver_7seg_4digits : entity work.driver_7seg_4digits
    port map (
    clk => s_clk_100MHz,
    reset => s_reset,
    
    data_i => s_data_i,

    seg_o => s_seg,
    dig_o => s_dig
    );
    
    
    --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 10000 ns loop -- 1000 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

   --------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------
    p_reset_gen : process
    begin
        s_reset <= '0'; wait for 12 ns;
        -- Reset activated
        s_reset <= '1'; wait for 73 ns;
        -- Reset deactivated
        s_reset <= '0'; wait for 500 ns;
        -- Reset activated
        s_reset <= '1'; wait for 200 ns;
        -- Reset deactivated
        s_reset <= '0'; wait for 1000 ns;
        -- Reset activated
        s_reset <= '1'; wait for 200 ns;
        -- Reset deactivated
        s_reset <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;


        s_data_i <= "000010";
        

        wait for 500ns;
        
        s_data_i <= "111111";
        
        wait for 500ns;
        
        s_data_i <= "000000";
        
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end architecture testbench;
