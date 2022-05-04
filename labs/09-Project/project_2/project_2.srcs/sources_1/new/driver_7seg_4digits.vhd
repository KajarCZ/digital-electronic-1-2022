------------------------------------------------------------
--
-- Driver for 4-digit 7-segment display.
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
        clk     	: in  std_logic;
        reset   	: in  std_logic;
        dot			: in  std_logic;
        write		: in  std_logic;
        up			: in  std_logic;
        down		: in  std_logic;
        left		: in  std_logic;
        right		: in  std_logic;
        stop		: in  std_logic;
        program_p	: in  std_logic;
        program_s	: in  std_logic;
        -- 5-bit input values for individual digits
        data0_i : in  std_logic_vector(6 - 1 downto 0);
        -- 8-bit input value for decimal points
        dp_i    : in  std_logic_vector(8 - 1 downto 0);
        -- Decimal point for specific digit
        dp_o    : out std_logic;
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

	-- Char variables
    signal ch_conv 				: unsigned(6 - 1 downto 0) := b"0_00000";
    signal ch_0    				: std_logic_vector(6 - 1 downto 0) := "011101"; -- T
    signal ch_1    				: std_logic_vector(6 - 1 downto 0) := "100001"; -- X
    signal ch_2    				: std_logic_vector(6 - 1 downto 0) := "001110"; -- E
    signal ch_3    				: std_logic_vector(6 - 1 downto 0) := "011101"; -- T
    signal ch_4    				: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_5    				: std_logic_vector(6 - 1 downto 0) := "001110"; -- E
    signal ch_6    				: std_logic_vector(6 - 1 downto 0) := "010110"; -- M
    signal ch_7    				: std_logic_vector(6 - 1 downto 0) := "000000"; -- O
    signal ch_8    				: std_logic_vector(6 - 1 downto 0) := "011100"; -- S
    signal ch_9    				: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_10    			: std_logic_vector(6 - 1 downto 0) := "011101"; -- T
    signal ch_11    			: std_logic_vector(6 - 1 downto 0) := "011110"; -- U
    signal ch_12    			: std_logic_vector(6 - 1 downto 0) := "011001"; -- P
    signal ch_13    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_14    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_15    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_16    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_17    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_18    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_19    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_20    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_21    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_22    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_23    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_24    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_25    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_26    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_27    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_28    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_29    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_30    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_31    			: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal ch_last 				: std_logic_vector(6 - 1 downto 0) := "111111"; -- space
    signal dots					: std_logic_vector(32 - 1 downto 0) := "11111111111111111111111111111111";
    signal time_between			: unsigned(10 downto 0) := b"000_1111_1010";
    
    -- Char max and min values
    constant ch_min       : unsigned(6 - 1 downto 0) := b"00_0000";
    constant ch_max       : unsigned(6 - 1 downto 0) := b"11_1111";
    
    --Other constants
    constant c_change 	   : unsigned(10 downto 0) := b"000_1111_1010"; --1/10 second (time beetween value of "time between" constants  
    constant c_change_zero : unsigned(10 downto 0) := b"000_0000_0000"; --0 second   
    constant text_lenght   : unsigned(4 downto 0) := b"1_1111";
    
    -- Specific values for local counter
    constant c_DELAY_4SEC : unsigned(10 downto 0) := b"111_1101_0000";
    constant c_DELAY_2SEC : unsigned(10 downto 0) := b"011_1110_1000";
    constant c_DELAY_1SEC : unsigned(10 downto 0) := b"001_1111_0100";
    constant c_ZERO       : unsigned(10 downto 0) := b"000_0000_0000";
    constant c_MAX        : unsigned(10 downto 0) := b"111_1111_1111";
    
    -- Internal clock enable
    signal s_en  : std_logic;
    -- Internal 2-bit counter for multiplexing 4 digits
    signal s_cnt : std_logic_vector(3 - 1 downto 0);
    signal s_cnt_1 : unsigned(10 downto 0);
    signal s_cnt_2 : unsigned(10 downto 0);
    -- Internal 4-bit value for 7-segment decoder
    signal s_hex : std_logic_vector(6 - 1 downto 0);

begin
    --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates 
    -- an enable pulse every 4 ms
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 200000 --4periody pro simulaci a ne 400 000 (jinak 400 000ns -->4ms)
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
        );

    --------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity performs a 2-bit
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
    -- selecting data for a single digit, a decimal point 
    -- signal, and switches the common anodes of each display.
    --------------------------------------------------------
    p_mux : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                s_hex <= ch_0;
                dp_o  <= dots(0);
                dig_o <= "11111110";
            else
                case s_cnt is
                    when "111" =>
                        s_hex <= ch_7;
                        dp_o  <= dots(7);
                        dig_o <= "01111111";

					when "110" =>
                        s_hex <= ch_6;
                        dp_o  <= dots(6);
                        dig_o <= "10111111";

					when "101" =>
                        s_hex <= ch_5;
                        dp_o  <= dots(5);
                        dig_o <= "11011111";

					when "100" =>
                        s_hex <= ch_4;
                        dp_o  <= dots(4);
                        dig_o <= "11101111";

                    when "011" =>
                        s_hex <= ch_3;
                        dp_o  <= dots(3);
                        dig_o <= "11110111";

                    when "010" =>
                        s_hex <= ch_2;
                        dp_o  <= dots(2);
                        dig_o <= "11111011";

                    when "001" =>
                       s_hex <= ch_1;
                       dp_o  <= dots(1);
                       dig_o <= "11111101";

                    when others =>
                    	if (program_s = '1') then
                            s_hex <= data0_i;
                        else
                        	s_hex <= ch_0;
                        end if;
                        dp_o  <= dots(0);
                        dig_o <= "11111110";
                end case;
            end if;
        end if;
    end process p_mux;


	p_change_char : process(clk)
    	begin
        	if rising_edge(clk) then
            	if (reset = '1') then   -- Synchronous reset
                	s_cnt_1   <= c_ZERO;  -- Clear delay counter
                
            	elsif (program_s = '1') then
            		if (write = '1') then
                		ch_0 <= data0_i;
                	end if;
            
            	elsif (program_p = '1') then
            		if (up = '1') then
                		if (s_cnt_2 < c_change) then
                     		s_cnt_2 <= s_cnt_2 + 1;
                 		else
                    		-- Change character
