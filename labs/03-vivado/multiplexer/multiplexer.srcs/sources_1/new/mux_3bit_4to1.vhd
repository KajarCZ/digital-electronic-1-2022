library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_3bit_4to1 is
    port(        
        a_i     : in    std_logic_vector(3 - 1 downto 0);   --A input
        b_i     : in    std_logic_vector(3 - 1 downto 0);   --B input
        c_i     : in    std_logic_vector(3 - 1 downto 0);   --C input
        d_i     : in    std_logic_vector(3 - 1 downto 0);   --D input
        
        sel_i   : in  std_logic_vector(2 - 1 downto 0);	    --select
        y_o     : out	std_logic_vector(3 - 1 downto 0)    --MUX output
    );
end mux_3bit_4to1;

architecture Behavioral of mux_3bit_4to1 is

begin
    with sel_i select
    y_o <= a_i when "00",                                   -- If sel_i = "00" then y_o = a_i
           b_i when "01",
           c_i when "10",
           d_i when others;                                 -- All other combinations

end architecture  Behavioral;
