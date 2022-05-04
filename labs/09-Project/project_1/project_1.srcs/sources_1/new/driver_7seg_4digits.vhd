------------------------------------------------------------
--
-- Driver for 8-digit 7-segment display.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for display driver
------------------------------------------------------------
entity driver_7seg_4digits is
    port(
        clk     : in  std_logic;
        reset   : in  std_logic;
        -- 6-bit input values for individual digits
        data_i : in  std_logic_vector(6 - 1 downto 0);
        -- Cathode values for individual segments
        seg_o   : out std_logic_vector(7 - 1 downto 0);
        -- Common anode signals to individual displays
        dig_o   : out std_logic_vector(8 - 1 downto 0)
    );
end entity driver_7seg_4digits;

------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------
architecture Behavioral of driver_7seg_4digits is

    -- Internal clock enable
    signal s_en  : std_logic;
    -- Internal 3-bit counter for multiplexing 8 digits
    signal s_cnt : std_logic_vector(3 - 1 downto 0);
        -- Internal clock enable
    signal s_en1  : std_logic;
    -- Internal 1-bit counter for multiplexing 2 digits
    signal s_cnt1 : std_logic_vector(1 - 1 downto 0);
    -- Internal 6-bit value for 7-segment decoder
    signal s_hex : std_logic_vector(6 - 1 downto 0);
    signal data0_i : std_logic_vector(6 - 1 downto 0);
    signal data1_i : std_logic_vector(6 - 1 downto 0);
    signal data2_i : std_logic_vector(6 - 1 downto 0);
    signal data3_i : std_logic_vector(6 - 1 downto 0);
    signal data4_i : std_logic_vector(6 - 1 downto 0);
    signal data5_i : std_logic_vector(6 - 1 downto 0);
    signal data6_i : std_logic_vector(6 - 1 downto 0);
    signal data7_i : std_logic_vector(6 - 1 downto 0);
    signal data_help_i : std_logic_vector(6 - 1 downto 0);
    -- boolean signal for shifting internal signals
    signal a : std_logic;

begin
    --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates 
    -- an enable pulse every 2 ms
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 200000 --4 for simulation and 200 000 for implementation
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
        );

    --------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity performs a 3-bit
    -- down counter
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH => 3
        )
        port map(
            en_i => s_en, 
            cnt_up_i => '0',
            reset => reset,
            clk => clk,
            cnt_o => s_cnt
        );

    --------------------------------------------------------
        --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates 
    -- an enable pulse every 0.5 sec
    clk_en1 : entity work.clock_enable
        generic map(
            g_MAX => 50000000 -- 0.5 sec (50000000)   20 for simulation
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en1
        );

    --------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity performs a 1-bit
    -- down counter
    bin_cnt1 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH => 1
        )
        port map(
            en_i => s_en1, 
            cnt_up_i => '0',
            reset => reset,
            clk => clk,
            cnt_o => s_cnt1
        );

    --------------------------------------------------------
    -- Instance (copy) of hex_7seg entity performs a 7-segment
    -- display decoder
    hex2seg : entity work.hex_7seg
        port map(
            hex_i => s_hex,
            seg_o => seg_o
        );

    --------------------------------------------------------
    -- p_mux:
    -- A sequential process that implements a multiplexer for
    -- selecting data for a single digit 
    -- signal, and switches the common anodes of each display.
    -- It also shifting internal signals.
    --------------------------------------------------------
    p_mux : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                data0_i <= data_i;
                s_hex <= data0_i;
                dig_o <= "11111110";
            else
                case s_cnt is
                    when "111" =>
                        s_hex <= data7_i;
                        dig_o <= "01111111";

                    when "110" =>
                        s_hex <= data6_i;
                        dig_o <= "10111111";

                    when "101" =>
                       s_hex <= data5_i;
                       dig_o <= "11011111";
                       
                    when "100" =>
                        s_hex <= data4_i;
                        dig_o <= "11101111";

                    when "011" =>
                        s_hex <= data3_i;
                        dig_o <= "11110111";

                    when "010" =>
                       s_hex <= data2_i;
                       dig_o <= "11111011";

                    when "001" =>
                        s_hex <= data1_i;
                        dig_o <= "11111101";

                    when others =>
                        s_hex <= data0_i;
                        dig_o <= "11111110";
                end case;
                
     
                
                case s_cnt1 is
                    when "1" =>
                    if (a='1') then
                       data_help_i <= data7_i;
                       data7_i <= data6_i;
                       data6_i <= data5_i;
                       data5_i <= data4_i;
                       data4_i <= data3_i;
                       data3_i <= data2_i;
                       data2_i <= data1_i;
                       data1_i <= data0_i;
                       data0_i <= data_help_i;
                       a <= '0';
                    end if;

                    when others =>
                       a <= '1';                      
                end case;
                
                
            end if;
        end if;
    end process p_mux;

end architecture Behavioral;
