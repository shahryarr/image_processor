--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
-- Create Date:   20:58:35 02/04/2021
-- Design Name:   
-- Module Name:   D:/ISE projects/FPGA/final_project/RGB_TB.vhd
-- Project Name:  final_project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RGB
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RGB_TB IS
END RGB_TB;
 
ARCHITECTURE behavior OF RGB_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RGB
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
         red : IN  std_logic_vector(7 downto 0);
         green : IN  std_logic_vector(7 downto 0);
         blue : IN  std_logic_vector(7 downto 0);
         row : IN  std_logic_vector(2 downto 0);
         column : IN  std_logic_vector(2 downto 0);
         red_out : OUT  std_logic_vector(7 downto 0);
         green_out : OUT  std_logic_vector(7 downto 0);
         blue_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal red : std_logic_vector(7 downto 0) := (others => '0');
   signal green : std_logic_vector(7 downto 0) := (others => '0');
   signal blue : std_logic_vector(7 downto 0) := (others => '0');
   signal row : std_logic_vector(2 downto 0) := (others => '0');
   signal column : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal red_out : std_logic_vector(7 downto 0);
   signal green_out : std_logic_vector(7 downto 0);
   signal blue_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant T : time := 4 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RGB PORT MAP (
          clk => clk,
          reset => reset,
          start => start,
          red => red,
          green => green,
          blue => blue,
          row => row,
          column => column,
          red_out => red_out,
          green_out => green_out,
          blue_out => blue_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for T/2;
		clk <= '1';
		wait for T/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
      wait for T;	
		reset <= '0';
		start <= '1';
		column <= "100";
		row <= "100";
		wait for T;
		red <= std_logic_vector(to_unsigned(100,8));
		green <= std_logic_vector(to_unsigned(18,8));
		blue <= std_logic_vector(to_unsigned(27,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(230,8));
		green <= std_logic_vector(to_unsigned(23,8));
		blue <= std_logic_vector(to_unsigned(211,8));
		wait for T;
      red <= std_logic_vector(to_unsigned(0,8));
		green <= std_logic_vector(to_unsigned(124,8));
		blue <= std_logic_vector(to_unsigned(55,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(35,8));
		green <= std_logic_vector(to_unsigned(41,8));
		blue <= std_logic_vector(to_unsigned(88,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(51,8));
		green <= std_logic_vector(to_unsigned(25,8));
		blue <= std_logic_vector(to_unsigned(37,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(19,8));
		green <= std_logic_vector(to_unsigned(72,8));
		blue <= std_logic_vector(to_unsigned(101,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(59,8));
		green <= std_logic_vector(to_unsigned(17,8));
		blue <= std_logic_vector(to_unsigned(7,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(0,8));
		green <= std_logic_vector(to_unsigned(0,8));
		blue <= std_logic_vector(to_unsigned(16,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(254,8));
		green <= std_logic_vector(to_unsigned(254,8));
		blue <= std_logic_vector(to_unsigned(254,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(201,8));
		green <= std_logic_vector(to_unsigned(101,8));
		blue <= std_logic_vector(to_unsigned(222,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(17,8));
		green <= std_logic_vector(to_unsigned(117,8));
		blue <= std_logic_vector(to_unsigned(1,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(74,8));
		green <= std_logic_vector(to_unsigned(5,8));
		blue <= std_logic_vector(to_unsigned(52,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(2,8));
		green <= std_logic_vector(to_unsigned(2,8));
		blue <= std_logic_vector(to_unsigned(2,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(5,8));
		green <= std_logic_vector(to_unsigned(5,8));
		blue <= std_logic_vector(to_unsigned(2,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(12,8));
		green <= std_logic_vector(to_unsigned(255,8));
		blue <= std_logic_vector(to_unsigned(255,8));
		wait for T;
		red <= std_logic_vector(to_unsigned(63,8));
		green <= std_logic_vector(to_unsigned(32,8));
		blue <= std_logic_vector(to_unsigned(77,8));
      wait;
   end process;

END;