--                     		if (ch_min < unsigned(ch_0) and unsigned(ch_0) < ch_max) then
--                        		ch_conv <= unsigned(ch_0);
--                    			ch_conv <= ch_conv + 1;
--                        		ch_0	<= std_logic_vector(ch_conv);
--							end if;
                                ch_conv <= unsigned(ch_0);
                    			ch_conv <= ch_conv + 1;
                        		ch_0	<= std_logic_vector(ch_conv);
                     		-- Reset local counter value
                     		s_cnt_2 <= c_change_zero;
                 		end if;
                    
                	elsif (down = '1') then
                		if (s_cnt_2 < c_change) then
                     		s_cnt_2 <= s_cnt_2 + 1;
                 		else
                    		-- Change character
--                     		if (ch_min < unsigned(ch_0) and unsigned(ch_0) < ch_max) then
--                        		ch_conv <= unsigned(ch_0);
--                    			ch_conv <= ch_conv - 1;
--                        		ch_0	<= std_logic_vector(ch_conv);
--							end if;
                                ch_conv <= unsigned(ch_0);
                    			ch_conv <= ch_conv - 1;
                        		ch_0	<= std_logic_vector(ch_conv);
                     		-- Reset local counter value
                     		s_cnt_2 <= c_change_zero;
                 		end if;
                	end if;

            	elsif (s_en = '1' and stop = '0') then
                	-- Every 2 ms, CASE checks the value of the s_state 
                	-- variable and changes to the next state according 
                	-- to the delay value.
                
                	-- wait some time sec
                    
                	-- Count up to time_between
                 	if (s_cnt_1 < time_between) then
                     	s_cnt_1 <= s_cnt_1 + 1;
                 	else
                    	-- Move chars to the next state
                     	ch_last <= ch_31;
                        ch_31 <= ch_30;
                        ch_30 <= ch_29;
                        ch_29 <= ch_28;
                        ch_28 <= ch_27;
                        ch_27 <= ch_26;
                        ch_26 <= ch_25;
                        ch_25 <= ch_24;
                     	ch_24 <= ch_23;
                     	ch_23 <= ch_22;
                     	ch_22 <= ch_21;
                        ch_21 <= ch_20;
                        ch_20 <= ch_19;
                        ch_19 <= ch_18;
                        ch_18 <= ch_17;
                     	ch_17 <= ch_16;
                     	ch_16 <= ch_15;
                     	ch_15 <= ch_14;
                        ch_14 <= ch_13;
                        ch_13 <= ch_12;
                        ch_12 <= ch_11;
                        ch_11 <= ch_10;
                     	ch_10 <= ch_9;
                     	ch_9  <= ch_8;
                     	ch_8  <= ch_7;
                        ch_7  <= ch_6;
                        ch_6  <= ch_5;
                        ch_5  <= ch_4;
                        ch_4  <= ch_3;
                     	ch_3  <= ch_2;
                     	ch_2  <= ch_1;
                     	ch_1  <= ch_0;
                     	ch_0  <= ch_last;
                     	-- Reset local counter value
                     	s_cnt_1 <= c_ZERO;
                 	end if;

            	end if; -- Synchronous reset            
            	if (program_s = '1' or program_p = '1' or stop = '1') then
            		-- move text left or right by bottons
                    if (left = '1') then
                    	if (s_cnt_2 < c_change) then
                     		s_cnt_2 <= s_cnt_2 + 1;
                 		else
                    		-- Shift the text
                            ch_last <= ch_31;
                            ch_31 <= ch_30;
                        	ch_30 <= ch_29;
                        	ch_29 <= ch_28;
                            ch_28 <= ch_27;
                        	ch_27 <= ch_26;
                        	ch_26 <= ch_25;
                        	ch_25 <= ch_24;
                     		ch_24 <= ch_23;
                     		ch_23 <= ch_22;
                     		ch_22 <= ch_21;
                        	ch_21 <= ch_20;
                        	ch_20 <= ch_19;
                        	ch_19 <= ch_18;
                        	ch_18 <= ch_17;
                     		ch_17 <= ch_16;
                     		ch_16 <= ch_15;
                     		ch_15 <= ch_14;
                            ch_14 <= ch_13;
                        	ch_13 <= ch_12;
                        	ch_12 <= ch_11;
                        	ch_11 <= ch_10;
                     		ch_10 <= ch_9;
                     		ch_9  <= ch_8;
                     		ch_8  <= ch_7;
                        	ch_7  <= ch_6;
                        	ch_6  <= ch_5;
                        	ch_5  <= ch_4;
                        	ch_4  <= ch_3;
                     		ch_3  <= ch_2;
                     		ch_2  <= ch_1;
                     		ch_1  <= ch_0;
                     		ch_0  <= ch_last;
                     		-- Reset local counter value
                     		s_cnt_2 <= c_change_zero;
                 		end if;
                    elsif (right = '1') then
                    	if (s_cnt_2 < c_change) then
                     		s_cnt_2 <= s_cnt_2 + 1;
                 		else
                            -- Shift the text
                     		ch_last <= ch_0;
                     		ch_0  <= ch_1;
                     		ch_1  <= ch_2;
                     		ch_2  <= ch_3;
                        	ch_3  <= ch_4;
                        	ch_4  <= ch_5;
                       		ch_5  <= ch_6;
                        	ch_6  <= ch_7;
                            ch_7  <= ch_8;
                     		ch_8  <= ch_9;
                     		ch_9  <= ch_10;
                        	ch_10 <= ch_11;
                        	ch_11 <= ch_12;
                       		ch_12 <= ch_13;
                        	ch_13 <= ch_14;
                            ch_14 <= ch_15;
                        	ch_15 <= ch_16;
                       		ch_16 <= ch_17;
                        	ch_17 <= ch_18;
                            ch_18 <= ch_19;
                        	ch_19 <= ch_20;
                       		ch_20 <= ch_21;
                        	ch_21 <= ch_22;
                            ch_22 <= ch_23;
                        	ch_23 <= ch_24;
                       		ch_24 <= ch_25;
                        	ch_25 <= ch_26;
                            ch_26 <= ch_27;
                            ch_27 <= ch_28;
                        	ch_28 <= ch_29;
                            ch_29 <= ch_30;
                        	ch_30 <= ch_31;
                     		ch_31 <= ch_last;
                     		-- Reset local counter value
                     		s_cnt_2 <= c_change_zero;
                 		end if;
                    end if;
            	end if;
                
                if (program_s = '0' or program_p = '0' or stop = '0') then
                	--set speed of text rolling
                    if (up = '1') then
                    	if (s_cnt_2 < c_change) then
                     		s_cnt_2 <= s_cnt_2 + 1;
                 		else
                    		-- Increse the speed
                     		if (c_ZERO <= time_between and time_between <= c_MAX) then
                        		time_between <= time_between - 1;
							end if;
                     		-- Reset local counter value
                     		s_cnt_2 <= c_change_zero;
                 		end if;
                    elsif (down = '1') then
                    	if (s_cnt_2 < c_change) then
                     		s_cnt_2 <= s_cnt_2 + 1;
                 		else
                    		-- decrese the speed
                     		if (c_ZERO <= time_between and time_between <= c_MAX) then
                        		time_between <= time_between + 1;
							end if;
                     		-- Reset local counter value
                     		s_cnt_2 <= c_change_zero;
                 		end if;
                    end if;
                end if;
        	end if; -- Rising edge
    	end process p_change_char;
end architecture behavioral;