library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_ff_rst is
    -- Entity of testbench is always empty
end entity tb_ff_rst;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_ff_rst is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_rst        : std_logic;
    signal s_data       : std_logic;
    signal s_d_q        : std_logic;
    signal s_d_q_bar    : std_logic;
    signal s_t_q        : std_logic; -- pridany vystupy pro T klopny obvod
    signal s_t_q_bar    : std_logic;

begin
    -- Connecting testbench signals with d_ff_rst entity
    -- (Unit Under Test)
    uut_d_ff_rst : entity work.d_ff_rst
        port map(
            clk   => s_clk_100MHz,
            rst   => s_rst,
            d     => s_data,
            q     => s_d_q,
            q_bar => s_d_q_bar
        );
        
    uut_t_ff_rst : entity work.t_ff_rst -- vytvorim dalsi mapovani pro T klopny obvod
        port map(
            clk   => s_clk_100MHz,
            rst   => s_rst,
            t     => s_data,
            q     => s_t_q,
            q_bar => s_t_q_bar
        );

    --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 200 ns loop -- 20 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;                -- Process is suspended forever
    end process p_clk_gen;

    --------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------
    p_reset_gen : process
    begin
        s_rst <= '0'; wait for 27 ns; -- 27 ns
        -- ACTIVATE AND DEACTIVATE RESET HERE
        s_rst <= '1'; wait for 32 ns; -- 59 ns
        s_rst <= '0';

        
        -- wait for XXX ns;
        -- s_rst <= XXX;
        -- wait for XXX ns;
        -- s_rst <= XXX;

        wait;
    end process p_reset_gen;

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_data <='0'; wait for 13 ns;
        -- nedavat nasobky 5 ns pro duvod binary_read
        -- naplnit 200 ns
        s_data <='1'; wait for 24 ns; -- 37 ns
        s_data <='0'; wait for 17 ns; -- 49 ns
        s_data <='1'; wait for 34 ns; -- 82 ns
        s_data <='0'; wait for 19 ns; -- 96 ns
        s_data <='1'; wait for 21 ns; -- 127 ns
        s_data <='0'; wait for 11 ns; -- 147 ns
        s_data <='1'; wait for 16 ns; -- 162 ns
        s_data <='0'; wait for 11 ns; -- 173 ns
        s_data <='1';
        -- DEFINE YOUR INPUT DATA HERE

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;