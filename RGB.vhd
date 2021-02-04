----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:41:54 02/04/2021 
-- Design Name: 
-- Module Name:    RGB - arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity RGB is
   generic ( N : integer := 3);
    Port ( clk : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           start : in  STD_LOGIC;
           red : in  STD_LOGIC_VECTOR (7 downto 0);
			  green : in  STD_LOGIC_VECTOR (7 downto 0);
			  blue : in  STD_LOGIC_VECTOR (7 downto 0);
           row : in  STD_LOGIC_VECTOR (N-1 downto 0);
           column : in  STD_LOGIC_VECTOR (N-1 downto 0);
			  --done_tick : out STD_LOGIC;
			  red_out : out  STD_LOGIC_VECTOR (7 downto 0);
			  green_out : out  STD_LOGIC_VECTOR (7 downto 0);
           blue_out: out  STD_LOGIC_VECTOR (7 downto 0));
end RGB;

architecture arch of RGB is
begin
------------------------------------------------------
red_processor: entity work.image_processor(arch)
	 PORT MAP (		 clk    => clk,
                   reset    => reset,
                   input  => red,
                   row    => row,
                   column => column,
					  --done_tick => done_tick,
						 output => red_out);
------------------------------------------------------
green_processor: entity work.image_processor(arch)
	 PORT MAP (		 clk    => clk,
                   reset    => reset,
                   input  => green,
                   row    => row,
                   column => column,
					  --done_tick => done_tick,
						 output => green_out);
------------------------------------------------------
blue_processor: entity work.image_processor(arch)
	 PORT MAP (		 clk    => clk,
                   reset    => reset,
                   input  => blue,
                   row    => row,
                   column => column,
					  --done_tick => done_tick,
						 output => blue_out);
						 						 

end arch;

