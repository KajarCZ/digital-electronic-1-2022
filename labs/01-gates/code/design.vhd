------------------------------------------------------------
--
-- Example of basic gates in VHDL.
-- EDA Playground
--
-- Copyright (c) 2019-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;                -- Standard library
use ieee.std_logic_1164.all; -- Package for data type
                             -- and logic operations

------------------------------------------------------------
-- Entity declaration for basic gates
------------------------------------------------------------
entity gates is
    port(
        c_i      : in  std_logic; -- Three data inputs
        b_i      : in  std_logic;
        a_i      : in  std_logic;
        f_org_o  : out std_logic; -- Original function
        f_nand_o : out std_logic; -- NAND version
        f_nor_o  : out std_logic  -- NOR version
    );
end entity gates;

------------------------------------------------------------
-- Architecture body for basic gates
------------------------------------------------------------
architecture dataflow of gates is
begin
    f_org_o  <= (not(b_i) and a_i) or (not(c_i) and not(b_i));
    f_nand_o <= (not(b_i) nand (a_i)) nand (not(c_i) nand not(b_i)); -- MODIFY THIS FUNCTION
    f_nor_o  <= not(((b_i) nor not(a_i)) nor ((c_i) nor (b_i)));  -- MODIFY THIS FUNCTION
end architecture dataflow;