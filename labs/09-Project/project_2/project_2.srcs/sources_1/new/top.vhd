library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity top is
    Port ( CLK100MHZ : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (15 downto 0);
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           BTNC : in STD_LOGIC;
           BTNU : in STD_LOGIC;
           BTND : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTNR : in STD_LOGIC);
end top;

------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------
architecture Behavioral of top is
  -- No internal signals
begin
  driver_seg_4 : entity work.driver_7seg_4digits
      port map(
          clk        => CLK100MHZ,
          write      => BTNC,
          up		 => BTNU,
          down		 => BTND,
          left		 => BTNL,
          right		 => BTNR,
          stop		 => SW(15),
          program_p	 => SW(14),
          program_s	 => SW(13),
          reset      => SW(9),
          dot        => SW(6),
          data0_i(5) => SW(5),
          data0_i(4) => SW(4),
          data0_i(3) => SW(3),
          data0_i(2) => SW(2),
          data0_i(1) => SW(1),
          data0_i(0) => SW(0),
                    
          dp_i => "11111111",
          dp_o => DP,
          
          seg_o(6) => CA,
          seg_o(5) => CB,
          seg_o(4) => CC,
          seg_o(3) => CD,
          seg_o(2) => CE,
          seg_o(1) => CF,
          seg_o(0) => CG,
          
          dig_o => AN (7 downto 0)
      );

  -- Disconnect the top four digits of the 7-segment display
  --AN(7 downto 4) <= b"1111";

end architecture Behavioral;


